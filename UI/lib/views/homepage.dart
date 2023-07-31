//import 'package:Astral/screens/main_home_page.dart';
import 'package:Astral/pages/home_page.dart';
import 'package:Astral/views/home.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'package:Astral/model/datas.dart';
import 'package:Astral/views/constants.dart';
import 'package:Astral/views/detailsview.dart';
import '../core/res/color.dart';
import '../core/routes/routes.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var flag = 0;
    return Scaffold(
      backgroundColor: gradientEndColor,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [gradientStartColor, gradientEndColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: <Widget>[
                  Row(
                    children: const [
                      Text(
                        'Explore',
                        style: TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: 40,
                            color: Color(0xffffffff),
                            fontWeight: FontWeight.w900),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                  Row(
                    children: const [
                      Text(
                        'Solar System',
                        style: TextStyle(
                            fontFamily: 'Avenir',
                            fontSize: 24,
                            color: Color(0x7cdbf1ff),
                            fontWeight: FontWeight.w900),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 500,
              child: Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: Swiper(
                  itemCount: planets.length,
                  fade: 0.3,
                  itemWidth: MediaQuery.of(context).size.width - 2 * 64,
                  layout: SwiperLayout.STACK,
                  pagination: SwiperPagination(
                      builder: DotSwiperPaginationBuilder(
                          activeSize: 20,
                          activeColor: Colors.yellow.shade300,
                          space: 5)),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        flag = flag * 10 + (index + 1);
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                              opaque: false,
                              pageBuilder: (context, a, b) => DetailsView(
                                planetInfo: planets[index],
                              ),
                              transitionsBuilder: (BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secondaryAnimation,
                                  Widget child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                            ));
                      },
                      child: Stack(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              const SizedBox(
                                height: 100,
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32)),
                                elevation: 8,
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(32.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      const SizedBox(
                                        height: 100,
                                      ),
                                      Text(
                                        planets[index].name.toString(),
                                        style: const TextStyle(
                                            fontSize: 40,
                                            fontFamily: 'Avenir',
                                            color: Color(0xff47455f),
                                            fontWeight: FontWeight.w900),
                                        textAlign: TextAlign.left,
                                      ),
                                      Text(
                                        "Solar System",
                                        style: TextStyle(
                                            fontSize: 23,
                                            fontFamily: 'Avenir',
                                            color: primaryTextColor,
                                            fontWeight: FontWeight.w400),
                                        textAlign: TextAlign.left,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 32.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              "Know more",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'Avenir',
                                                  color: secondaryTextColor,
                                                  fontWeight: FontWeight.w400),
                                              textAlign: TextAlign.left,
                                            ),
                                            Icon(
                                              Icons.arrow_forward_rounded,
                                              color: secondaryTextColor,
                                              size: 18,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Hero(
                              tag: planets[index].position,
                              child: Image.asset(
                                  planets[index].iconImage.toString()))
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          child: Icon(null),
          backgroundColor: Colors.transparent,
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightElevation: 0,
          hoverElevation: 0,
          elevation: 0,
          foregroundColor: Colors.white,
          onPressed: () => {
                print("$flag"),
                if (flag == 628)
                  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeEncryptionPage()),
                    ),
                    flag = 0,
                  }
              }),
    );
  }
}
