import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          color: Colors.white,
          width: double.infinity,
          height: double.infinity,
          child: const RiveAnimation.asset(''
              'assets/loader.riv')),
    );
  }
}
