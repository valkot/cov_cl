import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'package:cov_cl/informativos/autocuidado/indice.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

class Cuarto extends StatefulWidget
{
  @override
  _CuartoState createState() => _CuartoState();
}

class _CuartoState extends State<Cuarto> {
  List<Slide> slides = new List();

  @override
  void initState() 
  {
    super.initState();

    slides.add
    (
      new Slide
      (
        title: "SINTOMAS",
        description: "Todos los días que dure la cuarentena, debe estar atento a la aparición de síntomas, tales como fiebre sobre 37,8º, dolor de garganta, dolores musculares, tos y dificultad para respirar. Se recomienda controlar la temperatura 2 veces al día.",
        pathImage: "assets/sintomas.png",
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
        title: "SINTOMAS",
        description: "Si presenta alguno de estos síntomas debe llamar al teléfono de Salud Responde y si tiene dificultad respiratoria, diríjase al centro de salud más cercano.",
        pathImage: "assets/info_4a.png",
        //backgroundColor: Colors.greenAccent,
        colorBegin: Color(0xff49E0D0),
        colorEnd: Color(0xffEE360F),
      ),
    );
    slides.add
    (
      new Slide
      (
        title: "SINTOMAS",
        description: "El traslado, en lo posible, deberá ser realizado con mascarilla y a través de un medio que involucre el menor contacto con personas. Evite particularmente el contacto con personas mayores o pacientes con enfermedades crónicas.",
        pathImage: "assets/auto.png",
        //backgroundColor: Colors.greenAccent,
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
        isShowNextBtn: false,
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