import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:psa/appdrawer/commans/collaps_navigation_bar.dart';
import 'package:psa/models/user_details.dart';
import 'package:psa/screens/chats/sport_chat_screen.dart';
import 'package:psa/screens/profile/profile_edit_srcreen.dart';
import 'package:psa/widget/constants.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List? mergedList = [];
  List? mergedListEmoji = [];

  void merge() {
    mergedList?.clear();
    mergedListEmoji?.clear();
    int i = 0;

    for (i = 0; i < UserDetails.myOfficialSportsList!.length; i++) {
      mergedList?.add(UserDetails.myOfficialSportsList![i]);
    }
    for (i = 0; i < (UserDetails.mySportsList!.length); i++) {
      mergedList?.add(UserDetails.mySportsList![i]);
    }

    int j = 0;

    for (j = 0; j < UserDetails.myOfficialSportEmoji!.length; j++) {
      mergedListEmoji?.add(UserDetails.myOfficialSportEmoji![j]);
    }
    for (j = 0; j < (UserDetails.mySportEmoji!.length); j++) {
      mergedListEmoji?.add(UserDetails.mySportEmoji![j]);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    merge();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(
        child: CollapsingNavigationDrawer(),
      ),
      appBar: AppBar(
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
        toolbarHeight: 65,
        automaticallyImplyLeading: false, // Used for removing back buttoon.
        elevation: 0.3,
        backgroundColor: Colors.white,
        title: AnimatedTextKit(
          animatedTexts: [
            TyperAnimatedText('Messaging',
                textStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                )),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.rocketchat,
              size: 30,
              color: Colors.black,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(kkbackgroundImage), fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 10,
              child: ListView.builder(
                  itemCount: mergedList!.length,
                  itemBuilder: (ctx, index) => SportGrpNameWidget(
                        lastMsg: '   ',
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            SportChatScreen.routeName,
                            arguments: mergedList![index],
                          );
                        },
                        name: mergedList![index],
                        image: mergedListEmoji![index],
                      )),
            ),
            Expanded(
                child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const EditProfileScreen();
                }));
              },
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20))),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Click here to be part of Official Sports'
                      ' Group ',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}

class SportGrpNameWidget extends StatelessWidget {
  final String name, image, lastMsg;
  final VoidCallback onTap;
  const SportGrpNameWidget(
      {Key? key,
      required this.lastMsg,
      required this.onTap,
      required this.name,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      image,
                      style: const TextStyle(fontSize: 25),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(),
                child: Text(
                  lastMsg,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color(0xFFF5F5F5),
          ),
        ),
      ),
    );
  }
}
