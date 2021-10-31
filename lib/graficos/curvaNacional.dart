import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'dart:async';

class CurvaNacional extends StatefulWidget 
{
  @override
  _CurvaNacionalState createState() => _CurvaNacionalState();
  
}

class _CurvaNacionalState extends State<CurvaNacional> 
{
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
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
        title: Text("CURVA DE CONTAGIO SARS-COV2 CHILE")
      ),
      body: WebviewScaffold
      (
        //url: "http://186.64.121.251/app-urology/grafico/covid.php",
        url: "http://186.64.121.251/app-urology/grafico/covidAndroid.php",
          withZoom: false,
          withLocalStorage: true,
      ),
    );
  }
}
