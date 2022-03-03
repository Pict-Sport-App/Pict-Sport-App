import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
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
      {Key? key,
      required this.contactNo2,
      required this.contactNo1,
      required this.number2,
      required this.number1,
      required this.link,
      required this.imageUrl,
      required this.title,
      required this.date,
      required this.descrip,
      required this.venue})
      : super(key: key);

  @override
  _SingleAnnouncementState createState() => _SingleAnnouncementState();
}

class _SingleAnnouncementState extends State<SingleAnnouncement> {
  Future share(dynamic link, String title, String msg) async {
    await FlutterShare.share(
        title: title,
        text: msg,
        linkUrl: link,
        chooserTitle: 'Where You want to share');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
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
              child: Padding(
                padding: const EdgeInsets.only(top: 50.0, right: 14, left: 14),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 0.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AnnouncementPage(
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
                    Column(
                      children: <Widget>[
                        DescriptionTextWidget(
                          text: widget.descrip,
                        ),
                      ],
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Photo(
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
              onPressed: () async {
                /* print("Share the post");
                final url=Uri.parse(widget.imageUrl);
                final response=await http.get(url);
                final bytes=response.bodyBytes;
                final temp=await getTemporaryDirectory();
                final path='${temp.path}/image.jpg';
                File(path).writeAsBytes(bytes);*/

                // await Share.share(widget.descrip);
                //share(context, 1);
                share(widget.link, widget.title, widget.descrip);
              },
              icon: const FaIcon(
                FontAwesomeIcons.paperPlane,
                color: Colors.black,
                size: 25,
              ),
            ),
          ),
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
    );
  }
}

class DescriptionTextWidget extends StatefulWidget {
  final String text;

  const DescriptionTextWidget({Key? key, required this.text}) : super(key: key);

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
