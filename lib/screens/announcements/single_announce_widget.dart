import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:psa/screens/announcements/announcement_page.dart';
import 'package:psa/screens/announcements/poster.dart';

class SingleAnnouncement extends StatefulWidget {
  late Timestamp date;
  late String imageUrl;
  late String descrip;
  late String link;
  late String number1;
  late String number2;
  late String contactNo1;
  late String contactNo2;
  late String title;
  late String venue;

  SingleAnnouncement(
      {required this.contactNo2,
      required this.contactNo1,
      required this.number2,
      required this.number1,
      required this.link,
      required this.imageUrl,
      required this.title,
      required this.date,
      required this.descrip,
      required this.venue});

  @override
  _SingleAnnouncementState createState() => _SingleAnnouncementState();
}

class _SingleAnnouncementState extends State<SingleAnnouncement> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 12,
      ),
      child: Container(
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
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 50.0, right: 14, left: 14),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 0.0),
                        child: GestureDetector(
                          onTap: () {
                            print("Show full post ");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => announcement_page(
                                          descrip: widget.descrip,
                                          imageUrl: widget.imageUrl,
                                          venue: widget.venue,
                                          title: widget.title,
                                          date: widget.date,
                                          link: widget.link,
                                          number1: widget.number1,
                                          number2: widget.number2,
                                          contactNo1: widget.contactNo1,
                                          contactNo2: widget.contactNo2,
                                        )));
                          },
                          child: Container(
                            // width: MediaQuery.,
                            height: MediaQuery.of(context).size.height * 0.28,
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(
                                      0,
                                      0,
                                    ),
                                    blurRadius: 10.0,
                                    spreadRadius: 1.0,
                                  ), //BoxShadow
                                  BoxShadow(
                                    color: Colors.white,
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 0.0,
                                    spreadRadius: 0.0,
                                  ), //BoxShadow
                                ],
                                image: DecorationImage(
                                    image: NetworkImage(widget.imageUrl),
                                    fit: BoxFit.fill)),
                          ),
                        ),
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            DescriptionTextWidget(
                              text: widget.descrip,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                margin: const EdgeInsets.only(top: 15.0),
              ),
            ),
            Positioned(
              top: 1,
              child: GestureDetector(
                onTap: () {
                  print("opent he sport Dp");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => photo(
                                image: widget.imageUrl,
                              )));
                },
                child: CircleAvatar(
                  radius: 34,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.blue,
                    child: CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                          radius: 24,
                          backgroundImage: NetworkImage(widget.imageUrl)),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 5,
              top: 30,
              child: IconButton(
                onPressed: () {
                  print("Share the post");
                },
                icon: const FaIcon(
                  FontAwesomeIcons.paperPlane,
                  color: Colors.black,
                  size: 25,
                ),
              ),
            ),
            /*  Positioned(
                right: 25,
                top: 290,
                child: GestureDetector(
                  onTap: () {
                    print("Show full post ");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => announcement_page(
                                  descrip: widget.descrip,
                                  imageUrl: widget.imageUrl,
                                  venue: widget.venue,
                                  title: widget.title,
                                  date: widget.date,
                                  link: widget.link,
                                  number1: widget.number1,
                                  number2: widget.number2,
                                  contactNo1: widget.contactNo1,
                                  contactNo2: widget.contactNo2,
                                )));
                  },
                  child: const Text(
                    "View Post",
                    style: TextStyle(color: Colors.lightBlue, fontSize: 14),
                  ),
                )),*/
            Positioned(
              top: 14,
              left: 80,
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    /* Column(
      children: [
        const SingleAnnounceMent(),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: const Color(0xFFE0E0E0),
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                border: Border.all(color: Colors.blueAccent)),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, top: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 12,
                        backgroundImage: NetworkImage(widget.imageUrl),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        widget.title,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 19),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Stack(children: [
                  //Image.network(widget.imageUrl),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => photo(
                                    image: widget.imageUrl,
                                  )));
                    },
                    child: Container(
                      width: width,
                      height: 200,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(widget.imageUrl),
                              fit: BoxFit.fill)),
                    ),
                  ),
                  const Positioned(
                      right: 12,
                      top: 15,
                      child: Icon(
                        Icons.download_for_offline,
                        size: 30,
                      )),
                  const Positioned(
                      bottom: 6,
                      right: 12,
                      child: Icon(
                        Icons.share,
                        size: 30,
                      )),
                ]),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 15, top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Icon(
                        Icons.thumb_up_alt,
                        size: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => announcement_page(
                                        descrip: widget.descrip,
                                        imageUrl: widget.imageUrl,
                                        venue: widget.venue,
                                        title: widget.title,
                                        date: widget.date,
                                        link: widget.link,
                                        number1: widget.number1,
                                        number2: widget.number2,
                                        contactNo1: widget.contactNo1,
                                        contactNo2: widget.contactNo2,
                                      )));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFA726),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "See Post",
                              style:
                                  TextStyle(fontSize: 17, color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                /*Container(
                  padding: const EdgeInsets.only(left: 0.0, top: 0, right: 15),
                  child: Column(
                    children: <Widget>[
                      DescriptionTextWidget(text: widget.descrip),
                    ],
                  ),
                ),*/
              ],
            ),
          ),
        ),
      ],
    );*/
  }
}

