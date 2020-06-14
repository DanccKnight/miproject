import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:miproject/UI/HomePage.dart';

class AboutPage extends StatelessWidget {
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
                          padding: const EdgeInsets.only(left: 0, top: 50),
                          child: SvgPicture.asset(
                            "Assets/images/dr.svg",
                            width: 230,
                            fit: BoxFit.fitWidth,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                        Positioned(
                            top: 80,
                            left: MediaQuery.of(context).size.width - 230,
                            child: Text("Get to know more \nabout us!",
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
                width: 140,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text("Our Mission",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "Many believe that it is our moral obligation to look after our elders, and we share your views. We feel that it is our duty to care for our elders responsibly, to treat them with dignity and to provide them with the highest level of care possible.",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(fontSize: 16),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, top: 10),
              child: Container(
                height: 40,
                width: 140,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text("Our Services",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "We make use of cutting edge technology to provide holistic care that focuses on all aspects of an elderly's life. We believe in respecting others privacy, so we built our services in accordance with these views. Our systems run 24x7, without intruding on the privacy of the citizens.",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(fontSize: 16),
                  ),
                ),
              ),
            )
          ]),
    ));
  }
}
