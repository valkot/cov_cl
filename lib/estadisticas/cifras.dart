import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:cov_cl/estadisticas/arica.dart';
import 'package:cov_cl/estadisticas/tarapaca.dart';
import 'package:cov_cl/estadisticas/antofagasta.dart';
import 'package:cov_cl/estadisticas/atacama.dart';
import 'package:cov_cl/estadisticas/coquimbo.dart';
import 'package:cov_cl/estadisticas/valparaiso.dart';
import 'package:cov_cl/estadisticas/metropolitana.dart';
import 'package:cov_cl/estadisticas/ohiggins.dart';
import 'package:cov_cl/estadisticas/maule.dart';
import 'package:cov_cl/estadisticas/nuble.dart';
import 'package:cov_cl/estadisticas/biobio.dart';
import 'package:cov_cl/estadisticas/araucania.dart';
import 'package:cov_cl/estadisticas/rios.dart';
import 'package:cov_cl/estadisticas/lagos.dart';
import 'package:cov_cl/estadisticas/aysen.dart';
import 'package:cov_cl/estadisticas/magallanes.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Cifras extends StatefulWidget {
  @override
  _CifrasState createState() => _CifrasState();
}

class _CifrasState extends State<Cifras> {
  int touchedIndex;
  DateTime hoy = DateTime.now();
  List data;
  String sumaI;
  String sumaR;
  String sumaF;
  String sumaN;
  String sumaP;
  String sumaU;
  int totalInfectados = 0;
  int totalRecuperados = 0;
  int totalFallecidos = 0;
  int totalNuevos = 0;
  int totalPcr = 0;
  int totalUci = 0;
  String valorInfectados = '-';
  String valorRecuperados = '-';
  String valorFallecidos = '-';
  String valorNuevos = '-';
  String valorPcr = '-';
  String valorPcrTotal = '';
  String valorFallTotal = '';
  String valorRecupTotal = '';
  String valorRecupHoy = '';
  String valorActivoTotal = '';
  String valorUciHoy = '';
  String valorUci = '-';
  String laFecha = '';
  String anio = '';
  String mes = '';
  String dia = '';
  String miFecha = '';
  String activosTotales = '-';
  String activosHoy = '';
  String elColor = '#149705';
  //int residenciaUtilizado = '';
  //int residenciaLibre = '';
  //int residenciaTotal = 0;
  String residenciaCuposUtilizados = '0';
  String residenciaCuposLibres = '0';
  String residenciaCuposTotal = '0';
  String ventiladoresUtilizados = '0';
  String ventiladoresDisponibles = '0';
  String ventiladoresTotal = '0';
  int elTimer = 18;
  Future<String> getData() async {
    if (1 == 1) {
      startTimer();
    }
    var response = await http.get(
        Uri.encodeFull(
            "http://186.64.121.251/app-urology/wsCovid2.php"), ////http://186.64.121.251/app-urology/getCovid.php
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = jsonDecode(response.body);

      var aaa = data.length;
      for (var i = 0; i < aaa; i++) {
        sumaI = data[i]['infectados'];
        totalInfectados = totalInfectados + int.parse(sumaI);

        //sumaR = data[i]['recuperados'];
        //totalRecuperados = totalRecuperados + int.parse(sumaR);
        activosTotales = data[i]['activosTotales'];
        activosHoy = data[i]['activosHoy'];

        sumaF = data[i]['fallecidos'];
        totalFallecidos = totalFallecidos + int.parse(sumaF);
        sumaN = data[i]['nuevos'];
        sumaP = data[i]['pcr'];
        totalPcr = totalPcr + int.parse(sumaP);
        sumaU = data[i]['uci'];
        totalUci = totalUci + int.parse(sumaU);
        totalNuevos = totalNuevos + int.parse(sumaN);
        valorPcrTotal = data[i]['pcrtotal'];
        valorFallTotal = data[i]['falltotal'];
        valorRecupHoy = data[i]['recuptotal'];
        valorRecupTotal = data[i]['recuperadoTotal'];
        valorUciHoy = data[i]['ucihoy'];
        residenciaCuposLibres = data[i]['rcl'];
        residenciaCuposUtilizados = data[i]['rcu'];
        residenciaCuposTotal = data[i]['rct'];
        ventiladoresUtilizados = data[i]['ventOcup'];
        ventiladoresDisponibles = data[i]['ventDisp'];
        ventiladoresTotal = data[i]['ventTotal'];
        // print(data[i]['falltotal'].toString());
        laFecha = data[i]['fecha'];
      }
      miFecha = laFecha + ' a las 12:00';
      valorInfectados = totalInfectados.toString();
      //valorRecuperados = totalRecuperados.toString();
      valorFallecidos = totalFallecidos.toString();
      valorNuevos = totalNuevos.toString();
      valorPcr = totalPcr.toString();
      //valorPcrTotal = totalPcrTotal.toString();
      valorUci = totalUci.toString();
      if (int.parse(activosHoy) > 0) {
        elColor = '#DC0000';
      } else {
        elColor = '#149705';
      }
      //residenciaCuposUtilizados = residenciaUtilizado.toString();
      //residenciaCuposLibres = residenciaLibre.toString();
      //residenciaCuposTotal = residenciaTotal.toString();
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
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    this.getData();
  }

  Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  double screenHeight(BuildContext context, {double dividedBy = 1}) {
    return screenSize(context).height / dividedBy;
  }

  double screenWidth(BuildContext context, {double dividedBy = 1}) {
    return screenSize(context).width / dividedBy;
  }

  @override
  Widget build(BuildContext context) {
    if (elTimer > 1) {
      return new Scaffold(
          appBar: new AppBar(
            backgroundColor: Colors.purple[200],
            title: new Text("Estadísticas"),
          ),
          body: new Container(
              color: Colors.black26,
              padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
              child: Column(children: <Widget>[
                SizedBox(height: 5),
                Row(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Nacional',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        'Datos Actualizados el $miFecha',
                        style:
                            TextStyle(fontWeight: FontWeight.w300, fontSize: 8),
                        textAlign: TextAlign.left,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Card(
                        color: Colors.grey[400],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5,
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(5.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Icon(
                                  Icons.lens,
                                  size: 12,
                                  color: Colors.orange[600],
                                ),
                              ),
                            ),
                            Container(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  valorInfectados,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(5, 3, 5, 0),
                              child: Text('',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 10,
                                      color: Colors.red[600])),
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              child: Text('Confirmados',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10,
                                      color: Colors.grey)),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Card(
                          color: Colors.grey[400],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(5.0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Icon(
                                    Icons.lens,
                                    size: 12,
                                    color: Colors.green[600],
                                  ),
                                ),
                              ),
                              Container(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    valorRecupTotal,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(5, 3, 5, 0),
                                child: Text('',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 10,
                                        color: Colors.green[600])),
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                child: Text('Recuperados',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10,
                                        color: Colors.grey)),
                              )
                            ],
                          )),
                    ),
                    Expanded(
                      child: Card(
                          color: Colors.grey[400],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(5.0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Icon(
                                    Icons.lens,
                                    size: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ),
                              Container(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    valorFallecidos,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(5, 3, 5, 0),
                                child: Text('',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 10,
                                        color: Colors.red[600])),
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                child: Text('Fallecidos',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10,
                                        color: Colors.grey)),
                              )
                            ],
                          )),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Card(
                        color: Colors.grey[400],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5,
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(5.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Icon(
                                  Icons.lens,
                                  size: 12,
                                  color: Colors.blue[600],
                                ),
                              ),
                            ),
                            Container(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  valorPcrTotal,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(5, 3, 5, 0),
                              child: Text('',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 10,
                                      color: Colors.red[600])),
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              child: Text('Examenes PCR',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10,
                                      color: Colors.grey)),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Card(
                          color: Colors.grey[400],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(5.0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Icon(
                                    Icons.lens,
                                    size: 12,
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ),
                              Container(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    activosTotales,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(5, 3, 5, 0),
                                child: Text('',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 10,
                                        color: Colors.green[600])),
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                child: Text('Activos',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10,
                                        color: Colors.grey)),
                              )
                            ],
                          )),
                    ),
                    Expanded(
                      child: Card(
                          color: Colors.grey[400],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(5.0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Icon(
                                    Icons.lens,
                                    size: 12,
                                    color: Colors.purple[600],
                                  ),
                                ),
                              ),
                              Container(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    valorUci,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(5, 3, 5, 0),
                                child: Text('',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 10,
                                        color: Colors.red[600])),
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                child: Text('Pacientes UCI',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10,
                                        color: Colors.grey)),
                              )
                            ],
                          )),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Card(
                          color: Colors.grey[400],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 2, 0, 1),
                                child: Text(
                                  'Residencias Sanitarias',
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                  child: Row(children: <Widget>[
                                Expanded(
                                  flex: 5,
                                  child: Container(
                                      padding:
                                          EdgeInsets.fromLTRB(5, 10, 0, 10),
                                      child: Column(
                                        children: <Widget>[
                                          Align(
                                              alignment: Alignment.topLeft,
                                              child: Row(
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.lens,
                                                    size: 7,
                                                    color: Colors.green[600],
                                                  ),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            2, 0, 0, 0),
                                                    child: Text('Libre',
                                                        style: TextStyle(
                                                            fontSize: 8)),
                                                  )
                                                ],
                                              )),
                                          Align(
                                              alignment: Alignment.topLeft,
                                              child: Row(
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.lens,
                                                    size: 7,
                                                    color: Colors.blue[600],
                                                  ),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            2, 0, 0, 0),
                                                    child: Text('Ocupado',
                                                        style: TextStyle(
                                                            fontSize: 8)),
                                                  )
                                                ],
                                              )),
                                        ],
                                      )),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: PieChart(
                                      PieChartData(
                                          pieTouchData: PieTouchData(
                                              touchCallback:
                                                  (pieTouchResponse) {
                                            setState(() {
                                              if (pieTouchResponse.touchInput
                                                      is FlLongPressEnd ||
                                                  pieTouchResponse.touchInput
                                                      is FlPanEnd) {
                                                touchedIndex = -1;
                                              } else {
                                                touchedIndex = pieTouchResponse
                                                    .touchedSectionIndex;
                                              }
                                            });
                                          }),
                                          borderData: FlBorderData(
                                            show: false,
                                          ),
                                          sectionsSpace: 0,
                                          centerSpaceRadius: 12,
                                          sections: showResidencias()),
                                    ),
                                  ),
                                ),
                              ]))
                            ],
                          )),
                    ),
                    Expanded(
                      child: Card(
                          color: Colors.grey[400],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 2, 0, 1),
                                child: Text(
                                  'Ventiladores',
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                  child: Row(children: <Widget>[
                                Expanded(
                                  flex: 5,
                                  child: Container(
                                      padding:
                                          EdgeInsets.fromLTRB(5, 10, 0, 10),
                                      child: Column(
                                        children: <Widget>[
                                          Align(
                                              alignment: Alignment.topLeft,
                                              child: Row(
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.lens,
                                                    size: 7,
                                                    color: Colors.red[600],
                                                  ),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            2, 0, 0, 0),
                                                    child: Text('Ocupado',
                                                        style: TextStyle(
                                                            fontSize: 8)),
                                                  )
                                                ],
                                              )),
                                          Align(
                                              alignment: Alignment.topLeft,
                                              child: Row(
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.lens,
                                                    size: 7,
                                                    color: Colors.green[600],
                                                  ),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            2, 0, 0, 0),
                                                    child: Text('Libre',
                                                        style: TextStyle(
                                                            fontSize: 8)),
                                                  )
                                                ],
                                              )),
                                        ],
                                      )),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: PieChart(
                                      PieChartData(
                                          pieTouchData: PieTouchData(
                                              touchCallback:
                                                  (pieTouchResponse) {
                                            setState(() {
                                              if (pieTouchResponse.touchInput
                                                      is FlLongPressEnd ||
                                                  pieTouchResponse.touchInput
                                                      is FlPanEnd) {
                                                touchedIndex = -1;
                                              } else {
                                                touchedIndex = pieTouchResponse
                                                    .touchedSectionIndex;
                                              }
                                            });
                                          }),
                                          borderData: FlBorderData(
                                            show: false,
                                          ),
                                          sectionsSpace: 0,
                                          centerSpaceRadius: 12,
                                          sections: showVentiladores()),
                                    ),
                                  ),
                                ),
                              ]))
                            ],
                          )),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Regional',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Datos Actualizados el $miFecha',
                        style:
                            TextStyle(fontWeight: FontWeight.w300, fontSize: 8),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                //Center(child: CircularProgressIndicator())
                Container(
                  decoration: new BoxDecoration(
                      color: Colors.black45,
                      borderRadius: new BorderRadius.circular(10.0)),
                  width: 150.0,
                  height: 120.0,
                  alignment: AlignmentDirectional.center,
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Center(
                        child: new SizedBox(
                          height: 50.0,
                          width: 50.0,
                          child: new CircularProgressIndicator(
                            value: null,
                            strokeWidth: 7.0,
                            valueColor:
                                new AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                      ),
                      new Container(
                        margin: const EdgeInsets.only(top: 15.0),
                        child: new Center(
                          child: new Text(
                            "cargando...",
                            style: new TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ])));
    } else {
      return new Scaffold(
          appBar: new AppBar(
            backgroundColor: Colors.purple[200],
            title: new Text("Estadísticas"),
          ),
          body: new Container(
            padding: EdgeInsets.fromLTRB(3, 1, 3, 0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SizedBox(height: 1),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Nacional',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 16),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        ' Datos Actualizados el $miFecha',
                        style:
                            TextStyle(fontWeight: FontWeight.w300, fontSize: 8),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5,
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(5.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Icon(
                                  Icons.lens,
                                  size: 12,
                                  color: Colors.orange[600],
                                ),
                              ),
                            ),
                            Container(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  valorInfectados,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(5, 3, 5, 0),
                              child: Text('+' + valorNuevos,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 10,
                                      color: Colors.red[600])),
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              child: Text('Confirmados',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10,
                                      color: Colors.grey)),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(5.0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Icon(
                                    Icons.lens,
                                    size: 12,
                                    color: Colors.green[600],
                                  ),
                                ),
                              ),
                              Container(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    valorRecupTotal,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(5, 3, 5, 0),
                                child: Text('+' + valorRecupHoy,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 10,
                                        color: Colors.green[600])),
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                child: Text('Recuperados',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10,
                                        color: Colors.grey)),
                              )
                            ],
                          )),
                    ),
                    Expanded(
                      child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(5.0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Icon(
                                    Icons.lens,
                                    size: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ),
                              Container(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    valorFallecidos,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(5, 3, 5, 0),
                                child: Text('+' + valorFallTotal,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 10,
                                        color: Colors.red[600])),
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                child: Text('Fallecidos',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10,
                                        color: Colors.grey)),
                              )
                            ],
                          )),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5,
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(5.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Icon(
                                  Icons.lens,
                                  size: 12,
                                  color: Colors.blue[600],
                                ),
                              ),
                            ),
                            Container(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  valorPcrTotal,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(5, 3, 5, 0),
                              child: Text('+' + valorPcr,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 10,
                                      color: Colors.red[600])),
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              child: Text('Examenes PCR',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10,
                                      color: Colors.grey)),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(5.0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Icon(
                                    Icons.lens,
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Container(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    activosTotales,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(5, 3, 5, 0),
                                child: Text(activosHoy,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 10,
                                        color: Hexcolor('$elColor'))),
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                child: Text('Activos',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10,
                                        color: Colors.grey)),
                              )
                            ],
                          )),
                    ),
                    Expanded(
                      child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(5.0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Icon(
                                    Icons.lens,
                                    size: 12,
                                    color: Colors.purple[600],
                                  ),
                                ),
                              ),
                              Container(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    valorUci,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 20),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(5, 3, 5, 0),
                                child: Text(valorUciHoy,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 10,
                                        color: Colors.red[600])),
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                child: Text('Pacientes UCI',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10,
                                        color: Colors.grey)),
                              )
                            ],
                          )),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          child: Column(
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 2, 0, 1),
                                child: Text(
                                  'Residencias Sanitarias',
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                  child: Row(children: <Widget>[
                                Expanded(
                                  flex: 5,
                                  child: Container(
                                      padding:
                                          EdgeInsets.fromLTRB(5, 10, 0, 10),
                                      child: Column(
                                        children: <Widget>[
                                          Align(
                                              alignment: Alignment.topLeft,
                                              child: Row(
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.lens,
                                                    size: 7,
                                                    color: Colors.green[600],
                                                  ),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            2, 0, 0, 0),
                                                    child: Text(
                                                        'Libre ($residenciaCuposLibres)',
                                                        style: TextStyle(
                                                            fontSize: 8)),
                                                  )
                                                ],
                                              )),
                                          Align(
                                              alignment: Alignment.topLeft,
                                              child: Row(
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.lens,
                                                    size: 7,
                                                    color: Colors.blue[600],
                                                  ),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            2, 0, 0, 0),
                                                    child: Text(
                                                        'Ocupado ($residenciaCuposUtilizados)',
                                                        style: TextStyle(
                                                            fontSize: 8)),
                                                  )
                                                ],
                                              )),
                                        ],
                                      )),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: PieChart(
                                      PieChartData(
                                          pieTouchData: PieTouchData(
                                              touchCallback:
                                                  (pieTouchResponse) {
                                            setState(() {
                                              if (pieTouchResponse.touchInput
                                                      is FlLongPressEnd ||
                                                  pieTouchResponse.touchInput
                                                      is FlPanEnd) {
                                                touchedIndex = -1;
                                              } else {
                                                touchedIndex = pieTouchResponse
                                                    .touchedSectionIndex;
                                              }
                                            });
                                          }),
                                          borderData: FlBorderData(
                                            show: false,
                                          ),
                                          sectionsSpace: 0,
                                          centerSpaceRadius: 12,
                                          sections: showResidencias()),
                                    ),
                                  ),
                                ),
                              ]))
                            ],
                          )),
                    ),
                    Expanded(
                      child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          child: Column(
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.fromLTRB(0, 2, 0, 1),
                                child: Text(
                                  'Ventiladores',
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                  child: Row(children: <Widget>[
                                Expanded(
                                  flex: 5,
                                  child: Container(
                                      padding:
                                          EdgeInsets.fromLTRB(5, 10, 0, 10),
                                      child: Column(
                                        children: <Widget>[
                                          Align(
                                              alignment: Alignment.topLeft,
                                              child: Row(
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.lens,
                                                    size: 7,
                                                    color: Colors.red[600],
                                                  ),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            2, 0, 0, 0),
                                                    child: Text(
                                                        'Ocupado ($ventiladoresDisponibles)',
                                                        style: TextStyle(
                                                            fontSize: 8)),
                                                  )
                                                ],
                                              )),
                                          Align(
                                              alignment: Alignment.topLeft,
                                              child: Row(
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.lens,
                                                    size: 7,
                                                    color: Colors.green[600],
                                                  ),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            2, 0, 0, 0),
                                                    child: Text(
                                                        'Libre ($ventiladoresUtilizados)',
                                                        style: TextStyle(
                                                            fontSize: 8)),
                                                  )
                                                ],
                                              )),
                                        ],
                                      )),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: PieChart(
                                      PieChartData(
                                          pieTouchData: PieTouchData(
                                              touchCallback:
                                                  (pieTouchResponse) {
                                            setState(() {
                                              if (pieTouchResponse.touchInput
                                                      is FlLongPressEnd ||
                                                  pieTouchResponse.touchInput
                                                      is FlPanEnd) {
                                                touchedIndex = -1;
                                              } else {
                                                touchedIndex = pieTouchResponse
                                                    .touchedSectionIndex;
                                              }
                                            });
                                          }),
                                          borderData: FlBorderData(
                                            show: false,
                                          ),
                                          sectionsSpace: 0,
                                          centerSpaceRadius: 12,
                                          sections: showVentiladores()),
                                    ),
                                  ),
                                ),
                              ]))
                            ],
                          )),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Regional',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 16),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        ' Datos Actualizados el $miFecha',
                        style:
                            TextStyle(fontWeight: FontWeight.w300, fontSize: 8),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                      itemCount: data == null ? 0 : data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            if (data[index]['region_name'] ==
                                'Arica y Parinacota') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Arica()),
                              );
                            } else if (data[index]['region_name'] ==
                                'Tarapacá') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Tarapaca()),
                              );
                            } else if (data[index]['region_name'] ==
                                'Antofagasta') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Antofagasta()),
                              );
                            } else if (data[index]['region_name'] ==
                                'Atacama') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Atacama()),
                              );
                            } else if (data[index]['region_name'] ==
                                'Coquimbo') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Coquimbo()),
                              );
                            } else if (data[index]['region_name'] ==
                                'Valparaíso') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Valparaiso()),
                              );
                            } else if (data[index]['region_name'] ==
                                'Metropolitana') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Metropolitana()),
                              );
                            } else if (data[index]['region_name'] ==
                                'O’Higgins') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Ohiggins()),
                              );
                            } else if (data[index]['region_name'] == 'Maule') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Maule()),
                              );
                            } else if (data[index]['region_name'] == 'Ñuble') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Nuble()),
                              );
                            } else if (data[index]['region_name'] == 'Biobío') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Biobio()),
                              );
                            } else if (data[index]['region_name'] ==
                                'Araucanía') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Araucania()),
                              );
                            } else if (data[index]['region_name'] ==
                                'Los Ríos') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Rios()),
                              );
                            } else if (data[index]['region_name'] ==
                                'Los Lagos') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Lagos()),
                              );
                            } else if (data[index]['region_name'] == 'Aysén') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Aysen()),
                              );
                            } else if (data[index]['region_name'] ==
                                'Magallanes') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Magallanes()),
                              );
                            }
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 5,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(5),
                                  child: Text(data[index]['region_name'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15),
                                      textAlign: TextAlign.left),
                                ),
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                          child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 5, 20, 5),
                                        child: Text(data[index]['infectados'],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15,
                                                color: Colors.orange[600])),
                                      )),
                                      Expanded(
                                          child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 5, 20, 5),
                                        child: Text('',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 5,
                                                color: Colors.green[600])),
                                      )),
                                      Expanded(
                                          child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 5, 20, 5),
                                        child: Text(data[index]['fallecidos'],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15,
                                                color: Colors.grey[600])),
                                      ))
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                          child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 5, 20, 5),
                                        child: Text(data[index]['pcr'],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15,
                                                color: Colors.blue[600])),
                                      )),
                                      Expanded(
                                          child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 0, 20, 20),
                                        child: Text(
                                            '+ ' + data[index]['nuevos'],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15,
                                                color: Colors.red[600])),
                                      )),
                                      Expanded(
                                          child: Container(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 5, 20, 5),
                                        child: Text(data[index]['uci'],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15,
                                                color: Colors.purple[600])),
                                      ))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ));
    }
  }

  List<PieChartSectionData> showResidencias() {
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 12 : 10; //14-10
      final double radius = isTouched ? 28 : 25; //40-35

      var libre = (int.parse(residenciaCuposLibres) * 100) /
          int.parse(residenciaCuposTotal);
      var ocupado = (int.parse(residenciaCuposUtilizados) * 100) /
          int.parse(residenciaCuposTotal);
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff19BC17),
            value: double.parse(residenciaCuposLibres),
            //value: 100,
            title: libre.toStringAsFixed(0) + '%',
            //title: '',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xff337DFF),
            value: double.parse(residenciaCuposUtilizados),
            //value: 300,
            title: ocupado.toStringAsFixed(0) + '%',
            //title: '',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
  }

  List<PieChartSectionData> showVentiladores() {
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 12 : 10; //14-10
      final double radius = isTouched ? 28 : 25; //40-35
      //print(residenciaCuposLibres);
      var libre = (int.parse(ventiladoresDisponibles) * 100) /
          int.parse(ventiladoresTotal);
      var ocupado = (int.parse(ventiladoresUtilizados) * 100) /
          int.parse(ventiladoresTotal);
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xffEA1919),
            value: double.parse(ventiladoresDisponibles),
            //value: 100,
            title: libre.toStringAsFixed(0) + '%',
            //title: '',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xff19BC17),
            value: double.parse(ventiladoresUtilizados),
            //value: 300,
            title: ocupado.toStringAsFixed(0) + '%',
            //title: '',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
  }
}
