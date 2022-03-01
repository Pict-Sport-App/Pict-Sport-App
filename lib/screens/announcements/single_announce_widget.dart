import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Padding(
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
                    style: const TextStyle(color: Colors.black, fontSize: 19),
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
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>photo(image: widget.imageUrl,)));
                },
                child: Container(
                  width: width,
                  height: 200,
                  decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(widget.imageUrl),
                    fit: BoxFit.fill
                  )
                ),),
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
                          style: TextStyle(fontSize: 17,color: Colors.white),
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
    );
  }
}

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
      firstHalf = widget.text.substring(0, 125);
      secondHalf = widget.text.substring(125, widget.text.length);
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
                        flag ? "show more" : "show less",
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
