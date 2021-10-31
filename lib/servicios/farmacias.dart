import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetalleFarmacias extends StatefulWidget
{
  @override
  _DetalleFarmaciasState createState() => _DetalleFarmaciasState();
}

class _DetalleFarmaciasState extends State<DetalleFarmacias>
{

  DateTime hoy = DateTime.now();
  List data;
  String fecha;
  String local_id;
  String fk_region;
  String fk_comuna;
  String fk_localidad;
  String local_nombre;
  String comuna_nombre;
  String localidad_nombre;
  String local_direccion;
  String funcionamiento_hora_apertura;
  String funcionamiento_hora_cierre;
  String local_telefono;
  String local_lat;
  String local_lng;
  String funcionamiento_dia;
  String laCiudad = '';
  String latitud = '';
  String longitud = '';
  String titulo = '';
  String descripcion = '';
  String direccion = '';
  String miComuna = '';

  @override
  void initState()
  {
    super.initState();
    this._getLocation();
    this.getData(); 
  }

  openMapsSheet(latitud, longitud, titulo, descripcion) async 
  {
    var miLat = double.parse(latitud);
    var miLng = double.parse(longitud);
    try 
    {
      final title = titulo;
      final description = descripcion;
      final coords = Coords(miLat, miLng);
      final availableMaps = await MapLauncher.installedMaps;
      showModalBottomSheet
      (
        context: context,
        builder: (BuildContext context) 
        {
          return SafeArea
          (
            child: SingleChildScrollView
            (
              child: Container
              (
                child: Wrap
                (
                  children: <Widget>
                  [
                    for (var map in availableMaps)
                      ListTile
                      (
                        onTap: () => map.showMarker
                        (
                          coords: coords,
                          title: title,
                          description: description,
                        ),
                        title: Text(map.mapName),
                        leading: Image
                        (
                          image: map.icon,
                          height: 30.0,
                          width: 30.0,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } 
    catch (e) 
    {
      print(e);
    }
  }

  _getLocation() async
  {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    debugPrint('location: ${position.latitude}');
    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    //print("Primero_${first.featureName} : Segundo_${first.addressLine}");
    var ciudad = first.locality.toString();
    laCiudad = ciudad.toUpperCase();
    //print(laCiudad);
  }

  Future<String> getData() async 
  {
    var response = await http.get(
      Uri.encodeFull("https://farmanet.minsal.cl/index.php/ws/getLocales"),//// https://farmanet.minsal.cl/index.php/ws/getLocalesTurno
      headers: 
      {
        "Accept": "application/json"
      }
    );
    this.setState(() 
    {
      data = jsonDecode(response.body);

    });
  }

@override
  Widget build(BuildContext context) 
  {
    //var fecha = new DateTime(hoy.year, hoy.month, hoy.day);
    //String fecha = DateFormat('dd-MM-yyyy').format(hoy);
    return new Scaffold
    (
      appBar: new AppBar
      (
        title: new Text('FARMACIAS EN $laCiudad', style: TextStyle(fontSize: 18),),
        backgroundColor: Colors.purple[200],
      ),
      body: new Container
      (
        padding: EdgeInsets.fromLTRB(0, 5, 0, 20),
        color: Colors.purple[100],
        child: Center
        (
          child: ListView.builder
          (
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (BuildContext context, int index)
            {
            if(data[index]['comuna_nombre'] == laCiudad)
            {
              
              //print('Entro : '+laCiudad);
              return GestureDetector
                  (
                    onTap: () 
                    {
                      //getData();
                      latitud = data[index]['local_lat'];
                      longitud = data[index]['local_lng'];
                      titulo = data[index]['local_nombre'];
                      descripcion = data[index]['localidad_nombre'];
                      direccion = data[index]['local_direccion'];
                      openMapsSheet(latitud,longitud, titulo, descripcion);
                    },
                    child: Row
                    (
                      children: <Widget>
                      [
                        Expanded
                        (
                          child: Card
                          (
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),),
                            elevation: 5,
                            child: Column
                            (
                              children: <Widget>
                              [
                                  SizedBox(height: 10),
                                  Container
                                  (
                                    padding: EdgeInsets.all(10),
                                    child: Row
                                    (
                                      children: <Widget>
                                      [
                                        //if(data[index]['local_nombre'] == 'INSTITUTO TRAUMATOLóGICO DR. TEODORO GEBAUER WEISSER')
                                          //Text('INSTITUTO TRAUMATOLOGICO DR. TEODORO G. W.'),
                                        Text(data[index]['local_nombre'], style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15),textAlign: TextAlign.left)
                                      ],
                                    ),
                                  ),
                                  //SizedBox(height: 5),
                                  Container
                                  (
                                    padding: EdgeInsets.all(5),
                                    child: Row
                                    (
                                      children: <Widget>
                                      [
                                        Container
                                        (
                                          
                                          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                          child: Row
                                          (
                                            children: <Widget>
                                            [
                                              Icon(FontAwesomeIcons.compass, size: 11,),
                                              Text('  '+ data[index]['localidad_nombre'], style: TextStyle(fontWeight: FontWeight.w600, fontSize: 10, color: Colors.black87),textAlign: TextAlign.left),
                                            ],
                                          ), 
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container
                                  (
                                    padding: EdgeInsets.fromLTRB(0,5,0,5),
                                    child: Row
                                    (
                                      children: <Widget>
                                      [
                                        Container
                                        (
                                          padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                                          child: Row
                                          (
                                            children: <Widget>
                                            [
                                              Icon(FontAwesomeIcons.doorOpen, size: 11,),
                                              Text('  ' + data[index]['funcionamiento_hora_apertura'],textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 10, color: Colors.green[600])),
                                            ],
                                          ),
                                        ),
                                        Container
                                        (
                                          padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                                          child: Row
                                          (
                                            children: <Widget>
                                            [
                                              Icon(FontAwesomeIcons.doorClosed, size: 11,),
                                              Text('  ' + data[index]['funcionamiento_hora_cierre'],textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 10, color: Colors.red[600])),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container
                                  (
                                    padding: EdgeInsets.fromLTRB(5,5,0,5),
                                    child: Row
                                    (
                                      children: <Widget>
                                      [
                                        Container
                                        (
                                          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                          child: Row
                                          (
                                            children: <Widget>
                                            [
                                              Icon(FontAwesomeIcons.mapMarkerAlt, size: 11,),
                                              Text('  '+ data[index]['local_direccion'], style: TextStyle(fontWeight: FontWeight.w600, fontSize: 9, color: Colors.black87),textAlign: TextAlign.left),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container
                                  (
                                    padding: EdgeInsets.all(5),
                                    child: Row
                                    (
                                      children: <Widget>
                                      [
                                        Container
                                        (
                                          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                          child: Row
                                          (
                                            children: <Widget>
                                            [
                                              Icon(FontAwesomeIcons.phone, size: 11,),
                                              Text('  ' + data[index]['local_telefono'], style: TextStyle(fontWeight: FontWeight.w600, fontSize: 10, color: Colors.black87),textAlign: TextAlign.left),
                                            ],
                                          ),                   
                                        ),

                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
              }
              return Container();
            }
          )
        ),
      )
    );
  }
}




