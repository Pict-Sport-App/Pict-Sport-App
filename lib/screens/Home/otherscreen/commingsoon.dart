import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CommingSoon extends StatelessWidget {
  const CommingSoon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h=MediaQuery.of(context).size.height;
    double w=MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: h,
        width: w,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topRight,
              colors: [
                // Color(0xFF4527A0),
                //bg,
                Color(0xFF616161),
                Color(0xFF757575),
                Color(0xFFBDBDBD),
                Color(0xFFEEEEEE)],
            )
        ),
        child: Center(
          child: SizedBox(
            height: h*0.9,
            width: w*0.8,
            child: Lottie.asset('assets/comming_soon.json'),
          ),
        ),
      ),
    );
  }
}
