import 'package:flutter/material.dart';
import 'package:division/division.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'informativos/autocuidado/indice.dart';
import 'informativos/cuarentenas/cuarentenas.dart';

import 'package:intl/intl.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
 

class Informativos extends StatefulWidget 
{
  @override
  _InformativosState createState() => _InformativosState();
}

class _InformativosState extends State<Informativos>
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
          Expanded
          (
            flex: 1,
            child: SizedBox(height: 50),
          ),
          Expanded
          (
            flex: 2,
            child: Txt('Informativos', style: titleStyle),
          ),
          Expanded
          (
            flex: 2,
            child: Salud(),
          ),
          Expanded
          (
            flex: 2,
            child: Farmacias(),
          ),
          Expanded
          (
            flex: 1,
            child: SizedBox(height: 50),
          ),
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
      padding: EdgeInsets.fromLTRB(20, 0, 20, 5),
      child: InkWell
      (
        child: Card
        (
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),),
          elevation: 10,
          color: hex('#ed93e3'),
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
                        FontAwesomeIcons.handsWash,
                        color: Colors.blueAccent,
                        size: 80,
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
                      child: Text('Autocuidado', textAlign: TextAlign.center, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: ()
        {
          Navigator.push(context,MaterialPageRoute(builder: (context) => Indice()),);
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
      padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
      child: InkWell
      (
        child: Card
        (
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),),
          elevation: 10,
          color: hex('#eb5b5b'),
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
                        FontAwesomeIcons.viruses,
                        color: Colors.blueAccent,
                        size: 80,
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
                      child: Text('Cuarentenas', textAlign: TextAlign.center, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: ()
        {
           Navigator.push(context,MaterialPageRoute(builder: (context) => Cuarentenas()),);
        },
      )
)
    );
  }
}