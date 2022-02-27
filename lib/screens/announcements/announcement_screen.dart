import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:psa/appdrawer/commans/collaps_navigation_bar.dart';
import 'package:psa/screens/announcements/create_annoucement.dart';
import 'package:psa/screens/announcements/single_announce_widget.dart';

class Announcement_Screen extends StatefulWidget {
  const Announcement_Screen({Key? key}) : super(key: key);

  @override
  _Announcement_ScreenState createState() => _Announcement_ScreenState();
}

class _Announcement_ScreenState extends State<Announcement_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const Drawer(
          child: CollapsingNavigationDrawer(),
        ),
        appBar: AppBar(
          elevation: 0.3,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: AnimatedTextKit(
            animatedTexts: [
              TyperAnimatedText('Announcement',
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                  )),
            ],
          ),
          leading: Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 17),
            child: GestureDetector(
              child: const FaIcon(
                FontAwesomeIcons.bars,
                color: const Color(0xFF272D34),
                size: 25,
              ),
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: const <Widget>[
              SingleAnnouncement(),
              SingleAnnouncement(),
              // SingleAnnouncement(),
              // SingleAnnouncement(),
              // SingleAnnouncement(),
              // SingleAnnouncement(),
              // SingleAnnouncement(),
              // SingleAnnouncement(),
            ],
          ),
        ));
  }
}
