import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RotateSquare extends StatefulWidget {
  const RotateSquare({super.key});

  @override
  State<RotateSquare> createState() => _RotateSquareState();
}

class _RotateSquareState extends State<RotateSquare> {
  MethodChannel gyroscopeChannel = const MethodChannel("gyroscope_channel");
  double smoothedAngle = 0.0;
  final double smoothingFactor = 0.1;
  @override
  void initState() {
    gyroscopeChannel.setMethodCallHandler((call) async {
      if (call.method == "updateGyroscopeValues") {
        setState(() {
          double newAngle =
              Platform.isIOS ? call.arguments['y'] : call.arguments[1];
          smoothedAngle = (newAngle * smoothingFactor) +
              (smoothedAngle * (1.0 - smoothingFactor));
        });
      }
    });
    super.initState();
  }

  double clampRotation(double rotation) {
    return max(-pi, min(pi, rotation));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 16,
          ),
          Center(
              child: Transform.rotate(
            filterQuality: FilterQuality.high,
            angle: clampRotation(smoothedAngle * -1),
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          )),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
