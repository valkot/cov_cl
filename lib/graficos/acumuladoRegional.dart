import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';


import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


class AcumuladoRegional extends StatefulWidget 
{
  @override
  _AcumuladoRegionalState createState() => _AcumuladoRegionalState();
  
}

class _AcumuladoRegionalState extends State<AcumuladoRegional> 
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
        title: Text("CURVA DE CONTAGIO ACUMULADO REGIONAL")
      ),
      body: WebviewScaffold
      (
        //url: "http://186.64.121.251/app-urology/grafico/covidRegional.php",
        url: "http://186.64.121.251/app-urology/grafico/covidRegionalAndroid.php",
          withZoom: false,
          withLocalStorage: true,
      ),
    );
    /*
    return FutureBuilder<String>(
      future: _loadLocalHTML(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return WebviewScaffold(
            appBar: AppBar(title: Text("CURVA DE CONTAGIO SARS-COV2 CHILE")),
            withJavascript: true,
            appCacheEnabled: true,
            url: new Uri.dataFromString(snapshot.data, mimeType: 'text/html')
                .toString(),
          );
        } else if (snapshot.hasError) {
          return Scaffold
          (
            body: Center
            (
              child: Text("${snapshot.error}"),
            ),
            
          );
        }
        return Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );*/
  }
}
/*
Future<String> _loadLocalHTML() async {
  return await rootBundle.loadString('assets/webs/covid.php');
}
*/