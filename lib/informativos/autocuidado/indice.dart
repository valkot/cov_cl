import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'package:cov_cl/informativos/autocuidado/primero.dart';
import 'package:cov_cl/informativos/autocuidado/segundo.dart';
import 'package:cov_cl/informativos/autocuidado/tercero.dart';
import 'package:cov_cl/informativos/autocuidado/cuarto.dart';
import 'package:cov_cl/informativos/autocuidado/quinto.dart';
import 'package:cov_cl/informativos/autocuidado/sexto.dart';



import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Indice extends StatefulWidget
{
  @override
  _IndiceState createState() => _IndiceState();
}

class _IndiceState extends State<Indice>
{
  @override
  Widget build(BuildContext context) 
  {
    return new Scaffold
    (
      appBar: new AppBar
      (
        backgroundColor: Colors.purple[200],
        title: new Text("Autocuidado"),
        
        //leading: new Container(),
      ),
      body: new ListView
      (
          children: <Widget>
          [
            Row
            (
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>
              [
                Expanded
                (
                  child: InkWell
                  (
                    child: Card
                    (
                      color: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),
                      elevation: 10,
                      child: Container
                      (
                        padding: EdgeInsets.fromLTRB(3, 3, 3, 3),
                        child: Column
                        (
                          children: <Widget>
                          [
                            Image.asset('assets/info_1.png', height: 100, width: 100,),
                            Text('¿Qué es el\nCovid-19?\n',textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                          ],
                        )
                        
                      ),
                    ),
                    onTap: ()
                    {
                      Navigator.push(context,MaterialPageRoute(builder: (context) => Primero()),);
                      //Primero();
                    },
                  )
                ),
                Expanded
                (
                  child: InkWell
                  (
                    child: Card
                    (
                      color: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),
                      elevation: 10,
                      child: Container
                      (
                        padding: EdgeInsets.fromLTRB(3, 3, 3, 3),
                        child: Column
                        (
                          children: <Widget>
                          [
                            Image.asset('assets/info_2.png', height: 100, width: 100,),
                            Text('¿Qué es la\ncuarentena\nobligatoria?',textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                          ],
                        )
                        
                      ),
                    ),
                    onTap: ()
                    {
                      Navigator.push(context,MaterialPageRoute(builder: (context) => Segundo()),);
                    },
                  )
                ),
              ]
            ),
            Row
            (
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>
              [
                Expanded
                (
                  child: InkWell
                  (
                    child: Card
                    (
                      color: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),
                      elevation: 10,
                      child: Container
                      (
                        padding: EdgeInsets.fromLTRB(3, 3, 3, 3),
                        child: Column
                        (
                          children: <Widget>
                          [
                            Image.asset('assets/info_3.png', height: 100, width: 100,),
                            Text('Cuales son las\nIndicaciones\nGenerales\n\n',textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                          ],
                        )
                        
                      ),
                    ),
                    onTap: ()
                    {
                      Navigator.push(context,MaterialPageRoute(builder: (context) => Tercero()),);
                    },
                  ),
                ),
                Expanded
                (
                  child: InkWell
                  (
                    child: Card
                    (
                      color: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),
                      elevation: 10,
                      child: Container
                      (
                        padding: EdgeInsets.fromLTRB(3, 3, 3, 3),
                        child: Column
                        (
                          children: <Widget>
                          [
                            Image.asset('assets/info_4.png', height: 100, width: 100,),
                            Text('¿Que pasa si\nenfermo\ndurante la\ncuarentena\nobligatoria?',textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                          ],
                        )
                        
                      ),
                    ),
                    onTap: ()
                    {
                      Navigator.push(context,MaterialPageRoute(builder: (context) => Cuarto()),);
                    },
                  ),
                ),
              ]
            ),
            Row
            (
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>
              [
                Expanded
                (
                  child: InkWell
                  (
                    child: Card
                    (
                      color: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),
                      elevation: 10,
                      child: Container
                      (
                        padding: EdgeInsets.fromLTRB(3, 3, 3, 3),
                        child: Column
                        (
                          children: <Widget>
                          [
                            Image.asset('assets/info_5.png', height: 100, width: 100,),
                            Text('¿Qué pasa si soy confirmado con\nCovid-19?',textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                          ],
                        )
                        
                      ),
                    ),
                    onTap: ()
                    {
                      Navigator.push(context,MaterialPageRoute(builder: (context) => Quinto()),);
                    },
                  ),
                ),
                Expanded
                (
                  child: InkWell
                  (
                    child: Card
                    (
                      color: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),
                      elevation: 10,
                      child: Container
                      (
                        padding: EdgeInsets.fromLTRB(3, 3, 3, 3),
                        child: Column
                        (
                          children: <Widget>
                          [
                            Image.asset('assets/info_6.png', height: 100, width: 100,),
                            Text('¿Qué pasa si no pertenezco al grupo de riesgo?',textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                          ],
                        )
                      ),
                    ),
                    onTap: ()
                    {
                      Navigator.push(context,MaterialPageRoute(builder: (context) => Sexto()),);
                    },
                  ),
                ),
              ]
            )
          ],
      ),
    );
  }
}