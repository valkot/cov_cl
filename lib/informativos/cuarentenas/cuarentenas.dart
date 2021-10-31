import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:intl/intl.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Cuarentenas extends StatefulWidget 
{
  @override
  _CuarentenasState createState() => _CuarentenasState();
}

class _CuarentenasState extends State<Cuarentenas>
{
  DateTime hoy = DateTime.now();
  List data;

  @override
  void initState()
  {
    super.initState();
    getData();
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

  Future<String> getData() async 
  {
    var response = await http.get(
      Uri.encodeFull("http://186.64.121.251/app-urology/wsCuarentenas.php"),////http://186.64.121.251/app-urology/getCovid.php
      headers: 
      {
        "Accept": "application/json"
      }
    );

    this.setState(() 
    {
      data = jsonDecode(response.body);
    });
  }

  @override
  Widget build(BuildContext context) 
  {
    return new Scaffold
    (
      //backgroundColor: Colors.purple[100],
      appBar: new AppBar
      (
        title: new Text('COMUNAS EN CUARENTENA', style: TextStyle(fontSize: 18),),
        backgroundColor: Colors.purple[200],
      ),
      body: new Container
      (
        //color: Colors.purple[100],
        padding: EdgeInsets.fromLTRB(10, 30, 10, 5),
        child: Center
        (
          child: ListView.builder
          (
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (BuildContext context, int index)
            {
              return GestureDetector
              (
                onTap: () 
                {
                },
                child: Row
                (
                  children: <Widget>
                  [
                    Expanded
                    (
                      child: Card
                      (
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),),
                        elevation: 5,
                        child: Row
                        (
                          children: <Widget>
                          [
                            Expanded
                            (
                              flex: 2,
                              child: Container
                              (
                                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                child: Image.network(data[index]['escudo'], height: 40, width: 50,),
                              ),
                            ),
                            Expanded
                            (
                              flex: 8,
                              child: Container
                              (
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                child: Column
                                (
                                  children: <Widget>
                                  [
                                    Align
                                    (
                                      alignment: Alignment.topCenter,
                                      child: Text(data[index]['comuna'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),)
                                    ),
                                    Row
                                    (
                                      children: <Widget>
                                      [
                                        Expanded
                                        (
                                          flex: 1,
                                          child: Container
                                          (
                                            padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
                                            child: Icon(FontAwesomeIcons.vectorSquare, size: 10,)
                                          ),
                                        ),
                                        Expanded
                                        (
                                          flex: 9,
                                          child: Container
                                          (
                                            padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
                                            child: Text(data[index]['alcance'], style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                                          ),
                                        )
                                      ],
                                    ),
                                    Row
                                    (
                                      children: <Widget>
                                      [
                                        Expanded
                                        (
                                          flex: 1,
                                          child: Container
                                          (
                                            padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
                                            child: Icon(FontAwesomeIcons.hourglassStart, size: 10,)
                                          ),
                                        ),
                                        Expanded
                                        (
                                          flex: 9,
                                          child: Container
                                          (
                                            padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
                                            child: Text(data[index]['inicio'], style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                                          ),
                                        ),
                                        
                                      ],
                                    ),
                                    Row
                                    (
                                      children: <Widget>
                                      [
                                        Expanded
                                        (
                                          flex: 1,
                                          child: Container
                                          (
                                            padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
                                            child: Icon(FontAwesomeIcons.hourglassEnd, size: 10,)
                                          ),
                                        ),
                                        Expanded
                                        (
                                          flex: 9,
                                          child: Container
                                          (
                                            padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
                                            child: Text(data[index]['termino'], style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                                          ),
                                        ),
                                        
                                      ],
                                    ),
                                    /*
                                    Row
                                    (
                                      children: <Widget>
                                      [
                                        Expanded
                                        (
                                          flex: 1,
                                          child: Container
                                          (
                                            //padding: EdgeInsets.all(2),
                                            child: Icon(FontAwesomeIcons.commentDots, size: 10,)
                                          ),
                                        ),
                                        Expanded
                                        (
                                          flex: 9,
                                          child: Container
                                            (
                                              //padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                                              child: Text(data[index]['detalle'], style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                                            ),
                                        )
                                      ]  
                                    ),
                                    */
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    )
                  ],
                ),
              );
            }
          )
        )
      )
    );
  }

}