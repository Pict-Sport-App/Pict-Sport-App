import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:psa/appdrawer/commans/collaps_navigation_bar.dart';
import 'package:psa/screens/announcements/single_announce_widget.dart';
import 'package:psa/widget/constants.dart';

class AnnouncementScreen extends StatelessWidget {
  const AnnouncementScreen({Key? key}) : super(key: key);

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
                color: Color(0xFF272D34),
                size: 25,
              ),
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 8.0, top: 17),
              child: FaIcon(
                FontAwesomeIcons.bullhorn,
                size: 25,
                color: Colors.black,
              ),
            ),
            //   ),
            // ),
          ],
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(kkbackgroundImage),
                fit: BoxFit.cover
            ),
          ),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Announcement')
                  .orderBy('dateTime', descending: true)
                  .snapshots(),
              builder: (ctx, AsyncSnapshot userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final usersnap = userSnapshot.data!.docs;
                return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: usersnap.length,
                    itemBuilder: (context, index) {
                      return SingleAnnouncement(
                        imageUrl: usersnap[index]['imageURL'],
                        title: usersnap[index]['title'],
                        date: usersnap[index]['dateTime'],
                        descrip: usersnap[index]['description'],
                        venue: usersnap[index]['venue'],
                        number1: usersnap[index]['number1'],
                        number2: usersnap[index]['number2'],
                        contactNo1: usersnap[index]['contact1'],
                        contactNo2: usersnap[index]['contact2'],
                        link: usersnap[index]['link'],
                      );
                    });
              }),
        ));
  }
}

