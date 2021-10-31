import 'package:cov_cl/graficos/acumuladoRegional.dart';
import 'package:cov_cl/graficos/fallecidosEtario.dart';
import 'package:cov_cl/graficos/pacientesCriticos.dart';
import 'package:cov_cl/graficos/uciEtario.dart';
import 'package:cov_cl/graficos/uciRegional.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'curvaNacional.dart';
import 'pcrRegional.dart';
import 'ventiladoresAcumulado.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Graficos extends StatefulWidget 
{
  @override
  _GraficosState createState() => _GraficosState();
  
} 

class _GraficosState extends State<Graficos> 
{
  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      appBar: AppBar
      (
        backgroundColor: Colors.purple[200],
        title: Text('Gráficos'),
      ),
      body: ListView
      (
        children: <Widget>
        [
          InkWell
          (
            child: Card
            (
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
              elevation: 5,
              child: ListTile
              (
                leading: Icon(FontAwesomeIcons.chartArea),
                trailing: Icon(FontAwesomeIcons.chevronRight),
                title: Text('Acumulado Nacional', style: TextStyle(fontWeight: FontWeight.w600),),
                subtitle: Text('Confirmados, Recuperados, Fallecidos y Activos', style: TextStyle(fontSize: 11),),
              )
            ),
            onTap: ()
            {
              Navigator.push(context,MaterialPageRoute(builder: (context) => CurvaNacional()),);
            },
          ),
          InkWell
          (
            child: Card
            (
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
              elevation: 5,
              child: ListTile
              (
                leading: Icon(FontAwesomeIcons.chartBar),
                trailing: Icon(FontAwesomeIcons.chevronRight),
                title: Text('Acumulado Regional', style: TextStyle(fontWeight: FontWeight.w600),),
                subtitle: Text('Confirmados por región', style: TextStyle(fontSize: 11),),
              )
            ),
            onTap: ()
            {
              Navigator.push(context,MaterialPageRoute(builder: (context) => AcumuladoRegional()),);
            },
          ),
          InkWell
          (
            child: Card
            (
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
              elevation: 5,
              child: ListTile
              (
                leading: Icon(FontAwesomeIcons.chartBar),
                trailing: Icon(FontAwesomeIcons.chevronRight),
                title: Text('PCR Acumulado Regional', style: TextStyle(fontWeight: FontWeight.w600),),
                subtitle: Text('Exámenes de PCR por región', style: TextStyle(fontSize: 11),),
              )
            ),
            onTap: ()
            {
              Navigator.push(context,MaterialPageRoute(builder: (context) => PcrRegional()),);
            },
          ),
          InkWell
          (
            child: Card
            (
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
              elevation: 5,
              child: ListTile
              (
                leading: Icon(FontAwesomeIcons.chartBar),
                trailing: Icon(FontAwesomeIcons.chevronRight),
                title: Text('UCI Acumulado Regional', style: TextStyle(fontWeight: FontWeight.w600),),
                subtitle: Text('Pacientes en UCI por región', style: TextStyle(fontSize: 11),),
              )
            ),
            onTap: ()
            {
              Navigator.push(context,MaterialPageRoute(builder: (context) => UciRegional()),);
            },
          ),
          InkWell
          (
            child: Card
            (
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
              elevation: 5,
              child: ListTile
              (
                leading: Icon(FontAwesomeIcons.chartBar),
                trailing: Icon(FontAwesomeIcons.chevronRight),
                title: Text('Hospitalizados Acumulado', style: TextStyle(fontWeight: FontWeight.w600),),
                subtitle: Text('Pacientes hotpitalizados por rango etario', style: TextStyle(fontSize: 11),),
              )
            ),
            onTap: ()
            {
              Navigator.push(context,MaterialPageRoute(builder: (context) => UciEtario()),);
            },
          ),
          InkWell
          (
            child: Card
            (
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
              elevation: 5,
              child: ListTile
              (
                leading: Icon(FontAwesomeIcons.chartBar),
                trailing: Icon(FontAwesomeIcons.chevronRight),
                title: Text('Fallecidos Acumulado', style: TextStyle(fontWeight: FontWeight.w600),),
                subtitle: Text('Pacientes fallecidos por rango etario', style: TextStyle(fontSize: 11),),
              )
            ),
            onTap: ()
            {
              Navigator.push(context,MaterialPageRoute(builder: (context) => FallecidosEtario()),);
            },
          ),
          InkWell
          (
            child: Card
            (
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
              elevation: 5,
              child: ListTile
              (
                leading: Icon(FontAwesomeIcons.chartBar),
                trailing: Icon(FontAwesomeIcons.chevronRight),
                title: Text('Ventiladores Acumulado', style: TextStyle(fontWeight: FontWeight.w600),),
                subtitle: Text('Cantidad de ventiladores disponibles', style: TextStyle(fontSize: 11),),
              )
            ),
            onTap: ()
            {
              Navigator.push(context,MaterialPageRoute(builder: (context) => VentiladoresAcumulado()),);
            },
          ),
         /* 
          InkWell
          (
            child: Card
            (
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
              elevation: 5,
              child: ListTile
              (
                leading: Icon(FontAwesomeIcons.chartBar),
                trailing: Icon(FontAwesomeIcons.chevronRight),
                title: Text('Sintomas Acumulado', style: TextStyle(fontWeight: FontWeight.w600),),
                subtitle: Text('Sintomas presentes en la enfermedad', style: TextStyle(fontSize: 11),),
              )
            ),
            onTap: ()
            {
              //Navigator.push(context,MaterialPageRoute(builder: (context) => AcumuladoRegional()),);
            },
          ),
        */
          InkWell
          (
            child: Card
            (
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
              elevation: 5,
              child: ListTile
              (
                leading: Icon(FontAwesomeIcons.chartLine),
                trailing: Icon(FontAwesomeIcons.chevronRight),
                title: Text('Pacientes Críticos Acumulado', style: TextStyle(fontWeight: FontWeight.w600),),
                subtitle: Text('Pacientes críticos en UCI', style: TextStyle(fontSize: 11),),
              )
            ),
            onTap: ()
            {
              Navigator.push(context,MaterialPageRoute(builder: (context) => PacientesCriticos()),);
            },
          ),
          
        ],
      ),
    );
  }
}