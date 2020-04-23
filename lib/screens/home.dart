import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
import 'package:claudit/models/navigator.dart';
import 'package:claudit/common/calendar.dart';
import 'package:claudit/common/customDataToolbarTable.dart';

class Home extends StatefulWidget {
  final NavigatorModel routeState;

  const Home (this.routeState): super();

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static final now = new DateTime.now();
  MyDateObject _selectedDate = MyDateObject(now.day, now.month, now.year);

  void _selectNewDate(MyDateObject newlySelected) {
    setState(() {
      _selectedDate = newlySelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          List<MyColumnConfig> cols = [
            MyColumnConfig('CUI', true, 'Codul de indentificare fiscala', null),
            MyColumnConfig('Denumire', false, '', null),
          ];
          Map<String, List> rows = {
            "31877791": ["31877791", "EDELINE INVEST COMPANY SRL"],
            "20808478": ["20808478", "CIAMA GHEORGHE PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "31822958": ["31822958", "SUCIU GHEORGHE DORIN PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "29713126": ["29713126", "GHEORGHE O. RAMONA-ELISABETA - MEDIC SPECIALIST OTORINOLARINGOLOGIE"],
            "39672341": ["39672341", "ȘTEFĂNESCU M. MARINELA PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "34288960": ["34288960", "LASCU RALUCA SILVIA PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "32736960": ["32736960", "POTINTEU CLAUDIU NICOLAE PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "27777239": ["27777239", "NEAG IOAN VIOREL AUTO ÎNTREPRINDERE INDIVIDUALĂ"],
            "38703636": ["38703636", "GROZA L. MIHAELA PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "21242821": ["21242821", "BUZGARIU SILVIA PERSOANA FIZICA AUTORIZATA"],
            "31597139": ["31597139", "BARTA Ş. ŞTEFAN PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "26821190": ["26821190", "LUCA NICOLAE ŞTEFAN PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "32309684": ["32309684", "VIŞAN  OVIDIU DANIEL- CABINET INDIVIDUAL DE PSIHOLOGIE"],
            "33147149": ["33147149", "BORZA DANIEL NICOLAE PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "20753291": ["20753291", "STAN A. SILVIA - PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "20294008": ["20294008", "VLAD MARIA PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "35477100": ["35477100", "COSTEA P. ELENA - AGENT DE ASIGURARI"],
            "28834790": ["28834790", "CIOICA ADRIAN VASILE PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "37983910": ["37983910", "BOTA DORIN DRAGOMIR PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "35112139": ["35112139", "CURMENŢ BIANCA TOMINA PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "38201664": ["38201664", "MĂDEAN V. DORINA-ELENA - ASISTENT MEDICAL"],
            "27143991": ["27143991", "VODĂ ADRIANA MARIANA PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "34179491": ["34179491", "SÎRBU O. ALEXANDRU PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "38220720": ["38220720", "ROMAN DIANA NICOLETA PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "27630083": ["27630083", "NEGREA DAN COSMIN PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "25351740": ["25351740", "CÎMPEAN MIHAELA PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "33040478": ["33040478", "FRĂŢILĂ ANA RODICA PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "28588033": ["28588033", "STANCIU IULIA DORINA ÎNTREPRINDERE INDIVIDUALĂ"],
            "27602512": ["27602512", "TRUŢA EMIL DANIEL PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "35801680": ["35801680", "MOCEAN  IOANA-SIMONA -MEDIC DENTIST"],
            "38876343": ["38876343", "RÎȘTEIU I. IOANA NATALIA PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "32258289": ["32258289", "AVRĂMUŢ DAN ANDREI PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "29757815": ["29757815", "ŞANDRU IOAN SORIN SÂNTIMBRU PFA"],
            "34327920": ["34327920", "IUONUŢ IONELA FELICIA PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "20590780": ["20590780", "LUCA I.IOAN PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "27494712": ["27494712", "GLIGOR MARGARETA PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "34729137": ["34729137", "LUDOŞAN IOAN CRISTIAN PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "32488369": ["32488369", "HORHAT SIMONA IOANA PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "30938378": ["30938378", "PLĂCINTĂ TATIANA IOANA PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "38098306": ["38098306", "ROMCEA IOANA DANIELA PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "33258120": ["33258120", "ONISIE FLORIN VALENTIN PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "27832058": ["27832058", "VOROBEŢ ROXANA ÎNTREPRINDERE INDIVIDUALĂ"],
            "31883491": ["31883491", "BRICIU DOMIN PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "31644885": ["31644885", "CIMUCA IONEL VICTOR PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "31047518": ["31047518", "CAZACU V. ROXANA-IOANA - TRADUCATOR SI INTERPRET"],
            "29546931": ["29546931", "OANCEA SEBASTIAN CRISTIAN PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "20859072": ["20859072", "POPESCU NICOLAE PERSOANA FIZICA"],
            "38404774": ["38404774", "KOLEVA SLAVINA EMILOVA PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "33147270": ["33147270", "GANGA NICOLAE ALEXANDRU PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "31913134": ["31913134", "RÎŞTEIU PETRU DAN PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "34211223": ["34211223", "DÂRLEA CAROLINA PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "23626217": ["23626217", "BITEA RALUCA RAMONA PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "39570570": ["39570570", "WOLF EDUARD GEORGE PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "20807952": ["20807952", "JURJ ANA OVI PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "24535460": ["24535460", "CONTOR RAFILA PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "27653923": ["27653923", "OLTEAN ELENA VALEA LARGĂ PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "34990808": ["34990808", "COSMA CAMELIA RAMONA PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "25568481": ["25568481", "MURARU CORNEL PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "39213900": ["39213900", "SIMU CORNEL FLORIN PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "20559679": ["20559679", "LUPSE IOAN GEORGE PERLA CADOURILOR PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "27685240": ["27685240", "HÎRCEAGĂ IOAN AUTO PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "31784633": ["31784633", "TODEA IOAN SABINA PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "28834812": ["28834812", "ANDREIU ANCA ELENA PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "37424560": ["37424560", "BOTTA  ANNEMARIE MEDITAŢII GERMANĂ"],
            "32297385": ["32297385", "GHEŢE MIHAI IONUŢ PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "35132616": ["35132616", "BODOR ALINA ANDRADA PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "28762813": ["28762813", "BOTA CIPRIAN ALEXANDRU AGRO PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "26566578": ["26566578", "CÎRMACIU IOAN OVIDIU ÎNTREPRINDERE INDIVIDUALĂ"],
            "27338136": ["27338136", "LUDUŞAN E. EMANOIL PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "31672230": ["31672230", "OANA MARIA ELENA PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "32101690": ["32101690", "STANCIU IOAN MARIA PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "17217560": ["17217560", "PAŞCA NICOLAE PAŞCA ÎNTREPRINDERE INDIVIDUALĂ"],
            "21362585": ["21362585", "JARDA I.  MIRA - PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "27587064": ["27587064", "RUSU VICTOR BITI PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "25145457": ["25145457", "BOGDAN ELENA ANA PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "33489273": ["33489273", "DRAGOMIR I. ANDREI PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "34414236": ["34414236", "TÎRZIU M. NICOLAE PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "34970444": ["34970444", "FLOREA OCTAVIAN IOAN ÎNTREPRINDERE INDIVIDUALĂ"],
            "25682019": ["25682019", "TRUŢA IOAN TRANS ÎNTREPRINDERE INDIVIDUALĂ"],
            "35065967": ["35065967", "MUNTEAN ELENA PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "35426387": ["35426387", "POPTEAN OLIMPIA - AGENT DE ASIGURARE"],
            "34990158": ["34990158", "CRISTEA GHE. PARASCHIVA PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "24666287": ["24666287", "ŢILI ILEANA PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "29632200": ["29632200", "CHIRA MARIN IOSIF COCEŞTI PFA"],
            "20725194": ["20725194", "CIPARIU N. ANCA-EMILIA - CABINET STOMATOLOGIC"],
            "30992741": ["30992741", "TURLAŞ LUCIAN IOAN ÎNTREPRINDERE INDIVIDUALĂ"],
            "31623980": ["31623980", "SUCIU CAMELIA MONICA ÎNTREPRINDERE INDIVIDUALĂ"],
            "38308653": ["38308653", "ONACĂ ADRIAN-NICOLAE - FOTBALIST PROFESIONIST"],
            "20590399": ["20590399", "IANCU PETRU SANDU PERSOANA FIZICA"],
            "29651910": ["29651910", "MOISE VALENTINA APIS PFA"],
            "34119201": ["34119201", "HĂDĂRIG  MARCELA - TRADUCATOR AUTORIZAT"],
            "39654388": ["39654388", "PLEȘA MARIUS DARIUS ÎNTREPRINDERE INDIVIDUALĂ"],
            "27696975": ["27696975", "SUCIU CLAUDIU STELIAN APIS PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "34124160": ["34124160", "CÂNDEA  LIDIA - EXPERT TEHNIC JUDICIAR - SEDIU SECUNDAR AL MANAGER CM IPURL"],
            "27503373": ["27503373", "CIUNGAN IOAN PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "37198692": ["37198692", "STĂNILĂ DELIA PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "38433850": ["38433850", "SABĂU TUDOR-CĂTĂLIN - SPORTIV"],
            "20608089": ["20608089", "MAIER I. IONUŢA-CRISTINA - TRADUCATOR"],
            "29183127": ["29183127", "ZBUCHEA DAN PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "25909368": ["25909368", "ERDELYI IOSIF PERSOANA FIZICA AUTORIZATA"],
            "31550829": ["31550829", "POPA SABIN ISIDOR PERSOANĂ FIZICĂ AUTORIZATĂ"],
            "1234": ["1234", "meow"]
          };

          return Center(
            child: Container(
              width: 1200,
              child: CustomScrollView(
                primary: false,
                slivers: <Widget>[
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 32, 16, 32),
                    sliver: SliverGrid.extent(
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      maxCrossAxisExtent: 600,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: CustomDataToolbarTable('Entiatile mele', cols, rows)
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          child: Calendar(_selectedDate, this._selectNewDate)
                        )
                      ]
                    )
                  )
                ]
              )
            )
          );
        }
      )
    );
  }
}
