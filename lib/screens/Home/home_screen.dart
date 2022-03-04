import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/physics.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:psa/screens/Home/VolleyBall/volleyball.dart';
import 'package:psa/screens/Home/table_tennis/table_tannis_main_screen.dart';
import 'Basketball/basketball.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  ValueNotifier<bool> showsigninPage = ValueNotifier<bool>(true);
  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: width,
            height: height,
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/back.jpg'), fit: BoxFit.cover)),
          ),
          Transform.rotate(
            angle: 0.82,
            child: Container(
              width: width,
              height: height,
              constraints: const BoxConstraints.expand(),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/back.jpg'), fit: BoxFit.cover)),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 8.0,
              top: 20,
              right: width * 0.9,
            ),
            child: GestureDetector(
              child: const FaIcon(
                FontAwesomeIcons.bars,
                color: Colors.white,
                size: 25,
              ),
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 0.0, top: 15),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                "PICT SPORT",
                style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                    fontFamily: 'Lobster',
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
          Positioned(
            top: height * 0.2,
            width: width,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AnimationConfiguration.staggeredList(
                      position: 1,
                      duration: const Duration(milliseconds: 905),
                      child: SlideAnimation(
                        horizontalOffset: 50.0,
                        child: FadeInAnimation(
                          child: Transform(
                            transform: Matrix4.identity()
                              ..translate(
                                0.0,
                                -height * 0.04,
                              ),
                            child: MyCustomWidget(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const VolleyBallScreen();
                                }));
                              },
                              text: 'VolleyBall',
                              image: 'assets/volleyball.jpg',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AnimationConfiguration.staggeredList(
                      position: 1,
                      duration: const Duration(milliseconds: 1200),
                      child: SlideAnimation(
                        horizontalOffset: 50.0,
                        child: FadeInAnimation(
                          child: Transform(
                            transform: Matrix4.identity()
                              ..translate(
                                -width * 0.01,
                                -height * 0.06,
                              ),
                            child: MyCustomWidget(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const BasketBallScreen();
                                }));
                              },
                              text: 'BasketBall',
                              image: 'assets/basketball.jpg',
                            ),
                          ),
                        ),
                      ),
                    ),
                    AnimationConfiguration.staggeredList(
                      position: 1,
                      duration: const Duration(milliseconds: 905),
                      child: SlideAnimation(
                        horizontalOffset: 50.0,
                        child: FadeInAnimation(
                          child: Transform(
                            transform: Matrix4.identity()
                              ..translate(width * 0.01, -height * 0.06),
                            child: MyCustomWidget(
                              onTap: () {},
                              text: 'Badminton',
                              image: 'assets/badminton.jpg',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AnimationConfiguration.staggeredList(
                      position: 1,
                      duration: const Duration(milliseconds: 1500),
                      child: SlideAnimation(
                        horizontalOffset: 50.0,
                        child: FadeInAnimation(
                          child: Transform(
                            transform: Matrix4.identity()
                              ..translate(-width * 0.04, -height * 0.07),
                            child: MyCustomWidget(
                              onTap: () {},
                              text: 'Chess',
                              image: 'assets/chess.jpeg',
                            ),
                          ),
                        ),
                      ),
                    ),
                    Transform(
                        transform: Matrix4.identity()
                          ..translate(0.0, -height * 0.07),
                        child: SizedBox(
                          height: 160,
                          width: 100,
                          child: Lottie.asset(
                            'assets/sport.json',
                          ),
                        )),
                    AnimationConfiguration.staggeredList(
                      position: 1,
                      duration: const Duration(milliseconds: 905),
                      child: SlideAnimation(
                        horizontalOffset: 50.0,
                        child: FadeInAnimation(
                          child: Transform(
                            transform: Matrix4.identity()
                              ..translate(width * 0.04, -height * 0.07),
                            child: MyCustomWidget(
                              onTap: () {

                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                  return const TabletannisScreen();
                                }));
                              },
                              text: 'Tabletennis',
                              image: 'assets/TT.png',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AnimationConfiguration.staggeredList(
                      position: 1,
                      duration: const Duration(milliseconds: 1200),
                      child: SlideAnimation(
                        horizontalOffset: 50.0,
                        child: FadeInAnimation(
                          child: Transform(
                            transform: Matrix4.identity()
                              ..translate(-width * 0.01, -height * 0.09),
                            child: MyCustomWidget(
                              onTap: () {},
                              text: 'Gym',
                              image: 'assets/gym.jpg',
                            ),
                          ),
                        ),
                      ),
                    ),
                    AnimationConfiguration.staggeredList(
                      position: 1,
                      duration: const Duration(milliseconds: 905),
                      child: SlideAnimation(
                        horizontalOffset: 50.0,
                        child: FadeInAnimation(
                          child: Transform(
                            transform: Matrix4.identity()
                              ..translate(width * 0.01, -height * 0.09),
                            child: MyCustomWidget(
                              onTap: () {},
                              text: 'Football',
                              image: 'assets/football.jpg',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AnimationConfiguration.staggeredList(
                      position: 1,
                      duration: const Duration(milliseconds: 905),
                      child: SlideAnimation(
                        horizontalOffset: 50.0,
                        child: FadeInAnimation(
                          child: Transform(
                            transform: Matrix4.identity()
                              ..translate(0.0, -height * 0.1),
                            child: MyCustomWidget(
                              onTap: () {},
                              text: 'Cricket',
                              image: 'assets/cricket.jpg',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  BackgroundPainter({
    required Animation<double> animation,
  })  

  /// it just colour we defined

  : bluePaint = Paint()
          ..color = const Color(0xfff7f1ad)
          ..style = PaintingStyle.fill,
        // fill is used here because we have to fill colour not draw the line
        greyPaint = Paint()
          ..color = const Color(0xff1a4c89)
          ..style = PaintingStyle.fill,

        /// Animation obj initialization
        /// define for lerpDouble  widget

        liquidAnim = CurvedAnimation(
          curve: Curves.elasticOut,
          reverseCurve: Curves.easeInBack,
          parent: animation,
        ),
        orangeAnim = CurvedAnimation(
          parent:
              animation, // interval is allows to drive the animation from 0th second to 0.7 second
          curve: const Interval(
            0,
            0.7,
            curve: Interval(0, 0.8, curve: SpringCurve()),
          ),
          reverseCurve: Curves.linear,
        ),
        greyAnim = CurvedAnimation(
          parent: animation,
          curve: const Interval(
            0,
            0.8,
            curve: Interval(0, 0.9, curve: SpringCurve()),
          ),
          reverseCurve: Curves.easeInCirc,
        ),
        blueAnim = CurvedAnimation(
          parent: animation,
          curve: const SpringCurve(),
          reverseCurve: Curves.easeInCirc,
        ),
        super(repaint: animation); // it will trigger paint method to be called

  final Animation<double> liquidAnim;
  final Animation<double> blueAnim;
  final Animation<double> greyAnim;
  final Animation<double> orangeAnim;

  final Paint bluePaint;
  final Paint greyPaint;

  ///  Function to draw the Bezier Curve  /// i copied this function
  void _addPointsToPath(Path path, List<Point> points) {
    if (points.length < 3) {
      throw UnsupportedError('Need three or more points to create a path.');
    }

    for (var i = 0; i < points.length - 2; i++) {
      final xc = (points[i].x + points[i + 1].x) / 2;
      final yc = (points[i].y + points[i + 1].y) / 2;
      path.quadraticBezierTo(points[i].x, points[i].y, xc, yc);
    }

    // connect the last two points
    path.quadraticBezierTo(
        points[points.length - 2].x,
        points[points.length - 2].y,
        points[points.length - 1].x,
        points[points.length - 1].y);
  }

  @override
  void paint(Canvas canvas, Size size) {
    paintBlue(size, canvas);
    paintGrey(size, canvas);
  }

  void paintBlue(Size size, Canvas canvas) {
    final path = Path(); // path where u have to draw
    path.moveTo(size.width, size.height / 2);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.lineTo(
      0,
      lerpDouble(0, size.height, blueAnim.value)!,
    );
    _addPointsToPath(path, [
      Point(
        lerpDouble(0, size.width / 3, blueAnim.value)!,
        lerpDouble(0, size.height * 8, blueAnim.value)!,
      ),
      Point(
        lerpDouble(size.width / 2, size.width / 4 * 3, liquidAnim.value)!,
        lerpDouble(
            size.height * 2 / 2, size.height * 3 / 4 * 3, liquidAnim.value)!,
      ),
      Point(
        size.width,
        lerpDouble(size.height * 2 / 3, size.height * 3 / 4, liquidAnim.value)!,
      ),
    ]);
    canvas.drawPath(path, bluePaint);
  }

  void paintGrey(Size size, Canvas canvas) {
    final path = Path();
    path.moveTo(size.width, 300);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.lineTo(
      0,
      lerpDouble(
        size.height / 2,
        size.height / 1,
        greyAnim.value,
      )!,
    );
    _addPointsToPath(
      path,
      [
        Point(
          size.width / 4,
          lerpDouble(size.height * 0.2 / 1, size.height * 3 * 0.2 / 2,
              liquidAnim.value)!,
        ),
        Point(
          size.width * 3 / 5,
          lerpDouble(size.height / 2, size.height / 1, liquidAnim.value)!,
        ),
        Point(
          size.width * 4 / 5,
          lerpDouble(size.height / 3, size.height / 4, greyAnim.value)!,
        ),
        Point(
          size.width,
          lerpDouble(size.height / 2.5, size.height / 2.5, greyAnim.value)!,
        ),
      ],
    );

    canvas.drawPath(path, greyPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class Point {
  final double x;
  final double y;
  Point(this.x, this.y);
}

/// Custom curve to give gooey spring effect
class SpringCurve extends Curve {
  const SpringCurve({
    this.a = 0.15,
    this.w = 19.4,
  });
  final double a;
  final double w;

  @override
  double transformInternal(double t) {
    return (-(pow(e, -t / a) * cos(t * w)) + 1).toDouble();
  }
}

class MyCustomWidget extends StatefulWidget {
  late String image;
  late String text;
  late VoidCallback onTap;
  MyCustomWidget(
      {Key? key, required this.onTap, required this.image, required this.text})
      : super(key: key);
  @override
  _MyCustomWidgetState createState() => _MyCustomWidgetState();
}

class _MyCustomWidgetState extends State<MyCustomWidget> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Column(
          children: [
            Container(
              height: height * 0.1,
              width: width * 0.22,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12, width: 3),
                image: DecorationImage(
                    image: AssetImage(widget.image), fit: BoxFit.fill),
                // color: const Color(0xff8639FB),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(
                      0,
                      0,
                    ),
                    blurRadius: 10.0,
                    spreadRadius: 3.0,
                  ), //BoxShadow
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(0.0, 0.0),
                    blurRadius: 0.0,
                    spreadRadius: 0.0,
                  ), //BoxShadow
                ],
              ),
            ),
            Center(
              child: Text(
                widget.text,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DraggableCard extends StatefulWidget {
  final Widget child;

  const DraggableCard({Key? key, required this.child}) : super(key: key);

  @override
  _DraggableCardState createState() => _DraggableCardState();
}

class _DraggableCardState extends State<DraggableCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  var _dragAlignment = Alignment.center;

  late Animation<Alignment> _animation;

  final _spring = const SpringDescription(
    mass: 7,
    stiffness: 1200,
    damping: 0.7,
  );

  double _normalizeVelocity(Offset velocity, Size size) {
    final normalizedVelocity = Offset(
      velocity.dx / size.width,
      velocity.dy / size.height,
    );
    return -normalizedVelocity.distance;
  }

  void _runAnimation(Offset velocity, Size size) {
    _animation = _controller.drive(
      AlignmentTween(
        begin: _dragAlignment,
        end: Alignment.center,
      ),
    );

    final simulation =
        SpringSimulation(_spring, 0.0, 1.0, _normalizeVelocity(velocity, size));

    _controller.animateWith(simulation);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController.unbounded(vsync: this)
      ..addListener(() => setState(() => _dragAlignment = _animation.value));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onPanStart: (details) => _controller.stop(canceled: true),
      onPanUpdate: (details) => setState(
        () => _dragAlignment += Alignment(
          details.delta.dx / (size.width / 2),
          details.delta.dy / (size.height / 2),
        ),
      ),
      onPanEnd: (details) =>
          _runAnimation(details.velocity.pixelsPerSecond, size),
      child: Align(
        alignment: _dragAlignment,
        child: Card(
          child: widget.child,
        ),
      ),
    );
  }
}
