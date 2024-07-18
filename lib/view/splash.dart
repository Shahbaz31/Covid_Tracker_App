import 'dart:async';

import 'package:covid19_tracker/models/Worldstats.dart';
import 'package:covid19_tracker/view/CountriesListScreen.dart';
import 'package:covid19_tracker/view/world_stats.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();
  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();

  }

  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        const Duration(seconds: 10),
        () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => world_stats()))
            );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedBuilder(
              animation: _controller,
              child: Container(
                height: 200,
                width: 200,
                child: Center(
                  child: Image(
                    image: AssetImage('images/virus.png'),
                  ),
                ),
              ),
              builder: (BuildContext context, Widget? child) {
                return Transform.rotate(
                  angle: _controller.value * 2.0 * math.pi,
                  child: child,
                );
              }),
          SizedBox(
            height: 30,
          ),
          Align(
              alignment: Alignment.center,
              child: const Text(
                'Covid-19\n Tracker App',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ))
        ],
      )),
    );
  }
}
