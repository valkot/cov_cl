import 'package:flutter/material.dart';
import 'package:division/division.dart';
import 'package:flutter/services.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:intl/intl.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Inicio extends StatefulWidget {
  String totalInfectados = '-';
  String totalRecuperados = '-';
  String totalFallecidos = '-';
  String fecha = '-';
  @override
  _InicioState createState() =>
      _InicioState(totalInfectados, totalRecuperados, totalFallecidos, fecha);
}

class _InicioState extends State<Inicio> {
  DateTime hoy = DateTime.now();
  List data;

  _InicioState(totalInfectados, totalRecuperados, totalFallecidos, fecha);

  @override
  void initState() {
    super.initState();
    getData();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    // Set portrait orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull(
            "http://186.64.121.251/app-urology/wsMundial.php"), ////http://186.64.121.251/app-urology/getCovid.php
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = jsonDecode(response.body);

      widget.totalInfectados = data[0]['totalInfectados'];
      widget.totalRecuperados = data[0]['totalRecuperados'];
      widget.totalFallecidos = data[0]['totalFallecidos'];
      widget.fecha = data[0]['fecha'];
    });
  }

  //USerCard(this.totalInfectados, this.totalFallecidos, this.totalRecuperados);

  final titleStyle = TxtStyle()
    ..bold()
    ..fontSize(28)
    ..margin(bottom: 20)
    ..alignmentContent.center();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.purple[100],
      body: new Container(
        color: Colors.purple[100],
        padding: EdgeInsets.fromLTRB(20, 0, 20, 25),

        //style: contentStyle(context),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: SizedBox(height: 10),
            ),
            Expanded(
              flex: 1,
              child: Txt('Inicio', style: titleStyle),
            ),
            Expanded(
              flex: 2,
              child: UserCard(
                  a: widget.totalInfectados,
                  b: widget.totalRecuperados,
                  c: widget.totalFallecidos,
                  d: widget.fecha),
            ),
            //Settings(data: data,),
            //SizedBox(height: 5,),
            Container(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
                child: AutoSizeText(
                  'Top 20',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                )),
            Expanded(
                flex: 4,
                child: ListView.builder(
                    itemCount: data == null ? 0 : data.length,
                    itemBuilder: (BuildContext context, int index) {
                      int posicion = index + 1;
                      return GestureDetector(
                        onTap: () {},
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 5,
                          color: Colors.white,
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(5),
                                child: Text(data[index]['pais_name'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14),
                                    textAlign: TextAlign.left),
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                        child: Container(
                                      padding: EdgeInsets.fromLTRB(0, 0, 2, 15),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                              '#' + posicion.toString(),
                                              style: TextStyle(
                                                  fontSize: 9,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                          Expanded(
                                              flex: 7,
                                              child: Image.network(
                                                  data[index]['bandera'],
                                                  width: 30,
                                                  height: 30))
                                        ],
                                      ),
                                      //child: Image.network(data[index]['bandera'], width:30, height:30)
                                      //child: Text(posicion.toString()),
                                    )),
                                    Expanded(
                                        child: Container(
                                      padding: EdgeInsets.all(2),
                                      child: Text(data[index]['infectados'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 10,
                                              color: Colors.red[700]),
                                          textAlign: TextAlign.center),
                                    )),
                                    Expanded(
                                        child: Container(
                                      padding: EdgeInsets.all(2),
                                      child: Text(data[index]['recuperados'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 10,
                                              color: Colors.green[700]),
                                          textAlign: TextAlign.center),
                                    )),
                                    Expanded(
                                        child: Container(
                                      padding: EdgeInsets.all(2),
                                      child: Text(data[index]['fallecidos'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 10,
                                              color: Colors.grey[700]),
                                          textAlign: TextAlign.center),
                                    ))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  String a;
  String b;
  String c;
  String d;

  UserCard({this.a, this.b, this.c, this.d});

  Widget _buildUserRow() {
    return Row(
      children: <Widget>[
        Parent(style: userImageStyle, child: Icon(Icons.language)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Txt('Situación mundial', style: nameTextStyle),
            SizedBox(height: 3),
            Txt('Actualizado el ' + d.toString(),
                style: subDescriptionTextStyle)
          ],
        )
      ],
    );
  }

  Widget _buildUserStats() {
    return Parent(
      style: userStatsStyle,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildUserStatsItem(a.toString(), 'Infectados'),
          _buildRecuperadosStatsItem(b.toString(), 'Recuperados'),
          _buildFallecidosStatsItem(c.toString(), 'Fallecidos'),
          // _buildUserStatsItem('39', 'Coupons'),
        ],
      ),
    );
  }

  Widget _buildUserStatsItem(String value, String text) {
    final TxtStyle textStyle = TxtStyle()
      ..fontSize(14)
      ..fontWeight(FontWeight.w500)
      ..textColor(Colors.red[800]);
    return Column(
      children: <Widget>[
        Txt(value, style: textStyle),
        SizedBox(height: 2),
        Txt(text, style: nameDescriptionTextStyle),
      ],
    );
  }

  Widget _buildRecuperadosStatsItem(String value, String text) {
    final TxtStyle textStyle = TxtStyle()
      ..fontSize(14)
      ..fontWeight(FontWeight.w500)
      ..textColor(Colors.green[800]);
    return Column(
      children: <Widget>[
        Txt(value, style: textStyle),
        SizedBox(height: 2),
        Txt(text, style: nameDescriptionTextStyle),
      ],
    );
  }

  Widget _buildFallecidosStatsItem(String value, String text) {
    final TxtStyle textStyle = TxtStyle()
      ..fontSize(14)
      ..fontWeight(FontWeight.w500)
      ..textColor(Colors.grey[800]);
    return Column(
      children: <Widget>[
        Txt(value, style: textStyle),
        SizedBox(height: 2),
        Txt(text, style: nameDescriptionTextStyle),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      style: userCardStyle,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[_buildUserRow(), _buildUserStats()],
      ),
    );
  }

  //Styling

  final ParentStyle userCardStyle = ParentStyle()
    ..height(175)
    ..padding(horizontal: 20.0, vertical: 8)
    ..alignment.center()
    ..background.hex('#8785c7') //3977FF
    ..borderRadius(all: 20.0)
    ..elevation(10, color: hex('#8785c7'));

  final ParentStyle userImageStyle = ParentStyle()
    ..height(40)
    ..width(40)
    ..margin(right: 10.0)
    ..borderRadius(all: 30)
    ..background.hex('ffffff');

  final ParentStyle userStatsStyle = ParentStyle()..margin(vertical: 10.0);

  final TxtStyle nameTextStyle = TxtStyle()
    ..textColor(Colors.white)
    ..fontSize(18)
    ..fontWeight(FontWeight.w500);

  final TxtStyle nameDescriptionTextStyle = TxtStyle()
    ..textColor(Colors.white.withOpacity(0.6))
    ..fontSize(9);

  final TxtStyle subDescriptionTextStyle = TxtStyle()
    ..textColor(Colors.white.withOpacity(0.6))
    ..fontSize(8);
}

class Settings extends StatelessWidget {
  final List data;

  Settings({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (BuildContext context, int index) {
              //print(data.length.toString());
              return GestureDetector(
                onTap: () {},
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 10,
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(5),
                        child: Text(data[index]['pais_name'],
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 13),
                            textAlign: TextAlign.left),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
