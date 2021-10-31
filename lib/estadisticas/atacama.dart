import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


class Atacama extends StatefulWidget
{
  @override
  _AtacamaState createState() => _AtacamaState();
}


class _AtacamaState extends State<Atacama>
{
  
  List data;
  String laFecha = '';
  String miFecha = '';
  int elTimer = 7;
  Future<String> getData() async 
  {
    if(1==1)
    {startTimer();}
    var response = await http.get
    (
      Uri.encodeFull("http://186.64.121.251/app-urology/wsCovidComunasCompleto.php?region=03"),//http://186.64.121.251/app-urology/getCovidComunas.php
      headers: 
      {
        "Accept": "application/json"
      }
    );

    this.setState(() 
    {
      data = jsonDecode(response.body);
      var aaa = data.length;
      for(var i=0; i<aaa; i++)
      {
        laFecha = data[i]['fecha'];
      }
      miFecha = laFecha;
    });
  }

  Timer _timer;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (elTimer < 1) {
            timer.cancel();
          } else {
            elTimer = elTimer - 1;
          }
        },
      ),
    );
  }

  @override
  void dispose()
  {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState()
  {
    this.getData();
  }

  @override
  Widget build(BuildContext context) 
  {
    if(elTimer > 1)
    {
      return Scaffold
      (
        appBar: AppBar
        (
          backgroundColor: Colors.purple[200],
          title: Text('Región de Atacama'),
        ),
        body: Container
        (
          color: Colors.black26,
          padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
          child: Column
          (
            children: <Widget>
            [
              Column
              (
                children: <Widget>
                [
                  Align
                  (
                    alignment: Alignment.topLeft,
                    child: Text('Comunal', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),textAlign: TextAlign.left,),
                  ),
                  Align
                  (
                    alignment: Alignment.topLeft,
                    child: Text('Datos Actualizados el $miFecha ', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 10),textAlign: TextAlign.left,),
                  ),
                ],
              ),
              SizedBox(height:100),
              Container
              (
                decoration: new BoxDecoration
                (
                  color: Colors.black45,
                  borderRadius: new BorderRadius.circular(10.0)
                ),
                width: 150.0,
                height: 120.0,
                alignment: AlignmentDirectional.center,
                child: new Column
                (
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>
                  [
                    new Center
                    (
                      child: new SizedBox
                      (
                        height: 50.0,
                        width: 50.0,
                        child: new CircularProgressIndicator
                        (
                          value: null,
                          strokeWidth: 7.0,
                          valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                    ),
                    new Container
                    (
                      margin: const EdgeInsets.only(top: 15.0),
                      child: new Center
                      (
                        child: new Text("cargando...", style: new TextStyle(color: Colors.white),),
                      ),
                    ),
                  ],
                ),
              ),
            ]
          )
        )
      );
    }
    else
    {
      return Scaffold
      (
        appBar: AppBar
        (
          backgroundColor: Colors.purple[200],
          title: Text('Región de Atacama'),
        ),
        body: Container
        (
          padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
          child: Column
          (
            children: <Widget>
            [
              Column
              (
                children: <Widget>
                [
                  Align
                  (
                    alignment: Alignment.topLeft,
                    child: Text('Comunal', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),textAlign: TextAlign.left,),
                  ),
                  Align
                  (
                    alignment: Alignment.topLeft,
                    child: Text('Datos Actualizados el $miFecha ', style: TextStyle(fontWeight: FontWeight.w300, fontSize: 10),textAlign: TextAlign.left,),
                  ),
                ],
              ),
              SizedBox(height:10),
              Expanded
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
                      child: Column
                      (
                        children: <Widget>
                        [
                          Card
                          (
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
                            elevation: 5,
                            color: Colors.white,
                            child: Column
                            (
                              children: <Widget>
                              [
                                Container
                                (
                                  padding: EdgeInsets.fromLTRB(25, 5, 0, 0),
                                  child: Align
                                  (
                                    alignment: Alignment.topLeft,
                                    child: Text(data[index]['comuna_name'],style: TextStyle(fontSize: 16),),
                                  ),
                                ),
                                Container
                                (

                                  child: Container
                                  (
                                    padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
                                    child: Row
                                    (
                                      children: <Widget>
                                      [
                                        Expanded
                                        (
                                          child: Card
                                          (
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
                                            elevation: 10,
                                            child: Column
                                            (
                                              children: <Widget>
                                              [
                                                Container
                                                (
                                                  padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                                                  child: Align
                                                  (
                                                    alignment: Alignment.topLeft,
                                                    child: Icon(Icons.lens, size: 12, color: Colors.red[600],),
                                                  ),
                                                ),
                                                Container
                                                (
                                                  padding: EdgeInsets.all(5),
                                                  child: Text(data[index]['infectados'],textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),)
                                                ),
                                                Container
                                                (
                                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                                  child: Text('Casos\nConfirmados', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 10, color: Colors.grey)),
                                                )
                                              ],
                                            ),
                                          )
                                        ),
                                        Expanded
                                        (
                                          child: Card
                                          (
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
                                            elevation: 10,
                                            child: Column
                                            (
                                              children: <Widget>
                                              [
                                                Container
                                                (
                                                  padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                                                  child: Align
                                                  (
                                                    alignment: Alignment.topLeft,
                                                    child: Icon(Icons.lens, size: 12, color: Colors.green[600],),
                                                  ),
                                                ),
                                                Container
                                                (
                                                  padding: EdgeInsets.all(5),
                                                  child: Text(data[index]['recuperados'],textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),)
                                                ),
                                                Container
                                                (
                                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                                  child: Text('Casos\nRecuperados', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 10, color: Colors.grey)),
                                                )
                                              ],
                                            ),
                                          )
                                        ),
                                        Expanded
                                        (
                                          child: Card
                                          (
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
                                            elevation: 10,
                                            child: Column
                                            (
                                              children: <Widget>
                                              [
                                                Container
                                                (
                                                  padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                                                  child: Align
                                                  (
                                                    alignment: Alignment.topLeft,
                                                    child: Icon(Icons.lens, size: 12, color: Colors.yellow[600],),
                                                  ),
                                                ),
                                                Container
                                                (
                                                  padding: EdgeInsets.all(5),
                                                  child: Text(data[index]['activos'],textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),)
                                                ),
                                                Container
                                                (
                                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                                  child: Text('Casos\nActivos', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.w400, fontSize: 10, color: Colors.grey)),
                                                )
                                              ],
                                            ),
                                          )
                                        ),
                                      ],
                                    ),
                                  )
                                ),
                        /*        
                                Container
                                (
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                                  child: Row
                                  (
                                    children: <Widget>
                                    [
                                      Expanded
                                      (
                                        child: Card
                                        (
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
                                          elevation: 10,
                                          child: Row
                                          (
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>
                                            [
                                              Container
                                              (
                                                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                                child: Align
                                                (
                                                  alignment: Alignment.centerLeft,
                                                  child: Icon(FontAwesomeIcons.venus, size: 40, color: Colors.pink[200],),
                                                ),
                                              ),
                                              Container
                                              (
                                                padding: EdgeInsets.all(5),
                                                child: Text(data[index]['mujer'],textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),)
                                              )
                                            ]
                                          )
                                        )
                                      ),
                                      Expanded
                                      (
                                        child: Card
                                        (
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
                                          elevation: 10,
                                          child: Row
                                          (
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>
                                            [
                                              Container
                                              (
                                                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                                child: Align
                                                (
                                                  alignment: Alignment.centerLeft,
                                                  child: Icon(FontAwesomeIcons.mars, size: 40, color: Colors.blue[200],),
                                                ),
                                              ),
                                              Container
                                              (
                                                padding: EdgeInsets.all(5),
                                                child: Text(data[index]['hombre'],textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),)
                                              )
                                            ]
                                          )
                                        )
                                      ),
                                    ],
                                  ),
                                ),
                      */          
                              ],
                            ),
                          )
                        ],
                      )
                    );
                  }
                ),
              )
            ],
          ),
        )
      );
    }
  }
}