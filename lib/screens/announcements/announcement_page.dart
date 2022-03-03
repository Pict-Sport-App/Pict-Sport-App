import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:psa/screens/announcements/poster.dart';
import 'package:url_launcher/url_launcher.dart';

class AnnouncementPage extends StatefulWidget {
  late Timestamp date; //
  late String imageUrl; //
  late String descrip; //
  late String link; //
  late String number1; //
  late String number2; //
  late String contactNo1; //
  late String contactNo2; //
  late String title; //
  late String venue; //
  AnnouncementPage(
      {Key? key,
      required this.descrip,
      required this.imageUrl,
      required this.venue,
      required this.title,
      required this.date,
      required this.link,
      required this.number1,
      required this.number2,
      required this.contactNo1,
      required this.contactNo2})
      : super(key: key);

  @override
  _AnnouncementPageState createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
  dynamic day, month, year, hour, min, gb = 'pm', w;

  Future<void> _launchedInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url,
          forceSafariVC: false,
          forceWebView: false,
          headers: <String, String>{'header_key': 'header_value'});
    } else {
      throw 'Could not launch $url';
    }
  }

  void cal() {
    day = widget.date.toDate().day;
    month = widget.date.toDate().month;
    year = widget.date.toDate().year;
    hour = widget.date.toDate().hour;
    min = widget.date.toDate().minute;
    if (hour >= 0 && hour <= 11) {
      gb = 'am';
    }
    if (hour > 12 && hour <= 23) {
      hour = hour - 12;
    } else if (hour == 0) {
      hour = 12;
    }

    if (month == 1) {
      w = 'January';
    } else if (month == 2) {
      w = 'February';
    } else if (month == 3) {
      w = 'March';
    } else if (month == 4) {
      w = 'April';
    } else if (month == 5) {
      w = 'May';
    } else if (month == 6) {
      w = 'June';
    } else if (month == 7) {
      w = 'July';
    } else if (month == 8) {
      w = 'August';
    } else if (month == 9) {
      w = 'September';
    } else if (month == 10) {
      w = 'October';
    } else if (month == 11) {
      w = 'November';
    } else if (month == 12) {
      w = 'December';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Photo(
                                image: widget.imageUrl,
                              )))
                },
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: double.infinity,
                  child: Image(
                    image: NetworkImage(widget.imageUrl),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.all(7.0),
                padding: const EdgeInsets.all(3.0),
                child: Text(
                  widget.title,
                  style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(3.0),
                color: Colors.grey[100],
                child: Container(
                    color: Colors.white,
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(3.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: const <Widget>[
                            SizedBox(
                              width: 10,
                            ),
                            FaIcon(
                              FontAwesomeIcons.file,
                              color: Colors.black,
                              size: 25,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Description',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 46,
                          ),
                          child: Text(
                            widget.descrip,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.grey),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: <Widget>[
                            const SizedBox(
                              width: 10,
                            ),
                            const FaIcon(
                              FontAwesomeIcons.calendarDay,
                              color: Colors.black,
                              size: 25,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              '$day th $w $year',
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 46),
                          child: Text(
                            '$hour.$min $gb',
                            style: const TextStyle(
                                fontSize: 18, color: Colors.grey),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: <Widget>[
                            const SizedBox(
                              width: 10,
                            ),
                            const FaIcon(
                              FontAwesomeIcons.locationArrow,
                              color: Colors.black,
                              size: 25,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            widget.venue == ''
                                ? Container()
                                : const Text(
                                    'Venue ',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )
                          ],
                        ),
                        widget.venue == ''
                            ? Container()
                            : Padding(
                                padding:
                                    const EdgeInsets.only(left: 46, bottom: 20),
                                child: Text(
                                  widget.venue,
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.grey),
                                ),
                              ),
                        Row(
                          children: const <Widget>[
                            SizedBox(
                              width: 10,
                            ),
                            FaIcon(
                              FontAwesomeIcons.phoneAlt,
                              color: Colors.black,
                              size: 25,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Contact',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        widget.contactNo1 == ''
                            ? Container()
                            : Padding(
                                padding:
                                    const EdgeInsets.only(left: 46, bottom: 2),
                                child: Text(
                                  '${widget.contactNo1} :: ${widget.number1}',
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.grey),
                                ),
                              ),
                        widget.contactNo2 == ''
                            ? Container()
                            : Padding(
                                padding:
                                    const EdgeInsets.only(left: 46, bottom: 20),
                                child: Text(
                                  '${widget.contactNo2} :: ${widget.number2}',
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.grey),
                                ),
                              ),
                        Center(
                            child: Material(
                          color: Colors.purple[400],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10.0)),
                          child: TextButton(
                            onPressed: () => {
                              if (widget.link == '')
                                {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          duration: Duration(seconds: 1),
                                          content: Text(
                                              'Link of registration not available'))),
                                }
                              else
                                {
                                  _launchedInBrowser(widget.link),
                                }
                            },
                            child: const Text(
                              'Register',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
