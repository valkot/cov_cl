import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

class Acercade extends StatefulWidget 
{
  @override
  _AcercadeState createState() => _AcercadeState();
}

class _AcercadeState extends State<Acercade>
{
  
  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp
    (
      //title: 'Material App',
      home: Scaffold
      (
        backgroundColor: Colors.purple[100],
        appBar: AppBar
        (
          backgroundColor: Colors.purple[200],
          title: Text('Acerca De'),
        ),
        body: Center
        (
          child: Container
          (
            padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
            child: Column
            (
              children: <Widget>
              [
                Expanded
                (
                  flex: 3,
                  child: Image.asset('assets/covcl.png')
                ),
                SizedBox(height: 20),
                Expanded
                (
                  flex: 7,
                  child: SingleChildScrollView
                  (
                    child: Linkify
                    (
                      onOpen: (link) async 
                      {
                        if (await canLaunch(link.url)) 
                        {
                          await launch(link.url);
                        } 
                        else 
                        {
                          throw 'Could not launch $link';
                        }
                      },
                      text: 'CovCl es una aplicación desarrollada por el Departamento de Gestión de Tecnologías de la Información (DGTIC) perteneciente al Servicio de Salud Metropolitano Sur (SSMS), Santiago, Chile.\n\n'+
                      'La información contenida en esta aplicación es de libre acceso y es recopilada de fuentes oficiales que el Gobierno de Chile dispone a la comunidad, si desea conocer la fuente de obtención de información de esta aplicación visitar http://www.minsal.cl.\n\n'+
                      'Si necesita mayor información sobre nosotros puede visitar nuestro sitio web http://ssms.cl',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.justify,
                      linkStyle: TextStyle(color: Colors.blue),
                    )            
                  ),
                )
              ],
            )
          ),
        ),
      ),
    );
  }
}