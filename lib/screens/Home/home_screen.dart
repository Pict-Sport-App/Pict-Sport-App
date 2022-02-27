/*

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:psa/appdrFawer/commans/collaps_navigation_bar.dart';
import 'package:psa/screens/Home/sport.dart';
import 'package:psa/models/userDetails.dart';
import 'package:psa/screens/Home/sports_card.dart';
import 'package:psa/screens/Home/table_tennis/table_tannis_main_screen.dart';

import 'Basketball/basketball.dart';
<<<<<<< Updated upstream
import 'VolleyBall/Volleyball.dart';
=======
import 'dhiarjIssueWidget.dart';
>>>>>>> Stashed changes

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scrollController = ScrollController();

  void onListen() {
    setState(() {});
  }

  List<Sport> myList = [];

  void mySportList() {
    myList.clear();
    for (int i = 0; i < UserDetails.mySportsList!.length; i++) {
      if (UserDetails.mySportsList![i] == 'BasketBall') {
        myList.add(item4);
      } else if (UserDetails.mySportsList![i] == 'VolleyBall') {
        myList.add(item5);
      } else if (UserDetails.mySportsList![i] == 'TableTennis') {
        myList.add(item2);
      } else if (UserDetails.mySportsList![i] == 'Badminton') {
        myList.add(item6);
      } else if (UserDetails.mySportsList![i] == 'Cricket') {
        myList.add(item3);
      } else if (UserDetails.mySportsList![i] == 'FootBall') {
        myList.add(item1);
      } else if (UserDetails.mySportsList![i] == 'Chess') {
        myList.add(item7);
      } else if (UserDetails.mySportsList![i] == 'Gym') {
        myList.add(item8);
      }
    }
  }

  @override
  void initState() {
    mySportList();
    //myList.addAll(List.from(myList));
    scrollController.addListener(onListen);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(onListen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 0, right: 0, top: 0),
        child: CustomScrollView(
          controller: scrollController,
          slivers: <Widget>[
            SliverAppBar(
              // centerTitle: true,
              actions: [
                Padding(
                  padding:  EdgeInsets.only(left: 8.0,top: 12,right:  MediaQuery.of(context).size.width *0.9,),
                  child: Container(
                    child: GestureDetector(
                      child: const FaIcon(
                        FontAwesomeIcons.bars,
                        color:  const Color(0xFF272D34),
                        size: 25,
                      ),
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                  ),
                ),

              ],
              pinned: true,
              shape: const RoundedRectangleBorder(
                  /*borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),*/
                  ),
              expandedHeight: MediaQuery.of(context).size.height * 0.35,
              flexibleSpace: FlexibleSpaceBar(
                // centerTitle: true,
                title: const Text('PICT SPORTS'),
                background: Container(
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  const heightFactor = 1.0;
                  final sport = myList[index];
                  final itemPositionOffset = index * itemSize * heightFactor;
                  final difference =
                      scrollController.offset - itemPositionOffset;
                  final percent =
                      1.0 - (difference / (itemSize * heightFactor));
                  double opacity = percent;
                  double scale = percent;
                  if (opacity > 1.0) opacity = 1.0;
                  if (opacity < 0.0) opacity = 0.0;
                  if (percent > 1.0) scale = 1.0;

                  return Align(
                    heightFactor: heightFactor,
                    child: Opacity(
                      opacity: opacity,
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()..scale(scale, 1.0),
                        child: SportsCard(
                          () {
                            if (sport.name == 'Table Tennis') {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return TabletannisScreen();
                              }));
                            } else if (sport.name == 'Basketball') {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const BasketBall_screen();
                              }));
                            } else if (sport.name=='Volleyball'){
                              print('ii');
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return const VolleyBall_Screen();
                              }));
                            }
                          },
                          index,
                          sport,
                        ),
                      ),
                    ),
                  );
                },
                childCount: myList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



 */


import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/physics.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    return Scaffold(
      body:
          Stack(
        children: [
          Container(
            height: 280,
            // color: Colors.red,
            width: MediaQuery.of(context).size.width,
            child: CustomPaint(
              painter: BackgroundPainter(
                animation: _controller.view,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 8.0,
              top: 20,
              right: MediaQuery.of(context).size.width * 0.9,
            ),
            child: Container(
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
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Positioned(
            right: 12,
            top: MediaQuery.of(context).size.height * 0.17,
            child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.width * 0.4,
                // color: Colors.red,
                child: MyCustomWidget()),
          ),
          Positioned(
            right: 12,
            top: MediaQuery.of(context).size.height * 0.35,
            child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.width * 0.4,
                // color: Colors.red,
                child: MyCustomWidget()),
          ),
          Positioned(
            right: 12,
            top: MediaQuery.of(context).size.height * 0.53,
            child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.width * 0.4,
                // color: Colors.red,
                child: MyCustomWidget()),
          ),
          Positioned(
            right: 12,
            top: MediaQuery.of(context).size.height * 0.70,
            child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.width * 0.4,
                // color: Colors.red,
                child: MyCustomWidget()),
          ),
          Positioned(
            left: 12,
            top: MediaQuery.of(context).size.height * 0.17,
            child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.width * 0.4,
                // color: Colors.red,
                child: MyCustomWidget()),
          ),
          Positioned(
            left: 12,
            top: MediaQuery.of(context).size.height * 0.35,
            child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.width * 0.4,
                // color: Colors.red,
                child: MyCustomWidget()),
          ),
          Positioned(
            left: 12,
            top: MediaQuery.of(context).size.height * 0.53,
            child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.width * 0.4,
                // color: Colors.red,
                child: MyCustomWidget()),
          ),
          Positioned(
            left: 12,
            top: MediaQuery.of(context).size.height * 0.70,
            child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.width * 0.4,
                // color: Colors.red,
                child: MyCustomWidget()),
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
  @override
  _MyCustomWidgetState createState() => _MyCustomWidgetState();
}

class _MyCustomWidgetState extends State<MyCustomWidget> {
  @override
  Widget build(BuildContext context) {
    return
        // Scaffold(
        // body:
        DraggableCard(
            child: GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const BasketBall_screen();
        }));
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastLinearToSlowEaseIn,
        height: 120,
        width: 120,
        decoration: BoxDecoration(
          image: const DecorationImage(
              image: AssetImage("assets/ball.png"), fit: BoxFit.fitWidth),
          // color: const Color(0xff8639FB),
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.4),
              blurRadius: 30,
            ),
          ],
        ),
        child: const Center(
          child: Text(
            '',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 25,
            ),
          ),
        ),
      ),
      // ),
      // ),
    ));
  }
}

class DraggableCard extends StatefulWidget {
  final Widget child;

  DraggableCard({required this.child});

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
