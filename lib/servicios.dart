import 'package:flutter/material.dart';
import 'package:division/division.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'servicios/farmacias.dart';

import 'package:intl/intl.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
 

class Servicios extends StatefulWidget 
{
  @override
  _ServiciosState createState() => _ServiciosState();
}

class _ServiciosState extends State<Servicios>
{
    @override
  void initState()
  {
    super.initState();
    SystemChrome.setPreferredOrientations
    ([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() 
  {
    // Set portrait orientation
    SystemChrome.setPreferredOrientations
    ([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }
  
 final contentStyle = (BuildContext context) => ParentStyle()
    ..overflow.scrollable()
    ..padding(vertical: 30, horizontal: 20)
    ..minHeight(MediaQuery.of(context).size.height - (2 * 30));

  final titleStyle = TxtStyle()
    ..bold()
    ..fontSize(28)
    ..margin(bottom: 40)
    ..alignmentContent.topCenter();
  
  @override
  Widget build(BuildContext context) 
  {
    return Container
    (
      color: Colors.purple[100],
      child: Column
      (
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>
        [
          Txt('Servicios', style: titleStyle),
          Salud(),
          Farmacias(),
        ],
      ),
    );
  }
}

class Salud extends StatelessWidget
{
  Widget build(BuildContext context)
  {
    return Container
    (
      padding: EdgeInsets.fromLTRB(20, 50, 20, 40),
      child: InkWell
      (
        child: Card
        (
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),),
          elevation: 10,
          color: hex('#82c27e'),
          child: Column
          (
            children: <Widget>
            [
              Container
              (
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row
                (
                  children: <Widget>
                  [
                    Expanded
                    (
                      child: Icon
                      (
                        FontAwesomeIcons.hospitalAlt,
                        color: Colors.blueAccent,
                        size: 90,
                      ),
                    )
                  ],
                ),
              ),
              Container
              (
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Row
                (
                  children: <Widget>
                  [
                    Expanded
                    (
                      child: Text('Servicios de Salud', textAlign: TextAlign.center, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: ()
        {
          print('SS');
        },
      )
    );
  }
}

class Farmacias extends StatelessWidget
{
  Widget build(BuildContext context)
  {
    return Container
    (
child: Container
(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 70),
      child: InkWell
      (
        child: Card
        (
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),),
          elevation: 10,
          color: hex('#FEC85C'),
          //borderOnForeground: true,
          child: Column
          (
            children: <Widget>
            [
              Container
              (
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row
                (
                  children: <Widget>
                  [
                    Expanded
                    (
                      child: Icon
                      (
                        FontAwesomeIcons.pills,
                        color: Colors.blueAccent,
                        size: 90,
                      ),
                    )
                  ],
                ),
              ),
              Container
              (
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Row
                (
                  children: <Widget>
                  [
                    Expanded
                    (
                      child: Text('Farmacias', textAlign: TextAlign.center, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: ()
        {
           Navigator.push(context,MaterialPageRoute(builder: (context) => DetalleFarmacias()),);
        },
      )
)
    );
  }
}