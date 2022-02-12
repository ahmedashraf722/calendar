import 'dart:math';
import 'package:calendar/ui/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromRGBO(215, 20, 255, 1).withOpacity(0.5),
                  const Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [0, 1],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 50.0, left: 100.0),
            child: Text(
              'Calendar',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 45,
              ),
            ),
          ),
          Center(
            child: InkWell(
              onTap: () {
                Get.to(const AppLoginScreen());
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
                transform: Matrix4.rotationZ(-8 * pi / 180)..translate(-10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.deepOrange[900],
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 8,
                      color: Colors.black45,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: const Text(
                  'Get Started',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 45,
                  ),
                ),
              ),
            ),
          ),
          const Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Welcome to Add Events',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 33,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
