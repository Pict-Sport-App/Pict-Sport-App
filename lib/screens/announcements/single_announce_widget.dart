import 'package:flutter/material.dart';
import 'package:psa/screens/announcements/full_post_hero.dart';

class SingleAnnouncement extends StatefulWidget {
  const SingleAnnouncement({Key? key}) : super(key: key);

  @override
  _SingleAnnouncementState createState() => _SingleAnnouncementState();
}

class _SingleAnnouncementState extends State<SingleAnnouncement> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
            color: Colors.white38,
            borderRadius: const BorderRadius.all(
                Radius.circular(5.0) //                 <--- border radius here
                ),
            border: Border.all(color: Colors.blueAccent)),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: const <Widget>[
                  CircleAvatar(
                    radius: 12,
                    backgroundImage: NetworkImage(
                        'https://cvshealth.com/sites/default/files/cvs-health-vaccine-information-1-16x9.jpg'),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "BasketBall",
                    style: TextStyle(color: Colors.black, fontSize: 19),
                  ),
                  Text(",  Pict Pune")
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Stack(children: [
              Image.network(
                  'https://cvshealth.com/sites/default/files/cvs-health-vaccine-information-1-16x9.jpg'),
              const Positioned(
                  right: 12,
                  top: 15,
                  child: Icon(
                    Icons.download_for_offline,
                    size: 30,
                  )),
              // const Positioned(
              //     bottom: 39,
              //     right: 12,
              //     child: Icon(
              //       Icons.share,
              //       size: 30,
              //     )),
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => FullPost()));
                    },
                    child: const Text(
                      "See Post",
                      style: TextStyle(color: Colors.lightBlue),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 0.0, top: 0, right: 15),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: DescriptionTextWidget(
                        text: "🏐🏐🏐🏐🏐🏐🏐🏐🏐\n"
                            "  This is to inform all P.I.C.T. students that the Volleyball trials for  Boys and Girls will be conducted by the P.I.C.T. Volleyball Ground on 22nd February, Tuesday at  5:30 PM sharp."
                            "  \nStudents should come in Sports Tracks/Shorts and Sports Shoes only."),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DescriptionTextWidget extends StatefulWidget {
  final String text;

  DescriptionTextWidget({required this.text});

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
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  // textBaseline: TextBaseline.alphabetic,
                  children: <Widget>[
                    // Text(flag ? (firstHalf + "...") : (firstHalf + secondHalf)),
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
