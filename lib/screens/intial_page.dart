import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:psa/appdrawer/commans/collaps_navigation_bar.dart';
import 'package:psa/models/user_details.dart';
import 'package:psa/screens/Home/home_screen.dart';
import 'package:psa/screens/announcements/announcement_screen.dart';
import 'package:psa/screens/chats/chat_screen.dart';
import 'package:psa/screens/profile/profile_screen.dart';
import 'calender/calendar.dart';

class IntialScreen extends StatefulWidget {
  const IntialScreen({Key? key}) : super(key: key);
  static const routeName = '/initial_screen';

  @override
  _IntialScreenState createState() => _IntialScreenState();
}

class _IntialScreenState extends State<IntialScreen> {
  int selectedIndex = 0;

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  void pageChanged(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget buildpageconnector() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: const <Widget>[
        // Profile_Screen(),
        HomeScreen(),
        ChatScreen(),
        AnnouncementScreen(),
        CalendarScreen(),
        ProfileScreen(),
      ],
    );
  }

  ShapeBorder? bottomBarShape = const RoundedRectangleBorder(
      /*borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20), topRight: Radius.circular(20)),*/
      );
  SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.floating;
  EdgeInsets padding = const EdgeInsets.all(0);

  SnakeShape snakeShape = SnakeShape.indicator;

  bool showSelectedLabels = true;
  bool showUnselectedLabels = false;

  Color selectedColor = Colors.white;
  Color unselectedColor = Colors.red;

  Color defaultBackgrdColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: defaultBackgrdColor,

      drawer: const CollapsingNavigationDrawer(),
      bottomNavigationBar: SnakeNavigationBar.color(
        behaviour: snakeBarStyle,
        snakeShape: snakeShape,
        shape: bottomBarShape,
        padding: padding,
        // backgroundColor: const Color(0xFF9C27B0),
        backgroundColor: Colors.white,

        ///configuration for SnakeNavigationBar.color
        snakeViewColor: selectedColor,
        // selectedItemColor: const Color(0xFF6A1B9A),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,

        showUnselectedLabels: showUnselectedLabels,
        showSelectedLabels: showSelectedLabels,

        currentIndex: selectedIndex,
        onTap: (index) => setState(() {
          selectedIndex = index;
          pageController.animateToPage(index,
              duration: const Duration(milliseconds: 500), curve: Curves.ease);
        }),

        items: [
          const BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.home,
                size: 25,
                color: Colors.black,
              ),
              label: 'Home'),
          const BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.facebookMessenger,
                size: 25,
                color: Colors.black,
              ),
              label: 'Chat'),
          const BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.bell,
                size: 25,
                color: Colors.black,
              ),
              label: 'Notifi...'),
          const BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.calendar,
                size: 25,
                color: Colors.black,
              ),
              label: 'Calendar'),
          BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 1),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    UserDetails.photourl.toString(),
                  ),
                  radius: 11,
                ),
              ),
              label: 'Profile')
        ],
      ),
      body: Builder(
        builder: (context) => SafeArea(
          child: Stack(
            children: [
              Container(
                height: deviceHeight,
                width: deviceWidth,
                color: defaultBackgrdColor,
                child: buildpageconnector(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
