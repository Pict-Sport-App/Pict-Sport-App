import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:psa/appdrawer/commans/collaps_navigation_bar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
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
        title: const Text(
          'Calender Screen',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
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

    );
  }
}
