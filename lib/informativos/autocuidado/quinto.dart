import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'package:cov_cl/informativos/autocuidado/indice.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

class Quinto extends StatefulWidget
{
  @override
  _QuintoState createState() => _QuintoState();
}

class _QuintoState extends State<Quinto> {
  List<Slide> slides = new List();

  @override
  void initState() 
  {
    super.initState();

    slides.add
    (
      new Slide
      (
        title: "SI SOY CONFIRMADO",
        description: "Le corresponde aislamiento estricto sin contacto con otras personas, ya sea en su domicilio, en una residencia sanitaria o en un recinto hospitalario, según la indicación del médico o autoridad sanitaria.",
        pathImage: "assets/info_5.png",
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