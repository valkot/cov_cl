import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

class Primero extends StatefulWidget
{
  @override
  _PrimeroState createState() => _PrimeroState();
}

class _PrimeroState extends State<Primero> {
  List<Slide> slides = new List();

  @override
  void initState() 
  {
    super.initState();

    slides.add
    (
      new Slide
      (
        title: "¿Qué es el Covid-19?",
        description: "Es una enfermedad infecciosa causada por el coronavirus recientemente descubierto (SARS-CoV-2) que produce síntomas similares a la gripe y en algunos casos Infección Respiratoria Aguda Grave",
        pathImage: "assets/info_1.png",
        //backgroundColor: 0xfff5a623,
        //backgroundColor: Colors.amber,
        colorBegin: Color(0xff49E0D0),
        colorEnd: Color(0xffEE360F),
      ),
    );
  }

  void onDonePress() 
  {
    //Navigator.push(context,MaterialPageRoute(builder: (context) => Informativos()),);
    //Informativos();
  }

  void onSkipPress() 
  {
    //Informativos();
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