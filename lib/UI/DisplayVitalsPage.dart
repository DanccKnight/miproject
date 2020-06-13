import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'HomePage.dart';

class DisplayVitalsPage extends StatefulWidget {
  @override
  _DisplayVitalsPageState createState() => _DisplayVitalsPageState();
}

class _DisplayVitalsPageState extends State<DisplayVitalsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
          ClipPath(
            clipper: MyClipper(),
            child: Container(
              padding: const EdgeInsets.all(0),
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [Color(0xFF3383CD), Color(0xFF11249F)])),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Stack(children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 68),
                        child: SvgPicture.asset(
                          "Assets/images/nurse.svg",
                          width: 230,
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                      Positioned(
                          top: 90,
                          left: MediaQuery.of(context).size.width - 200,
                          child: Text("Keep tabs on the \npatients vitals",
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ))),
                      Container()
                    ]),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Container(
              height: 40,
              width: 130,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text("Temperature",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    )),
              ),
            ),
          ),
          SizedBox(height: 120),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Container(
              height: 40,
              width: 110,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text("Heart Rate",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    )),
              ),
            ),
          ),
        ])));
  }
}

class LineReportChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.2,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: getSports(),
              isCurved: true,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
              colors: [Color(0xFF0D8E53)],
              barWidth: 4,
            ),
          ],
        ),
      ),
    );
  }

  List<FlSpot> getSports() {
    return [
      FlSpot(0, .5),
      FlSpot(1, 1.5),
      FlSpot(2, .5),
      FlSpot(3, .7),
      FlSpot(4, .2),
      FlSpot(5, 2),
      FlSpot(6, 1.5),
      FlSpot(7, 1.7),
      FlSpot(8, 1),
      FlSpot(9, 2.8),
      FlSpot(10, 2.5),
      FlSpot(11, 2.65),
    ];
  }
}
