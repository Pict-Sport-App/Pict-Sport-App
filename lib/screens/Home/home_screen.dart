import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:psa/screens/Home/Cricket/cricket_screen.dart';
import 'package:psa/screens/Home/Football/football_screen.dart';
import 'package:psa/screens/Home/VolleyBall/Volleyball.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      //backgroundColor: Colors.blueAccent,
      body: Stack(
        children: [
          Image.asset('assets/back.jpg',height: height,
          width: width,fit: BoxFit.cover,),
          Transform.rotate(
            angle: 0.82,
            child: Image.asset('assets/back.jpg',height: height,
              width: width,fit: BoxFit.cover,),
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
                                MaterialPageRoute(builder: (context){
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
                                  return const FootBallScreen();
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
                              onTap: () {

                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                      return const FootBallScreen();
                                    }));
                              },
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
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const CricketScreen();
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
                              onTap: () {
                                print("Football");
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                      return const FootBallScreen();
                                    }));
                              },
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
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const CricketScreen();
                                }));
                              },
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

class MyCustomWidget extends StatelessWidget {
  final String image;
  final String text;
  final VoidCallback onTap;
  const MyCustomWidget(
      {Key? key, required this.onTap, required this.image, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            GestureDetector(
              onTap: onTap,
              child: Container(
                height: height * 0.1,
                width: width * 0.22,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12, width: 3),
                  image:
                      DecorationImage(image: AssetImage(image), fit: BoxFit.fill),
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
            ),
            Center(
              child: Text(
                text,
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
