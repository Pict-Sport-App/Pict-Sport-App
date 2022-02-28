import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          color: Colors.white,
          width: double.infinity,
          height: double.infinity,
          child: const SpinKitRotatingPlain(
            color: Colors.red,
          )),
    );
  }
}
