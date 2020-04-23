import 'dart:async';
import 'dart:io';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:system_info/system_info.dart';
import 'package:basic_utils/basic_utils.dart';
//import 'package:encrypt/encrypt.dart';

const String authBaseUrl = "http://localhost:3000/";
const int MEGABYTE = 1024 * 1024;

class ServerResponse {
  String error;
  num status;
  String response;

  ServerResponse(this.status, this.response, this.error);
}

class UserRepository {
  String _jwtToken;
  String deviceId;
  String _deviceInfo;
  String user;
  String master;

  void init() {
    //var meow = X509Utils.generateKeyPair(keySize: 2048);
    //final plainText = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit';
    //final encrypter = Encrypter(RSA(publicKey: meow.publicKey, privateKey: meow.privateKey));
    //final encrypted = encrypter.encrypt(plainText);
    //final decrypted = encrypter.decrypt(encrypted);
    Hive.init(Directory.current.path);
    String platform = Platform.operatingSystem+":"+Platform.operatingSystemVersion+":"+Platform.localHostname+":"+Platform.numberOfProcessors.toString()+":"+Platform.resolvedExecutable;
    final processor = SysInfo.processors[0];
    platform += ":${SysInfo.getTotalPhysicalMemory() ~/ MEGABYTE}:${SysInfo.kernelBitness}";
    platform += ":${processor.architecture}:${processor.name}:${processor.socket}:${processor.vendor}";
    var bytes = convert.utf8.encode(platform);
    var digest = convert.base64Encode(bytes);
    this.deviceId = digest;
    this._deviceInfo = platform;
    return;
    //print(_deviceInfo);
    //final key = X509Utils.encodeRSAPrivateKeyToPem(meow.privateKey);
    //print(key);
    //print(X509Utils.privateKeyFromPem(key));
  }

  Future<bool> _hasNetwork() async {
    return true;
    //try {
    //  final result = await InternetAddress.lookup('claudit-software.co.ro');
    //  if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
    //    return true;
    //  }
    //  return false;
    //} on SocketException catch (_) {
    //  return false;
    //}
  }

  Future<ServerResponse> authenticate({
    @required String master,
    @required String username,
    @required String password,
  }) async {
    if(await _hasNetwork() == false) {
      return ServerResponse(1001, '', 'Fie nu exista conexiune la internet, fie serverul nu a putut fi contactat. Verificati daca sunteti conectat la internet / Incercat mai tarziu.');
    }
    var res = await http.post(
      authBaseUrl + 'login',
      headers: { 'Content-Type': 'application/json', 'device': this.deviceId },
      body: convert.json.encode({"master": master, "user": username, "pass": password})
    );

    var body = convert.json.decode(res.body);
    return ServerResponse(res.statusCode, body["res"], body["error"]);
  }

  Future<void> deleteToken() async {
    this._jwtToken = null;
    return;
  }

  Future<void> persistToken(String master, String user, String token) async {
    this._jwtToken = token;
    this.master = master;
    this.user = user;
    print(this.deviceId);
    print(master);
    print(user);
    print(token);
    var box = await Hive.openBox('lastLogin');
    await box.put('username', user);
    await box.put('master', master);
    return;
  }

  Future<ServerResponse> register({
    @required String master,
    @required String username,
    @required String password,
    @required String email,
    @required String phone,
  }) async {
    if(await _hasNetwork() == false) {
      return ServerResponse(1001, '', 'Fie nu exista conexiune la internet, fie serverul nu a putut fi contactat. Verificati daca sunteti conectat la internet / Incercat mai tarziu.');
    }
    var meow = X509Utils.encodeRSAPublicKeyToPem(X509Utils.generateKeyPair(keySize: 2048).publicKey);
    var data = convert.json.encode({"master": master, "user": username, "pass": password, "email": email, "phone": phone, "pubKey": meow, "description": _deviceInfo, "deviceId": deviceId});
    var res = await http.post(authBaseUrl + 'new_user', headers: { 'Content-Type': 'application/json' }, body: data);
    var body = convert.json.decode(res.body);
    return ServerResponse(res.statusCode, body["res"], body["error"]);
  }

  Future<String> getDefaultLoginValues() async {
    var box = await Hive.openBox('lastLogin');
    var user = box.get('username');
    var master = box.get('master');
    if(user == null || master == null || user.isEmpty || master.isEmpty) {
      return "";
    }
    return "$master:$user";
  }

  Future<ServerResponse> verify({
    @required String master,
    @required String username,
    @required String url,
    @required String sms,
    @required String em,
  }) async {
    var data = convert.json.encode({"master": master, "user": username, "email": em, "sms": sms});
    var res = await http.post(authBaseUrl + url, headers: { 'Content-Type': 'application/json' }, body: data);
    var body = convert.json.decode(res.body);
    return ServerResponse(res.statusCode, body["res"], body["error"]);
  }

  bool hasToken() {
    return this._jwtToken != null && this._jwtToken.isNotEmpty;
  }
}
