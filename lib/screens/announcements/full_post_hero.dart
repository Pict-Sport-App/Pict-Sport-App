import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FullPost extends StatefulWidget {
  const FullPost({Key? key}) : super(key: key);

  @override
  _FullPostState createState() => _FullPostState();
}

class _FullPostState extends State<FullPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 222,
                width: double.infinity,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      child: Image.network(
                        'https://cvshealth.com/sites/default/files/cvs-health-vaccine-information-1-16x9.jpg',
                        width: double.infinity,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 40,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            color: Colors.lightBlue,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(23.0),
                              topRight: Radius.circular(23.0),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 14.0, top: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const Text(
                                " 🏐 TABLE TENNIS",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: IconButton(
                                  icon: const FaIcon(
                                    FontAwesomeIcons.share,
                                    size: 30,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                        ),
                        // ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Text(
                      "Update : ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(
                        " This is to inform all P.I.C.T. students that the Volleyball trials for Boys and Girls "
                        "  \nStudents should come in Sports Tracks/Shorts and Sports Shoes only."
                        " \nNote :- No one will be allowed to give the trials without sport shoes"
                        "  \nFor more details interested students should contact the undersigned people.",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    Text(
                      "Link : ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child:
                      Text(
                        "https://www.youtube.com/",
                        style: TextStyle(
                          color: Colors.pink,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    Text(
                      "Contact : ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(
                        "Ankit Kale:"
                        "9890193219"
                        "\nGauging :  9623608306"
                        "\nPreeti :8668455295",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    Text(
                      "Venue : ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(
                        "will be conducted by the P.I.C.T. Volleyball Ground on 22nd February, Tuesday at  5:30 PM sharp.",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
