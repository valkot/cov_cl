import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'package:cov_cl/informativos/autocuidado/indice.dart';
import 'package:cov_cl/inicio.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

class Tercero extends StatefulWidget
{
  @override
  _TerceroState createState() => _TerceroState();
}

class _TerceroState extends State<Tercero> {
  List<Slide> slides = new List();

  @override
  void initState() 
  {
    super.initState();

    slides.add
    (
      new Slide
      (
        title: "RECOMENDACIONES",
        description: "Lavado frecuente de manos",
        pathImage: "assets/lavado.png",
        //backgroundColor: 0xfff5a623,
        //backgroundColor: Colors.amber,
        colorBegin: Color(0xff49E0D0),
        colorEnd: Color(0xffEE360F),
      ),
    );
    slides.add
    (
      new Slide
      (
        title: "RECOMENDACIONES",
        description: "Estornudar o toser con el antebrazo o en pañuelo desechable",
        pathImage: "assets/estornudar.png",
        //backgroundColor: Colors.greenAccent,
        colorBegin: Color(0xff49E0D0),
        colorEnd: Color(0xffEE360F),
      ),
    );
    slides.add
    (
      new Slide
      (
        title: "RECOMENDACIONES",
        description: "Mantener distancia social de un metro",
        pathImage: "assets/distancia.png",
        colorBegin: Color(0xff49E0D0),
        colorEnd: Color(0xffEE360F),
      ),
    );
    slides.add
    (
      new Slide
      (
        title: "RECOMENDACIONES",
        description: "Evitar tocarse los ojos, la nariz y la boca",
        pathImage: "assets/tocarse.png",
        colorBegin: Color(0xff49E0D0),
        colorEnd: Color(0xffEE360F),
      ),
    );
    slides.add
    (
      new Slide
      (
        title: "RECOMENDACIONES",
        description: "No compartir artículos de higiene ni de alimentación.",
        pathImage: "assets/compartir.png",
        colorBegin: Color(0xff49E0D0),
        colorEnd: Color(0xffEE360F),
      ),
    );
    slides.add
    (
      new Slide
      (
        title: "RECOMENDACIONES",
        description: "Evitar saludar con la mano o dar besos.",
        pathImage: "assets/saludar.png",
        colorBegin: Color(0xff49E0D0),
        colorEnd: Color(0xffEE360F),
      ),
    );
    slides.add
    (
      new Slide
      (
        title: "RECOMENDACIONES",
        description: "Mantener ambientes limpios y ventilados.",
        pathImage: "assets/ambiente.png",
        colorBegin: Color(0xff49E0D0),
        colorEnd: Color(0xffEE360F),
      ),
    );
    slides.add
    (
      new Slide
      (
        title: "RECOMENDACIONES",
        description: "Estar alerta a los síntomas del COVID-19: fiebre sobre 37,8°, tos, dificultad respiratoria, dolor de garganta, dolor muscular, dolor de cabeza.",
        pathImage: "assets/sintomas.png",
        colorBegin: Color(0xff49E0D0),
        colorEnd: Color(0xffEE360F),
      ),
    );
    slides.add
    (
      new Slide
      (
        title: "RECOMENDACIONES",
        description: "En caso de dificultad respiratoria acuda a un servicio de urgencia",
        pathImage: "assets/dificultad.png",
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

    Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (BuildContext context) => Inicio()),(Route<dynamic> route) => route is Inicio);
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
        isShowPrevBtn: false ,
        isShowSkipBtn: false,
        isShowDoneBtn: false,
        isShowNextBtn: false,
        
        onDonePress: this.onDonePress,
        nameSkipBtn: 'SALTAR',
        onSkipPress: this.onSkipPress,
        nameDoneBtn: 'OK',
        nameNextBtn: 'SIG',
        namePrevBtn: 'ANT',
        
      )
    );
  }
}