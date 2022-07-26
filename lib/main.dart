// @dart=2.9
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_compass_app/home_screen.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
      title: 'Flutter Compass',
      theme: ThemeData(brightness: Brightness.dark),
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      home: Scaffold(
          backgroundColor: Colors.black,
          body: HomeScreen(),
          //body: Compass()
      )
  );
}

class Compass extends StatefulWidget {

  Compass({Key key}) : super(key: key);

  @override
  _CompassState createState() => _CompassState();
}

class _CompassState extends State<Compass> with SingleTickerProviderStateMixin {

  double _heading = 0;

  String get _readout => _heading.toStringAsFixed(0) + '°';

  @override
  void initState() {

    super.initState();
    //FlutterCompass.events!.listen(_onData);
  }

  void _onData(double x) => setState(() { _heading = x; });

  final TextStyle _style = TextStyle(
    color: Colors.red[50]?.withOpacity(0.9),
    fontSize: 32,
    fontWeight: FontWeight.w200,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: compassPainter(_heading),
    );
  }
}

Widget compassPainter(double angles) {

  //CompassPainter({@required this.angle }) : super();

  double rotation = -2 * pi * (angles / 360);
  print(rotation.toString());

  return Transform.rotate(
       angle: rotation,
       child: SfRadialGauge(
         axes: <RadialAxis>[
         RadialAxis(
           pointers: [
             const MarkerPointer(
               value: 0,
               markerHeight: 20,
               markerWidth: 20,
               elevation: 4,
        ),
        WidgetPointer(
          child: RotatedBox(
          quarterTurns: 1,
          child: ClipRRect(
          borderRadius: BorderRadius.circular(60),
         child: Image.asset(
             'assets/compass.jpg',
             scale: 2,
          ),
         )),
         offset: 115,
        )
       ],
        minimum: 0,
        maximum: 360,

  minorTicksPerInterval: 4,
  minorTickStyle: MinorTickStyle(
  length: 6, thickness: 0.5, color: Colors.white),
  majorTickStyle: MajorTickStyle(
  length: 12, thickness: 0.5, color: Colors.white),
  startAngle: 0,
  interval: 20,
  endAngle: 360,
  canRotateLabels: true,
  ranges: [
  GaugeRange(
  startValue: 0,
  endValue: 360,
  // label: "0",
  color: Colors.white.withOpacity(0.5),
  // startWidth: 40,
  // endWidth: 40,
  )
  ],
  axisLabelStyle:
  GaugeTextStyle(fontSize: 8, color: Colors.white),
  )
  ],
  ));
  // Paint get _brush => new Paint()
  //   ..style = PaintingStyle.stroke
  //   ..strokeWidth = 2.0;
  //
  // @override
  // void paint(Canvas canvas, Size size) {
  //
  //   Paint circle = _brush
  //     ..color = Colors.indigo;
  //
  //   Paint needle = _brush
  //     ..color = Colors.red;
  //
  //   double radius = min(size.width / 2.2, size.height / 2.2);
  //   Offset center = Offset(size.width / 2, size.height / 2);
  //   Offset start = Offset.lerp(Offset(center.dx, radius), center, .4);
  //   Offset end = Offset.lerp(Offset(center.dx, radius), center, 0.1);
  //
  //   canvas.translate(center.dx, center.dy);
  //   canvas.rotate(rotation);
  //   canvas.translate(-center.dx, -center.dy);
  //   canvas.drawLine(start, end, needle);
  //   canvas.drawCircle(center, radius, circle);
  // }
  //
  // @override
  // bool shouldRepaint(CustomPainter oldDelegate) => true;
}
