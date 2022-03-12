import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:psa/appdrawer/officialSport/bbOfficial.dart';
import 'package:psa/screens/Home/Basketball/size_no.dart';
import 'package:psa/screens/Home/Cricket/issueEquiment.dart';
import 'package:psa/screens/Home/Football/issueEuiment.dart';
import 'package:psa/screens/Home/VolleyBall/issue_ball.dart';
import 'package:psa/screens/Home/table_tennis/table_tennis_issue_screen.dart';
import 'package:psa/screens/chats/sport_chat_screen.dart';
import 'package:psa/screens/chats/chat_members.dart';
import 'package:psa/screens/intial_page.dart';
import 'package:psa/screens/login_signUp/signUp_screen.dart';
import 'package:psa/services/get_user_data.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

Future isLoggedIn() async {
  FirebaseAuth.instance.currentUser!;
}

class MyApp extends StatelessWidget {
  User? user = FirebaseAuth.instance.currentUser;

  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (user != null) {
      return MaterialApp(
        title: 'Pict Sports App',
        debugShowCheckedModeBanner: false,
        home: GetUserData(),
        routes: {
          SportChatScreen.routeName: (ctx) => const SportChatScreen(),
          ChatMembers.routeName: (ctx) => const ChatMembers(),
          SixNo.routeName: (ctx) => const SixNo(),
          IssueTheRacket.routeName: (ctx) => const IssueTheRacket(),
          Issue.routeName: (ctx) => const Issue(),
          IntialScreen.routeName: (ctx)=>const IntialScreen(),
          CricketIssue.routeName: (ctx)=>const CricketIssue(),
          FootBallIssue.routeName: (ctx)=>const FootBallIssue(),
          Official.routeName: (ctx)=>const Official(),
        },
      );
    } else {
      return MaterialApp(
        title: 'Pict Sports App',

        debugShowCheckedModeBanner: false,
        home: const Signup(),
        routes: {
          SportChatScreen.routeName: (ctx) => const SportChatScreen(),
          ChatMembers.routeName: (ctx) => const ChatMembers(),
          SixNo.routeName: (ctx) => const SixNo(),
          IssueTheRacket.routeName: (ctx) => const IssueTheRacket(),
          Issue.routeName: (ctx) => const Issue(),
          IntialScreen.routeName: (ctx)=>const IntialScreen(),
          CricketIssue.routeName: (ctx)=>const CricketIssue(),
          FootBallIssue.routeName: (ctx)=>const FootBallIssue(),
          Official.routeName: (ctx)=>const Official(),
        },
      );
    }
  }
}
