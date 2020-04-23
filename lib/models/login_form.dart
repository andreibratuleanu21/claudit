import 'package:flutter/material.dart';
import "package:user_repository/user_repository.dart";
import "package:claudit/models/navigator.dart";

class LoginFormModel with ChangeNotifier {
  bool isLoading = false;
  bool displayRegister = false;
  bool displayVerification = false;
  String _verType = "";
  String prevPass = "";
  String user = "";
  String master = "";
  String errorMessage = "";
  UserRepository _userRepository;

  LoginFormModel(UserRepository repo) {
    this._userRepository = repo;
    this._userRepository.getDefaultLoginValues().then((data) {
      if(data.indexOf(':') != -1) {
        this._setDefault(data.split(':'));
      }
    });
  }

  void _setDefault(List<String> arr) {
    this.master = arr[0];
    this.user = arr[1];
    notifyListeners();
  }

  void submitLogin(String master, String user, String pass, NavigatorModel routeState) {
    isLoading = true;
    notifyListeners();
    _userRepository.authenticate(master: master, username: user, password: pass).then((data) {
      if (data.status > 299 && data.error.isNotEmpty) {
        if(data.status == 404) {
          displayVerification = true;
          _verType = 'new_device';
        }
        errorMessage = data.error;
      }
      if(data.status == 200) {
        _userRepository.persistToken(master, user, data.response);
        routeState.changeRoute('home');
      }
      isLoading = false;
      notifyListeners();
    });
  }

  void startRegister(String master, String user, String pass) {
    this.displayRegister = true;
    this.master = master;
    this.user = user;
    this.prevPass = pass;
    notifyListeners();
  }

  void submitRegister(String email, String phone) {
    isLoading = true;
    notifyListeners();
    _userRepository.register(master: this.master, username: this.user, password: this.prevPass, email: email, phone: phone).then((data) {
      if (data.status > 299 && data.error.isNotEmpty) {
        errorMessage = data.error;
      }
      displayVerification = true;
      _verType = 'register';
      isLoading = false;
      notifyListeners();
    });
  }

  void submitVerification(String code) {
    isLoading = true;
    notifyListeners();
    _userRepository.verify(username: this.user, master: this.master, em: code, sms: '1234', url: this._verType).then((data) {
      if (data.status > 299 && data.error.isNotEmpty) {
        errorMessage = data.error;
      }
      displayVerification = false;
      _verType = '';
      isLoading = false;
      if(_verType == 'register') {
        this.errorMessage = data.response;
        this.displayRegister = false;
      }
      notifyListeners();
    });
  }

  void dismissError() {
    errorMessage = "";
    notifyListeners();
  }
}
