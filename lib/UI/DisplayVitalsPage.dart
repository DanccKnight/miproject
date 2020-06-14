import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'HomePage.dart';

class DisplayVitalsPage extends StatefulWidget {
  var doc;

  DisplayVitalsPage({Key key, this.doc}) : super(key: key);

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
              width: 70,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text("Vitals",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    )),
              ),
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: temperatureCard('Temperature', '36 °C'),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: heartRateCard('Heart Rate', '73 BPM'),
              )
            ],
          ),
          SizedBox(height: 20),
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
                child: Text("Patient Data",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    )),
              ),
            ),
          ),
          SizedBox(height: 20),
          FutureBuilder(
            future: Firestore.instance
                .collection('Patients')
                .document(widget.doc)
                .get(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: CircularProgressIndicator(),
                ));
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 260,
                  width: double.infinity,
                  child: Card(
                    elevation: 5,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            children: [
                              Text("Name: ",
                                  style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 18)),
                              Text(snapshot.data['name'],
                                  style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 18)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            children: [
                              Text("Age: ",
                                  style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 18)),
                              Text(snapshot.data['age'],
                                  style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 18)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            children: [
                              Text("Gender: ",
                                  style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 18)),
                              Text(snapshot.data['gender'],
                                  style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 18)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            children: [
                              Text("Blood Group: ",
                                  style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 18)),
                              Text(snapshot.data['blood_group'],
                                  style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 18)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            children: [
                              Text("Room no: ",
                                  style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 18)),
                              Text(snapshot.data['room_no'],
                                  style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 18)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            children: [
                              Text("Device ID: ",
                                  style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 18)),
                              Text(snapshot.data['device_id'],
                                  style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 18)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            children: [
                              Text("Phone number: ",
                                  style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 18)),
                              Text(snapshot.data['phone_no'],
                                  style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 18)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            children: [
                              Text("Relative Contact Number: ",
                                  style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 18)),
                              Text(snapshot.data['relative_contact'],
                                  style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 18)),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 20)
        ])));
  }

  Widget temperatureCard(String heading, String temp) {
    return Card(
      elevation: 4,
      child: Container(
        height: 110,
        width: 160,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12, top: 15),
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: SvgPicture.asset("Assets/images/increase.svg"),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        height: 12,
                        width: 12,
                      ),
                      SizedBox(width: 12),
                      Text(
                        heading,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15, top: 10),
                      child: RichText(
                          text: TextSpan(children: [
                        TextSpan(
                            text: temp,
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(
                                    fontSize: 26, fontWeight: FontWeight.bold)),
                      ])),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 10),
              child: MyBarChart(),
            )
          ],
        ),
      ),
    );
  }

  Widget heartRateCard(String heading, String num) {
    return Card(
      elevation: 4,
      child: Container(
        height: 110,
        width: 160,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12, top: 15),
              child: Row(
                children: <Widget>[
                  Container(
                    child: SvgPicture.asset("Assets/images/increase.svg"),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    height: 12,
                    width: 12,
                  ),
                  SizedBox(width: 12),
                  Text(
                    heading,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 35, top: 10),
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: num,
                        style: Theme.of(context).textTheme.headline6.copyWith(
                            fontSize: 26, fontWeight: FontWeight.bold)),
                  ])),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(height: 37, width: 70, child: LineReportChart()),
            ),
          ],
        ),
      ),
    );
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
      FlSpot(0, 1),
      FlSpot(1, 1.3),
      FlSpot(2, 1.23),
      FlSpot(3, 1.33),
      FlSpot(4, 1.61),
      FlSpot(5, 1.59),
      FlSpot(6, 1.88),
      FlSpot(7, 1.9),
      FlSpot(8, 1.95),
      FlSpot(9, 2.4),
      FlSpot(10, 2.5),
      FlSpot(11, 2.49),
    ];
  }
}

class MyBarChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, top: 0),
      child: Container(
        height: 60,
        width: 10,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.withOpacity(0.5)),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.red),
            height: 36,
          ),
        ),
      ),
    );
  }
}
