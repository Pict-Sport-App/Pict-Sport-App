import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:psa/screens/Home/table_tennis/requests.dart';
import 'package:psa/screens/announcements/announcement_screen.dart';
import 'package:psa/screens/calender/calendar.dart';
import 'package:psa/screens/drawer/users.dart';
import 'package:psa/services/authentication.dart';
import '../thems.dart';

class CollapsingListTile extends StatefulWidget {
  CollapsingListTile(
      {required this.title,
      required this.num,
      required this.animationController,
      required this.isSelected,
      required this.onTap});
  final String title;
  final int num;
  final AnimationController animationController;
  final bool isSelected;
  final Function onTap;
  @override
  _CollapsingListTileState createState() => _CollapsingListTileState();
}

class _CollapsingListTileState extends State<CollapsingListTile> {
  late Animation<double> _widthAnimation, sizedBoxAnimation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _widthAnimation =
        Tween<double>(begin: 250, end: 90).animate(widget.animationController);
    sizedBoxAnimation =
        Tween<double>(begin: 10, end: 0).animate(widget.animationController);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.num == 4
            ? Authentication().signOut(context) // logout
            : setState(() {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return widget.num == 1
                      ? const AllUsers()
                      : widget.num == 2
                          ? const Request()
                          : widget.num == 3
                              ? const Announcement_Screen() // notification
                              : widget.num == 4
                                  ? const CalendarScreen() // calender
                                  : const Request();
                }));
              });
      },
      child: Container(
        padding: EdgeInsets.only(left: 6, top: 5, bottom: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          color: widget.isSelected
              ? Colors.transparent.withOpacity(0.3)
              : Colors.transparent,
        ),
        width: _widthAnimation.value,
        margin: const EdgeInsets.symmetric(
          horizontal: 14.0,
          vertical: 8.0,
        ),
        child: Row(
          children: <Widget>[
            FaIcon(
              widget.num == 1
                  ? FontAwesomeIcons.users
                  : widget.num == 2
                      ? FontAwesomeIcons.hammer
                      : widget.num == 3
                          ? FontAwesomeIcons.bell
                          : widget.num == 4
                              ? FontAwesomeIcons.calendar
                              : widget.num == 5
                                  ? FontAwesomeIcons.arrowAltCircleRight
                                  : FontAwesomeIcons.bars,
              color: Colors.white70,
              size: 26,
            ),
            _widthAnimation.value >= 250
                ? const SizedBox(width: 19.0)
                : const SizedBox(width: 10.0),
            _widthAnimation.value >= 250
                ? Text(widget.title,
                    style: widget.isSelected
                        ? listTitleSelectedTextStyle
                        : listTitleDefaultTextStyle)
                : Container(),
          ],
        ),
      ),
    );
  }
}
