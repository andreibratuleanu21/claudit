import 'package:flutter/material.dart';
import 'package:user_repository/user_repository.dart';
import 'package:provider/provider.dart';
import 'package:claudit/common/theme.dart';
import 'package:claudit/common/calendar.dart';
import 'package:claudit/models/login_form.dart';
import 'package:claudit/models/navigator.dart';
import 'package:claudit/screens/login_page.dart';
import 'package:claudit/screens/home.dart';
import 'package:mdi/mdi.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userRepo = UserRepository();
    userRepo.init();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginFormModel(userRepo)
        ),
        ChangeNotifierProvider(
          create: (context) => NavigatorModel(),
        )
      ],
      child: MaterialApp(
        title: 'Claudit Contabilitate',
        theme: appTheme,
        home: NavigatorElement()
      ),
    );
  }
}

class LinkDT {
  String label;
  MdiIconData icon;
  String path;
  LinkDT(this.label, this.icon, this.path);
}

class NavigatorElement extends StatelessWidget {

  final List<LinkDT> linksList = [
    LinkDT('Pagina principala', Mdi.home, 'home'),
    LinkDT('Intrari', Mdi.arrowRightBox, 'intrari'),
    LinkDT('Iesiri', Mdi.arrowLeftBox, 'iesiri'),
    LinkDT('Casa', Mdi.homeCurrencyUsd, 'casa'),
    LinkDT('Banca', Mdi.bank, 'banca'),
    LinkDT('Mijloace Fixe', Mdi.factoryIcon, 'mijloace_fixe'),
    LinkDT('Salarii', Mdi.briefcaseAccount, 'salarii'),
    LinkDT('Diverse', Mdi.folderTable, 'diverse'),
    LinkDT('Setari', Mdi.cog, 'settings')
  ];

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<NavigatorModel>(context);
    if (state.currentRoute == 'login') {
      return LoginForm(state);
    }

    var selected = MyDateObject(12,4,2020);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        bottom: MyLinearProgressIndicator(
          value: 0.75
        ),
        title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [ 
                  Text("RO31877791: Ediline Invest Company SRL", style: TextStyle(fontSize: 14)),
                ]
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(child:Icon(Mdi.chevronLeft,size:18),onTap:() => print('meow')),
                  Text(selected.prettyPrint(), style: TextStyle(fontSize: 14)),
                  InkWell(child:Icon(Mdi.chevronRight,size:18),onTap:() => print('meow'))
                ]
              )
            ]
          )
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: linksList.map((link) => ListTile(
            title: Row(children: [Padding(padding: EdgeInsets.only(right: 8), child: Icon(link.icon)), Text(link.label)]),
            onTap: () {
              Navigator.pop(context);
              state.changeRoute(link.path);
            }
          )).toList()
        )
      ),
      body: Builder(
        builder: (context) {
          if(state.currentRoute == 'home') {
            return Home(state);
          }

          return Text('404: NOT FOUND!');
        },
      )
    );
  }
}

const double _kMyLinearProgressIndicatorHeight = 7.0;

class MyLinearProgressIndicator extends LinearProgressIndicator implements PreferredSizeWidget {
  MyLinearProgressIndicator({
    Key key,
    double value,
    Color backgroundColor,
    Animation<Color> valueColor,
  }) : super(
          key: key,
          value: value,
          backgroundColor: backgroundColor,
          valueColor: valueColor,
        ) {
    preferredSize = Size(double.infinity, _kMyLinearProgressIndicatorHeight);
  }

  @override
  Size preferredSize;
}
