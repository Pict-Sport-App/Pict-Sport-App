import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:psa/models/user_details.dart';
import 'package:psa/screens/Home/VolleyBall/requested.dart';
import 'package:psa/screens/Home/table_tennis/pop_up_widget.dart';

import '../../intial_page.dart';

class RequestedFootball extends StatelessWidget {
  const RequestedFootball({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const FaIcon(
            FontAwesomeIcons.arrowCircleLeft,
            color: Colors.white,
            size: 30,
          ),
        ),
        centerTitle: true,
        title: const Text('Requests'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('FFEquipment').snapshots(),
        builder: (ctx, equimentSnapshot) {
          if (equimentSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final reqMembers = equimentSnapshot.data!.docs;
          return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: reqMembers.length,
              itemBuilder: (ctx, index) => reqMembers[index]['isRequested'] == 1
                  ? FFRequest(
                      isReturn: reqMembers[index]['isReturn'],
                      image: reqMembers[index]['url'],
                      uid: reqMembers[index]['uid'],
                      timeOfReturn: reqMembers[index]['timeOfReturn'],
                      timeOfIssue: reqMembers[index]['timeOfIssue'],
                      noOfBall: reqMembers[index]['noOfBall'].toString(),
                      name: reqMembers[index]['name'],
                      isAdmin: UserDetails.isAdmin ?? false,
                      misId: reqMembers[index]['misId'],
                    )
                  : Center(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          SizedBox(
                              height: 200,
                              width: 200,
                              child: Lottie.asset('assets/nofound.json')),
                        ],
                      ),
                    ));
        },
      ),
    ));
  }
}

class FFRequest extends StatefulWidget {
  final String name, noOfBall;
  final Timestamp timeOfIssue, timeOfReturn;
  final bool isAdmin;
  final String uid, image;
  final bool isReturn;
  final String misId;

  const FFRequest({
    Key? key,
    required this.misId,
    required this.isReturn,
    required this.image,
    required this.uid,
    required this.timeOfReturn,
    required this.timeOfIssue,
    required this.noOfBall,
    required this.name,
    required this.isAdmin,
  }) : super(key: key);

  @override
  _FFRequestState createState() => _FFRequestState();
}