/*
class SingleAnnounceMent extends StatefulWidget {
  const SingleAnnounceMent({Key? key}) : super(key: key);

  @override
  _SingleAnnounceMentState createState() => _SingleAnnounceMentState();
}
class _SingleAnnounceMentState extends State<SingleAnnounceMent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 12,
      ),
      child: Container(
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
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 50.0, right: 14, left: 14),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 18.0),
                        child: GestureDetector(
                          onTap: () {
                            print("Show full post ");
                            /*   Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => announcement_page(
                                      descrip: widget.descrip,
                                      imageUrl: widget.imageUrl,
                                      venue: widget.venue,
                                      title: widget.title,
                                      date: widget.date,
                                      link: widget.link,
                                      number1: widget.number1,
                                      number2: widget.number2,
                                      contactNo1: widget.contactNo1,
                                      contactNo2: widget.contactNo2,
                                    ))); */
                          },
                          child: Container(
                            // width: MediaQuery.,
                            height: 250,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(
                                      0,
                                      0,
                                    ),
                                    blurRadius: 10.0,
                                    spreadRadius: 1.0,
                                  ), //BoxShadow
                                  BoxShadow(
                                    color: Colors.white,
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 0.0,
                                    spreadRadius: 0.0,
                                  ), //BoxShadow
                                ],
                                image: DecorationImage(
                                    image: NetworkImage(
                                        'https://firebasestorage.googleapis.com/v0/b/pict-sport.appspot.com/o/annoucements%2F1646044655560.jpg?alt=media&token=1ef52469-b4ae-4df2-aedb-40bbc32feb37'),
                                    fit: BoxFit.fill)),
                          ),
                        ),
                      ),
                      Container(
                        child: Column(
                          children: const <Widget>[
                            DescriptionTextWidget(
                              text:
                                  'https://firebasestorage.googleapis.com/v0/b/pict-sport.appspot.com/o/annoucements'
                                  '%2F1646044655560.jpg?alt=media&token=1ef52469-b4ae-4df2-aedb-40bbc32feb37',
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                margin: const EdgeInsets.only(top: 16.0),
              ),
            ),
            Positioned(
              top: 1,
              child: GestureDetector(
                onTap: () {
                  print("opent he sport Dp");
                  /*
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => photo(
                                    image: widget.imageUrl,
                                  )));
                   */
                },
                child: const CircleAvatar(
                  radius: 34,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.blue,
                    child: CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 24,
                        backgroundImage: NetworkImage(
                            'https://firebasestorage.googleapis.com/v0/b/pict-sport.appspot.com/o/annoucements%2F1646044655560.jpg?alt=media&token=1ef52469-b4ae-4df2-aedb-40bbc32feb37'),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 5,
              top: 30,
              child: IconButton(
                onPressed: () {
                  print("Share the post");
                },
                icon: const FaIcon(
                  FontAwesomeIcons.share,
                  color: Colors.black,
                  size: 25,
                ),
              ),
            ),
            Positioned(
                right: 25,
                top: 290,
                child: GestureDetector(
                  onTap: () {
                    print("Show full post ");
                    /*
                     Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => announcement_page(
                                        descrip: widget.descrip,
                                        imageUrl: widget.imageUrl,
                                        venue: widget.venue,
                                        title: widget.title,
                                        date: widget.date,
                                        link: widget.link,
                                        number1: widget.number1,
                                        number2: widget.number2,
                                        contactNo1: widget.contactNo1,
                                        contactNo2: widget.contactNo2,
                                      )));
                     */
                  },
                  child: const Text(
                    "View Post",
                    style: TextStyle(color: Colors.lightBlue, fontSize: 14),
                  ),
                )),
            Positioned(
              top: 16,
              left: 80,
              child: Container(
                color: Colors.white,
                child: const Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10),
                  child: Text(
                    "BASKETBALL",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
class DescriptionTextWidget extends StatefulWidget {
  final String text;

  const DescriptionTextWidget({required this.text});

  @override
  _DescriptionTextWidgetState createState() => _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 50) {
      firstHalf = widget.text.substring(0, 70);
      secondHalf = widget.text.substring(70, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: secondHalf.isEmpty
          ? Text(firstHalf)
          : Column(
              children: <Widget>[
                Text(flag ? (firstHalf + "...") : (firstHalf + secondHalf)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      "Posted on 21/feb/20121",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    GestureDetector(
                      child: Text(
                        flag ? "read more" : "show less",
                        style: const TextStyle(color: Colors.blue),
                      ),
                      onTap: () {
                        setState(() {
                          flag = !flag;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
