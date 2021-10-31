import 'package:flutter/material.dart';
import 'package:division/division.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'estadisticas/cifras.dart';
import 'graficos/graficos.dart';

class Estadisticas extends StatefulWidget 
{
  @override
  _EstadisticasState createState() => _EstadisticasState();
}

class _EstadisticasState extends State<Estadisticas>
{
    @override
  void initState()
  {
    super.initState();
    SystemChrome.setPreferredOrientations
    ([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() 
  {
    // Set portrait orientation
    SystemChrome.setPreferredOrientations
    ([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }
  
 final contentStyle = (BuildContext context) => ParentStyle()
    ..overflow.scrollable()
    ..padding(vertical: 30, horizontal: 20)
    ..minHeight(MediaQuery.of(context).size.height - (2 * 30));

  final titleStyle = TxtStyle()
    ..bold()
    ..fontSize(28)
    ..margin(bottom: 40)
    ..alignmentContent.topCenter();
  
  @override
  Widget build(BuildContext context) 
  {
    return Container
    (
      color: Colors.purple[100],
      child: Column
      (
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>
        [
          Expanded
          (
            flex: 1,
            child: SizedBox(height: 50),
          ),
          Expanded
          (
            flex: 2,
            child: Txt('Estadísticas', style: titleStyle),
          ),
          Expanded
          (
            flex: 2,
            child: Salud()
          ),
          Expanded
          (
            flex: 2,
            child: Farmacias()
          ),
          Expanded
          (
            flex: 1,
            child: SizedBox(height: 50),
          )
        ],
      ),
    );
  }
}

class Salud extends StatelessWidget
{
  Widget build(BuildContext context)
  {
    return Container
    (
      padding: EdgeInsets.fromLTRB(20, 0, 20, 5),
      child: InkWell
      (
        child: Card
        (
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),),
          elevation: 10,
          color: hex('#69dce0'),
          child: Column
          (
            children: <Widget>
            [
              Container
              (
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row
                (
                  children: <Widget>
                  [
                    Expanded
                    (
                      child: Icon
                      (
                        FontAwesomeIcons.sortNumericUpAlt,
                        color: Colors.blueAccent,
                        size: 80,
                      ),
                    )
                  ],
                ),
              ),
              Container
              (
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Row
                (
                  children: <Widget>
                  [
                    Expanded
                    (
                      child: Text('Cifras', textAlign: TextAlign.center, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: ()
        {
          Navigator.push(context,MaterialPageRoute(builder: (context) => Cifras()),);
        },
      )
    );
  }
}

class Farmacias extends StatelessWidget
{
  Widget build(BuildContext context)
  {
    return Container
    (
child: Container
(
      padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
      child: InkWell
      (
        child: Card
        (
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),),
          elevation: 10,
          color: hex('#eda06d'),
          //borderOnForeground: true,
          child: Column
          (
            children: <Widget>
            [
              Container
              (
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row
                (
                  children: <Widget>
                  [
                    Expanded
                    (
                      child: Icon
                      (
                        FontAwesomeIcons.chartBar,
                        color: Colors.blueAccent,
                        size: 80,
                      ),
                    )
                  ],
                ),
              ),
              Container
              (
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Row
                (
                  children: <Widget>
                  [
                    Expanded
                    (
                      child: Text('Gráficos', textAlign: TextAlign.center, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        onTap: ()
        {
           Navigator.push(context,MaterialPageRoute(builder: (context) => Graficos()),);
        },
      )
)
    );
  }
}