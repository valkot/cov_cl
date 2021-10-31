
import 'package:cov_cl/acercade.dart';
import 'package:cov_cl/estadisticas.dart';
import 'package:cov_cl/informativos.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'inicio.dart';
import 'servicios.dart';
import 'servicios/farmacias.dart';
import 'package:custom_splash/custom_splash.dart';

void main() 
{
  Function duringSplash = () 
  {
    print('Something background process');
    int a = 123 + 23;
    print(a);

    if (a > 100)
      return 1;
    else
      return 2;
  };

  Map<int, Widget> op = {1: BottomNavBar()};

  runApp(MaterialApp
  (
    home: CustomSplash
    (
        imagePath: 'assets/covcl.png',
        backGroundColor: Colors.purple[100],
        animationEffect: 'zoom-in',
        logoSize: 200,
        home: BottomNavBar(),
        customFunction: duringSplash,
        duration: 2500,
        type: CustomSplashType.StaticDuration,
        outputAndHome: op,
    ),
  )
  );
}
//

class BottomNavBar extends StatefulWidget 
{
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> 
{
  int _pageIndex = 2;
  GlobalKey _bottomNavigationKey = GlobalKey();
  List pages = 
  [
    MyRoute
    (
      iconData: Icons.description,
      page: Informativos(),
    ),
    MyRoute
    (
      iconData: Icons.timeline,
      page: Estadisticas(),
    ),
    MyRoute
    (
      iconData: Icons.home,
      page: Inicio(),
    ),
    MyRoute
    (
      iconData: Icons.healing,
      page: DetalleFarmacias(),
    ),
    MyRoute
    (
      iconData: Icons.live_help,
      page: Acercade(),
    )
  ];

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      bottomNavigationBar: CurvedNavigationBar
      (
        key: _bottomNavigationKey,
        index: 2,
        height: 60.0,
        items: pages
            .map((p) => Icon(
                  p.iconData,
                  size: 30,
                  color: Colors.white,
                ))
            .toList(),
        color: Colors.purple[200],//color barra
        buttonBackgroundColor: Colors.blue[600], //color circulo
        backgroundColor: Colors.purple[100], //color fondo 
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _pageIndex = index;
          });
        },
      ),
      //backgroundColor: Colors.red,
      body: pages[_pageIndex].page,
    );
  }
}

class MyRoute {
  final IconData iconData;
  final Widget page;

  MyRoute({this.iconData, this.page});
}