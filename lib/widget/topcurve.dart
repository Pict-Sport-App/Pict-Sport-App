import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String name;
  const Button({Key? key,required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Text(
      name,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onPrimary,
        fontSize: 20,
      ),
    );
  }
}


class Constan extends StatelessWidget {
  const Constan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    return Align(
      alignment: Alignment.topRight,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 455,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: CustomPaint(
            size:
            Size(width, 340),
            painter: LogoPainter2(),
          ),
        ),
      ),
    );
  }
}
class Constan2 extends StatelessWidget {
  const Constan2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    return Align(
      alignment: Alignment.topRight,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height:  MediaQuery.of(context).size.height*9,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: CustomPaint(
            size:
            Size(width, 340),
            painter: LogoPainter3(),
          ),
        ),
      ),
    );
  }
}


class LogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    var rect = Offset.zero & size;
    paint.shader = const LinearGradient(
      /// how LinearGradient is used in custom painter ?
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xffbd274f2),
        Color(0xff9507c4),
      ],
    ).createShader(rect);
    var path = Path();
    path.lineTo(0, size.height - size.height / 6);
    path.lineTo(size.width / 1.3, size.height - 19);
    path.relativeQuadraticBezierTo(35, 4, 58, -13);
    path.lineTo(size.width, size.height - size.height / 6);
    path.lineTo(size.width, 0);
    path.close();
    canvas.drawShadow(path, const Color(0xffb08cca), 6.0, false);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = const Color(0xff9507c4);
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * 0.9167);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.875,
        size.width * 0.5, size.height * 0.9167);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.9584,
        size.width * 1.0, size.height * 0.9167);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
class LogoPainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    var rect = Offset.zero & size;
    paint.shader = const LinearGradient(
      /// how LinearGradient is used in custom painter ?
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.white,Colors.white
      ],
    ).createShader(rect);
    var path = Path();
    path.lineTo(0, size.height - size.height / 5.5);
    path.lineTo(size.width / 1.3, size.height - 19);
    path.relativeQuadraticBezierTo(33, 4.2, 58, -22);
    path.lineTo(size.width, size.height - size.height / 5.8);
    path.lineTo(size.width, 0);
    path.close();
    canvas.drawShadow(path, const Color(0xffb08cca), 6.0, false);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
class LogoPainter3 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    var rect = Offset.zero & size;
    paint.shader = const LinearGradient(
      /// how LinearGradient is used in custom painter ?
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.white,Colors.white
      ],
    ).createShader(rect);
    var path = Path();
    path.lineTo(0, size.height - size.height / 5.5);
    path.lineTo(size.width / 1.3, size.height - 55);
    path.relativeQuadraticBezierTo(33, 4.2, 58, -30);
    path.lineTo(size.width, size.height - size.height / 5.0);
    path.lineTo(size.width, 0);
    path.close();
    canvas.drawShadow(path, const Color(0xffb08cca), 6.0, false);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}