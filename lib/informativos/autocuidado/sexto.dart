import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'package:cov_cl/informativos/autocuidado/indice.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

class Sexto extends StatefulWidget
{
  @override
  _SextoState createState() => _SextoState();
}

class _SextoState extends State<Sexto> {
  List<Slide> slides = new List();

  @override
  void initState() 
  {
    super.initState();

    slides.add
    (
      new Slide
      (
        title: "SI NO PERTENEZCO",
        description: "No le corresponde cuarentena obligatoria, pero sí debe seguir las recomendaciones generales para el COVID-19. Si cree haber estado en contacto con un caso confirmado de COVID-19 pero la Seremi de Salud no le ha notificado como contacto estrecho, también debe seguir las recomendaciones generales para el COVID-19. ",
        pathImage: "assets/info_6.png",
        //backgroundColor: 0xfff5a623,
        //backgroundColor: Colors.amber,
        colorBegin: Color(0xff49E0D0),
        colorEnd: Color(0xffEE360F),
      ),
    );
  }

  void onDonePress() 
  {
    Navigator.push(context,MaterialPageRoute(builder: (context) => Indice()),);
  }

  void onSkipPress() 
  {
    Navigator.push(context,MaterialPageRoute(builder: (context) => Indice()),);
  }

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
      body: IntroSlider
      (
        slides: this.slides,
        isShowPrevBtn: false,
        isShowSkipBtn: false,
        isShowDoneBtn: false,
        /*
        onDonePress: this.onDonePress,
        nameSkipBtn: 'SALTAR',
        onSkipPress: this.onSkipPress,
        nameDoneBtn: 'OK',
        nameNextBtn: 'SIGUIENTE',
        namePrevBtn: 'ANTERIOR',
        */
      )
    );
  }
}