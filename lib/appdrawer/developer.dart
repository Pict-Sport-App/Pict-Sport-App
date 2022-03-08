import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mailto/mailto.dart';
import 'package:psa/appdrawer/privatepage.dart';
import 'package:psa/models/user_details.dart';
import 'package:psa/widget/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class Frame1Widget extends StatelessWidget {
  const Frame1Widget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
          body: Container(
              width: width,
              height: height,
              decoration: const BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    image: AssetImage(kkbackgroundImage),
                    fit: BoxFit.cover
                ),
              ),
              child: Column(children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      SizedBox(
                        width: width * 0.07,
                      ),
                      IconButton(
                          onPressed: () => {Navigator.pop(context)},
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 30,
                          )),
                      SizedBox(
                        width: width * 0.15,
                      ),
                      const Text(
                        'Developers',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  height: height * 0.12,
                  width: width,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(0),
                        topRight: Radius.circular(0),
                        bottomLeft: Radius.circular(55),
                        bottomRight: Radius.circular(55),
                      ),
                      color: Colors.indigo[400]),
                ),
                const Expanded(
                  child: Page(),
                )
              ])),
        ));
  }
}

class Page extends StatefulWidget {
  const Page({Key? key}) : super(key: key);

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  PageController _pageController = PageController();
  double view = 0.8;
  double offset1 = 0;

  void _listener() {
    setState(() {
      offset1 = _pageController.page!;
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: view);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _pageController.addListener(_listener);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        itemCount: devList.length,
        controller: _pageController,
        itemBuilder: (context, index) {
          double scale = max(view, 1 - (offset1 - index).abs() + view);
          double angle = (offset1 - index).abs();
          double height = MediaQuery.of(context).size.height;
          double width = MediaQuery.of(context).size.width;
          if (angle > 0.5) {
            angle = 1 - angle;
          }

          return Container(
            padding: EdgeInsets.only(
                right: width * 0.04,
                left: width * 0.04,
                bottom: height * 0.18,
                top: (height * 0.158) - scale * 25),
            child: Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(angle),
              alignment: Alignment.center,
              child: Material(
                elevation: 22,
                borderRadius: BorderRadius.circular(25),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                      color: Colors.deepPurple[200]),
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 35,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.orangeAccent,
                          radius: 75,
                          backgroundImage: AssetImage(devList[index].img),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          devList[index].name,
                          style: const TextStyle(fontSize: 22),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            IconButton(
                                onPressed: () =>
                                    {launchMailto(devList[index].gmailurl)},
                                icon: const Icon(Icons.email)),
                            IconButton(
                                onPressed: () =>
                                    {_launchURL(devList[index].githuburl)},
                                icon: const Icon(FontAwesomeIcons.github)),
                            IconButton(
                                onPressed: () =>
                                    {_launchURL(devList[index].instaurl)},
                                icon: const Icon(FontAwesomeIcons.instagram)),
                            IconButton(
                                onPressed: () =>
                                    {_launchURL(devList[index].linkedinurl)},
                                icon: const Icon(FontAwesomeIcons.linkedin)),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        UserDetails.isDeveloper==true?
                        RaisedButton(onPressed: (){
                          Navigator.push(context,
                          MaterialPageRoute(builder: (context){
                            return const PrivatePage();
                          }));
                        },
                        child: const Text(
                          'Manage App Admin'
                        ),):Container(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}

_launchURL(String url) async {
  try {
    await launch(url);
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}

launchMailto(String email) async {
  final mailtoLink = Mailto(
    to: [email],
    cc: ['devpictsports@gmail.com'],
    subject: 'App Review',
    body: "Just saw the Sports App.\nMy reviews are\n ",
  );
  await launch('$mailtoLink');
}

class Devs {
  String name;
  String img;
  String instaurl;
  String githuburl;
  String linkedinurl;
  String gmailurl;
  Devs(this.name, this.img, this.instaurl, this.githuburl, this.gmailurl,
      this.linkedinurl);
}

final devList = [
  Devs(
      'Harshwardhan Atkare',
      'assets/Harshw.jpeg',
      'https://www.instagram.com/atkareharsh/ ',
      'https://github.com/Harshwardhan431 ',
      'atkareharsh@gmail.com',
      'https://www.linkedin.com/in/harshwardhan-atkare-49a9961bb/'),
  Devs(
      'Dhiraj Darakhe',
      'assets/Dhiraj.jpeg',
      'https://www.instagram.com/dhiraj_darakhe/',
      'https://github.com/dhirajdarakhe',
      'dhirajdarakhe03@gmail.com',
      'https://www.linkedin.com/in/dhiraj-darakhe-751201215'),
  Devs(
      'Atharva Bhadange',
      'assets/Atharv.jpeg',
      'https://www.instagram.com/bhadange_atharv/',
      'https://github.com/atharv-bhadange',
      'bhadange.atharv@gmail.com',
      'https://www.linkedin.com/in/atharv-bhadange-9817521ba/'),
  Devs(
      'Omkar Awaje',
      'assets/omkar.png',
      'https://www.instagram.com/_omkaarrr_/',
      'https://github.com/OmkarAwaje',
      'omkar.awaje1012002@gmail.com',
      'https://www.linkedin.com/in/omkar-awaje-8239341b3'),
];
