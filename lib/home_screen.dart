import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  double? heading = 0;

  @override
  void initState(){
    super.initState();
    FlutterCompass.events!.listen((event) {
      Timer(const Duration(milliseconds: 200), (){
        setState((){
           heading = event.heading;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //print(((heading ?? 0) * (pi/360) * -1));
    return Scaffold(
       backgroundColor: Colors.black,
       appBar: AppBar(
         backgroundColor: Colors.grey.shade900,
         centerTitle: true,
         title: const Text("Compass App", style: TextStyle(color: Colors.white, fontSize: 16)),
       ),
       body: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
            Text(
                "${heading!.ceil()}", style: const TextStyle(color: Colors.white, fontSize: 26.0, fontWeight: FontWeight.bold)
            ),
            const SizedBox(height: 50.0),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                     //Image.asset('assets/cadrant.png'),
                     Transform.rotate(
                         angle: ((heading ?? 0) * (pi/360) * -1),
                         child:  SfRadialGauge(
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
                                   offset: 115,
                                   child: RotatedBox(
                                       quarterTurns: 1,
                                       child: ClipRRect(
                                         borderRadius: BorderRadius.circular(60),
                                         child: Image.asset(
                                           'assets/compass.png',
                                           scale: 1.7,
                                         ),
                                       )),
                                 )
                               ],
                               minimum: 0,
                               maximum: 360,
                               minorTicksPerInterval: 4,
                               minorTickStyle: const MinorTickStyle(length: 6, thickness: 0.5, color: Colors.white),
                               majorTickStyle: const MajorTickStyle(length: 12, thickness: 0.5, color: Colors.white),
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
                         ),
                     )
                  ],
                ),
            )
         ],
       ),
    );
  }
}