class _FFRequestState extends State<FFRequest> {
  dynamic hour,
      minute,
      gb = 'pm',
      rHour,
      rMinute,
      rGb = 'pm',
      day,
      month,
      year,
      day1,
      month1,
      year1;
  void cal() {
    month = widget.timeOfIssue.toDate().month;
    year = widget.timeOfIssue.toDate().year;
    day = widget.timeOfIssue.toDate().day;

    month1 = widget.timeOfReturn.toDate().month;
    year1 = widget.timeOfReturn.toDate().year;
    day1 == widget.timeOfReturn.toDate().day;

    hour = widget.timeOfIssue.toDate().hour;
    minute = widget.timeOfIssue.toDate().minute;
    rHour = widget.timeOfReturn.toDate().hour;
    rMinute = widget.timeOfReturn.toDate().minute;
    if (hour >= 0 && hour <= 11) {
      gb = 'am';
    }
    if (rHour >= 0 && rHour <= 11) {
      rGb = 'am';
    }
    if (hour > 12 && hour <= 23) {
      hour = hour - 12;
    } else if (hour == 0) {
      hour = 12;
    }
    if (rHour > 12 && rHour <= 23) {
      rHour = rHour - 12;
    } else if (rHour == 0) {
      rHour = 12;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    cal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 18,
        right: 15,
        top: 12,
      ),
      child: Stack(
        children: [
          Padding(
            // top: 2,
            padding: const EdgeInsets.only(top: 11, left: 5),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white54,
                border: Border.all(
                  color: Colors.lightBlue,
                  width: 3,
                ), //Border.all
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  // boxShadow: [
                  BoxShadow(
                    color: Colors.white54,
                    blurRadius: 5.0,
                    offset: Offset(4.0, 2.0),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 98.0, top: 12, bottom: 17),
                    child: Text(
                      widget.name,
                      style: const TextStyle(fontSize: 19),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0, bottom: 15),
                    child: Row(
                      children: <Widget>[
                        const FaIcon(
                          FontAwesomeIcons.envelope,
                          size: 26,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 18.0),
                          child: Text(
                            "MisId:",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Container(
                            height: 25,
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Text(
                                    widget.misId.toString(),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0, bottom: 15),
                    child: Row(
                      children: <Widget>[
                        const FaIcon(
                          FontAwesomeIcons.volleyballBall,
                          size: 26,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 18.0),
                          child: Text(
                            "Total Balls      :",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Text(
                            widget.noOfBall.toString(),
                            style: const TextStyle(fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0, bottom: 15),
                    child: Row(
                      children: <Widget>[
                        const FaIcon(
                          FontAwesomeIcons.hourglassStart,
                          size: 26,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 18.0),
                          child: Text(
                            "Issuing Time:",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Container(
                            height: 25,
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Text(
                                    minute < 10
                                        ? '$hour:0$minute $gb, $day/$month/$year'
                                        : '$hour:$minute $gb, $day/$month/$year',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  if (widget.isReturn)
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, bottom: 15),
                      child: Row(
                        children: <Widget>[
                          const FaIcon(
                            FontAwesomeIcons.hourglassEnd,
                            size: 26,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 18.0),
                            child: Text(
                              "Returning Time:",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Container(
                              height: 25,
                              width: MediaQuery.of(context).size.width * 0.28,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    Text(
                                      rMinute < 10
                                          ? '$rHour:0$rMinute $rGb, $day1/$month1/$year1'
                                          : '$rHour:$rMinute $rGb, $day1/$month1/$year1',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  if (widget.isAdmin)
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0, bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          RaisedButton(
                            onPressed: () {
                              // Submit(context);
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return PopUpRequest(
                                      onTap: () async {
                                        await FirebaseFirestore.instance
                                            .collection('FFEquipment')
                                            .doc(widget.uid)
                                            .update({
                                          'isRequested': 2,
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                          'Request accepted ',
                                        )));
                                        widget.uid == UserDetails.uid
                                            ? Navigator.pushNamedAndRemoveUntil(
                                                context,
                                                IntialScreen.routeName,
                                                (route) => false)
                                            : Navigator.pop(context);
                                      },
                                      text: 'accept the Request',
                                    ); //---------
                                  });
                            },
                            color: const Color(0xffc3f7ab),
                            splashColor: Colors.lightBlueAccent,
                            elevation: 10.0,
                            shape: const StadiumBorder(),
                            child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Text('Accept')),
                          ),
                          RaisedButton(
                            onPressed: () {
                              // Submit(context);
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return PopUpRequest(
                                      onTap: () async {
                                        await FirebaseFirestore.instance
                                            .collection('FFEquipment')
                                            .doc(widget.uid)
                                            .update({
                                          'isRequested': 5,
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                          'Request rejected',
                                        )));
                                        widget.uid == UserDetails.uid
                                            ? Navigator.pushNamedAndRemoveUntil(
                                                context,
                                                IntialScreen.routeName,
                                                (route) => false)
                                            : Navigator.pop(context);
                                      },
                                      text: 'Reject the Request?',
                                    ); //---------
                                  });
                            },
                            color: const Color(0xfff76463),
                            splashColor: Colors.lightBlueAccent,
                            elevation: 10.0,
                            shape: const StadiumBorder(),
                            child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Text('Reject')),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              margin: const EdgeInsets.only(top: 16.0),
            ),
          ),
          // widget.isViewing?Container():widget.isAdmin?onClick():Container(),
          Positioned(
            top: 1,
            child: CircleAvatar(
              radius: 38,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 34,
                backgroundColor: Colors.blue,
                child: CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(widget.image),
                  ),
                ),
              ),
            ),
          ),
          // widget.isViewing?Container():widget.isAdmin?onClick():Container(),
        ],
      ),
    );
  }
}
