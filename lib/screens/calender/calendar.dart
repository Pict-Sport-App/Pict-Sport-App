import 'dart:ui';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:psa/appdrawer/commans/collaps_navigation_bar.dart';
import 'package:psa/screens/announcements/single_announce_widget.dart';
import 'package:psa/widget/constants.dart';
import 'package:table_calendar/table_calendar.dart';

DateTime selectedDay = DateTime.now();
DateTime focusedDay = DateTime.now();

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat format = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
            TyperAnimatedText('Calender Screen',
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
        actions: [
          IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.solidCalendarAlt,
              size: 35,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(kkbackgroundImage),
              fit: BoxFit.fill,
            ),
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topRight,
              colors: [
                Color(0xFFFFB300),
                Color(0xFFFFA000),
                Color(0xFFFF8F00),
              ],
            )),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 10, bottom: 2),
                child: Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      blurRadius: 24,
                      spreadRadius: 16,
                      color: const Color(0XFF4527A0).withOpacity(0.2),
                    )
                  ]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaY: 16,
                        sigmaX: 16,
                      ),
                      child: Container(
                        height: height * 0.52,
                        width: width,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              width: 1.5,
                              color: Colors.white.withOpacity(0.2),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 0, right: 10, left: 10, bottom: 0),
                          child: TableCalendar(
                            pageAnimationEnabled: true,
                            availableCalendarFormats: const {
                              CalendarFormat.month: 'Month',
                              CalendarFormat.week: 'Week',
                            },
                            focusedDay: focusedDay,
                            firstDay: DateTime(1999),
                            lastDay: DateTime(2050),
                            calendarFormat: format,
                            onFormatChanged: (CalendarFormat _format) {
                              setState(() {
                                format = _format;
                              });
                            },
                            startingDayOfWeek: StartingDayOfWeek.sunday,
                            daysOfWeekVisible: true,
                            onDayLongPressed:
                                (DateTime selectedDay, DateTime focusDay) {},
                            onDaySelected:
                                (DateTime selectDay, DateTime focusDay) {
                              setState(() {
                                selectedDay = selectDay;
                                focusedDay = focusDay;
                              });
                            },
                            selectedDayPredicate: (DateTime date) {
                              return isSameDay(selectedDay, date);
                            },
                            calendarStyle: CalendarStyle(
                              isTodayHighlighted: true,
                              selectedDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color(0xFF82B1FF),
                              ),
                              selectedTextStyle: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                              todayDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color(0xFFBBDEFB),
                              ),
                              todayTextStyle: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF004D40),
                              ),
                              defaultDecoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              defaultTextStyle: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                                color: Colors.black,
                              ),
                              weekendDecoration: BoxDecoration(
                                color: const Color(0xFF6A1B9A),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              weekendTextStyle: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            headerStyle: HeaderStyle(
                              leftChevronIcon: const FaIcon(
                                FontAwesomeIcons.chevronLeft,
                                color: Colors.white,
                                size: 20,
                              ),
                              rightChevronIcon: const FaIcon(
                                FontAwesomeIcons.chevronRight,
                                color: Colors.white,
                                size: 20,
                              ),
                              headerMargin: const EdgeInsets.only(bottom: 20),
                              decoration: BoxDecoration(
                                color: const Color(0xFFAB47BC).withOpacity(0.0),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              titleTextStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                              formatButtonVisible: true,
                              titleCentered: true,
                              formatButtonShowsNext: false,
                              formatButtonDecoration: BoxDecoration(
                                color: const Color(0xFFBBDEFB),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              formatButtonTextStyle: const TextStyle(
                                color: Color(0xFF1A237E),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 2),
                child: Divider(
                  color: Colors.white,
                ),
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Announcement')
                    .orderBy('dateTime', descending: true)
                    .snapshots(),
                builder: (ctx, AsyncSnapshot calendereventSnapshots) {
                  if (calendereventSnapshots.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final _calenderevents = calendereventSnapshots.data.docs;
                  return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _calenderevents.length,
                      itemBuilder: (ctx, index) {
                        return Container(
                          child: (isSameDay(selectedDay,
                                  _calenderevents[index]['dateTime'].toDate()))
                              ? SingleAnnouncement(
                                  contactNo2: _calenderevents[index]
                                      ['contact2'],
                                  contactNo1: _calenderevents[index]
                                      ['contact1'],
                                  number2: _calenderevents[index]['number2'],
                                  number1: _calenderevents[index]['number1'],
                                  link: _calenderevents[index]['link'],
                                  imageUrl: _calenderevents[index]['imageURL'],
                                  title: _calenderevents[index]['title'],
                                  date: _calenderevents[index]['dateTime'],
                                  descrip: _calenderevents[index]
                                      ['description'],
                                  venue: _calenderevents[index]['venue'])
                              :null,

                        );
                      });
                },
              )
            ],
          ),

        ),
      ),
    );
  }
}
