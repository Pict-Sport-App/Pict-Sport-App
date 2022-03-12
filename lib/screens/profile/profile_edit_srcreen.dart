import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:psa/models/user_details.dart';
import 'package:psa/services/get_user_data.dart';
import 'package:psa/widget/constants.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  static String hiddenHeadLine = "Ex: BasketBall Player";
  static String hiddenRollNo = "00000";
  static String hiddenLocation = "Ex:Aurangabad,Maharashtra";
  static String hiddenAchivement = "Ex: State Level BasketBall Player";
  static String hiddenAboutMe = "Minimum 10 words required";
  static String hiddenInsta = "";

  dynamic _day, _month, _year;

  Future _onSubmit() async {
    try {
      if (formkey.currentState!.validate()) {
        formkey.currentState!.save();
        if (headline == hiddenHeadLine) {
          headline = null;
        }
        if (rollNo == hiddenRollNo) {
          rollNo = null;
        }
        if (location == hiddenLocation) {
          location = null;
        }
        if (achivement == hiddenAchivement) {
          achivement = null;
        }
        if (aboutUrSelf == hiddenAboutMe) {
          aboutUrSelf = null;
        }
        if (insta == hiddenInsta) {
          insta = null;
        }
        if (twit == hiddenInsta) {
          twit = null;
        }
        if (link == hiddenInsta) {
          link = null;
        }
        if (mobile == hiddenInsta) {
          mobile = null;
        }

        Map<String, int?>? m = {
          'Official BasketBall': bb, //🏀 BB
          'Official VolleyBall': vv, //🏐 VB
          'Official TableTennis': tt, //🎾 TT
          'Official Badminton': bd, //🏸  BT
          'Official Cricket': cr, //🏏  CR
          'Official FootBall': fb, //⚽ FB
          'Official Chess': ch, //♟️ CH
          'Official Gym': gy, //💪 GY
        };

        FirebaseFirestore.instance
            .collection('User')
            .doc(UserDetails.uid)
            .update({
          'headLine': headline,
          'rollNo': rollNo,
          'location': location,
          'achievement': achivement,
          'aboutMe': aboutUrSelf,
          'insta': insta,
          'linkedIn': link,
          'twitter': twit,
          'whatAppNo': mobile,
          'dob': UserDetails.birthday,
          'Official SportList': m,
        });

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return GetUserData();
        }));
      } else {
        if (kDebugMode) {
          print("null is being printed <=");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  int? bb = 0,
      vv = 0,
      tt = 0,
      bd = 0,
      cr = 0,
      fb = 0,
      ch = 0,
      gy = 0;

  void c() {
    bb=UserDetails.officialsportMap!['Official BasketBall'];
    vv=UserDetails.officialsportMap!['Official VolleyBall'];
    tt=UserDetails.officialsportMap!['Official TableTennis'];
    bd=UserDetails.officialsportMap!['Official Badminton'];
    cr=UserDetails.officialsportMap!['Official Cricket'];
    fb=UserDetails.officialsportMap!['Official FootBall'];
    ch=UserDetails.officialsportMap!['Official Chess'];
    gy=UserDetails.officialsportMap!['Official Gym'];
  }

  Widget onClick(int b){
    return b==0?Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Make Request',style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 15
          ),),
        ),
      ),
    ):b==1?
    Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Requested',style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 15
          ),),
        ),
      ),
    ):b==2?
    Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Official Member',style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 15
          ),),
        ),
      ),
    ):Container();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    c();
  }

  final formkey = GlobalKey<FormState>();
  String? headline;
  String? rollNo;
  String? location;
  String? achivement;
  String? aboutUrSelf;
  String? insta, twit, link, mobile;
  DateTime datetime = DateTime.now();
  String? dob;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // to remove back button
        backgroundColor: Colors.white,
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
            /*Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
                  return Profile_Screen();
                }));*/
            // );
          },
          child: const Padding(
            padding: EdgeInsets.only(left: 5.0, top: 0),
            child: FaIcon(
              FontAwesomeIcons.timesCircle,
              color: Colors.black,
              size: 35,
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              _onSubmit();
            },
            child: const FaIcon(
              FontAwesomeIcons.check,
              color: Colors.blueAccent,
              size: 28,
            ),
          )
        ],
        title: const Center(
          child: Text(
            "EDIT PROFILE",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage(kkbackgroundImage),
              fit: BoxFit.cover
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: formkey,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    initialValue: UserDetails.headline == 'null' ||
                            UserDetails.headline == null
                        ? null
                        : UserDetails.headline,

                    obscureText: false,
                    decoration: InputDecoration(labelText: "Headline",
                    hintText: hiddenHeadLine),
                    onSaved: (input) {
                      headline = input;
                    },
                    validator: (input) => input==""?null:input!.length > 4 && input.isNotEmpty
                        ? null
                        : "Should be at least 4 char ",
                  ),
                  TextFormField(
                    initialValue:
                        UserDetails.rollNo == 'null' || UserDetails.rollNo == null
                            ? null
                            : UserDetails.rollNo,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: "Roll No",
                    hintText: hiddenRollNo),
                    onSaved: (input) {
                      rollNo = input;
                    },
                    validator: (input){
                      return input==""?null: input!.length==5 && input.isNotEmpty?
                          null:
                          "Should be 5 char";
                    },

                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Birthdate:  ",
                        style: TextStyle(
                          fontSize: 17,
                          // fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        UserDetails.birthday == null ||
                                UserDetails.birthday == 'null'
                            ? ''
                            : UserDetails.birthday.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      const Spacer(
                        flex: 2,
                      ),
                      GestureDetector(
                        onTap: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime(1995),
                                  firstDate: DateTime(1995),
                                  lastDate: DateTime.now())
                              .then((value) {
                            setState(() {
                              _day = value?.day;
                              _month = value?.month;
                              _year = value?.year;
                              dob = (_day.toString() +
                                  '/' +
                                  _month.toString() +
                                  '/' +
                                  _year.toString());
                              UserDetails.birthday = dob;
                            });
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(17),
                            color: Colors.blue,
                          ),
                          child: const Text(
                            "Change",
                            style: TextStyle(fontSize: 17, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    initialValue: UserDetails.location == 'null' ||
                            UserDetails.location == null
                        ? null
                        : UserDetails.location,
                    decoration: InputDecoration(labelText: "Location",
                    hintText: hiddenLocation),
                    onSaved: (input) {
                      location = input;
                    },
                    validator: (input) =>input==""?null: input!.isNotEmpty && input.length > 2
                        ? null
                        : "Should be at least 4 char ",
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        "\nSport Info :-",
                        style: TextStyle(fontSize: 17, color: Colors.black87),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: TextFormField(
                          initialValue: UserDetails.achivement == 'null' ||
                                  UserDetails.achivement == null
                              ? null
                              : UserDetails.achivement,
                          decoration:
                              InputDecoration(labelText: "Achivement",
                              hintText: hiddenAchivement),
                          onSaved: (input) {
                            achivement = input;
                          },
                          validator: (input) =>input==""?null:
                              input!.length > 10 && input.isNotEmpty
                                  ? null
                                  : "Should be at least 10 char ",
                        ),
                      ),
                    ],
                  ),
                  TextFormField(
                    initialValue: UserDetails.aboutMe == 'null' ||
                            UserDetails.aboutMe == null
                        ? null
                        : UserDetails.aboutMe,
                    maxLines: 2,
                    keyboardType: TextInputType.multiline,
                    decoration:
                        InputDecoration(labelText: "About Your self",
                        hintText: hiddenAboutMe),
                    onSaved: (input) {
                      aboutUrSelf = input;
                    },
                    validator: (input) =>input==""?null:
                    input!.length > 10 && input.isNotEmpty
                        ? null
                        : "Should be at least 10 char ",
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        "\nContact Url :-",
                        style: TextStyle(fontSize: 17, color: Colors.black87),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          const FaIcon(
                            FontAwesomeIcons.instagram,
                            color: Colors.black,
                            size: 37,
                          ),
                          const Text(
                            "   Instagram  ",
                            style: TextStyle(fontSize: 17, color: Colors.black87),
                          ),
                          Expanded(
                            child: TextFormField(
                              initialValue: UserDetails.instaUrl == 'null'
                                  ? null
                                  : UserDetails.instaUrl,
                              decoration: const InputDecoration(
                                hintText: 'Enter url',
                              ),
                              onSaved: (input) {
                                insta = input;
                              },
                              validator: (input) => input!.startsWith(
                                      // "https://www.instagram.com/in/") || input.isEmpty
                                      "https://www.instagram.com/") || input.isEmpty
                                  ? null
                                  : "Enter valid URL",
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          const FaIcon(
                            FontAwesomeIcons.twitter,
                            color: Colors.black,
                            size: 37,
                          ),
                          const Text(
                            "   Twitter  ",
                            style: TextStyle(fontSize: 17, color: Colors.black87),
                          ),
                          Expanded(
                            child: TextFormField(
                              initialValue: UserDetails.twitterUrl == 'null'
                                  ? null
                                  : UserDetails.twitterUrl,
                              decoration: const InputDecoration(
                                hintText: 'Enter url',
                              ),
                              onSaved: (input) {
                                twit = input;
                              },
                              validator: (input) {
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          const FaIcon(
                            FontAwesomeIcons.linkedin,
                            color: Colors.black,
                            size: 37,
                          ),
                          const Text(
                            "  Linkedin   ",
                            style: TextStyle(fontSize: 17, color: Colors.black87),
                          ),
                          Expanded(
                            child: TextFormField(
                              initialValue: UserDetails.linkedInUrl == 'null'
                                  ? null
                                  : UserDetails.linkedInUrl,
                              decoration: const InputDecoration(
                                hintText: 'Enter url',
                              ),
                              onSaved: (input) {
                                link = input;
                              },
                              validator: (input) => input!.startsWith(
                                          "https://www.linkedin.com/in/") ||
                                      input.isEmpty
                                  ? null
                                  : "Enter valid URL",
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          const FaIcon(
                            FontAwesomeIcons.phoneAlt,
                            color: Colors.black,
                            size: 37,
                          ),
                          const Text(
                            " WhatsApp's No ",
                            style: TextStyle(fontSize: 17, color: Colors.black87),
                          ),
                          Expanded(
                            child: TextFormField(
                              initialValue: UserDetails.whatAppNo == 'null'
                                  ? null
                                  : UserDetails.whatAppNo,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: 'Enter url',
                              ),
                              onFieldSubmitted: (_) {
                                _onSubmit();
                              },
                              onSaved: (input) {
                                mobile = input;
                              },
                              validator: (input) =>
                                  input!.length == 10 || input.isEmpty
                                      ? null
                                      : "Enter valid mobile number",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Center(
                    child: Text(
                      'Make Request If You are a part of\n '
                          'any Official Group Sports',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  bb!=-1? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'BasketBall',
                        style: TextStyle(
                          color: Color(0xFFAFB42B),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            if (bb==0){
                              bb=1;
                            }
                          });
                        },
                          child: onClick(bb!)),
                    ],
                  ):Container(),
                  vv!=-1? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'VolleyBall',
                        style: TextStyle(
                          color: Color(0xFFAFB42B),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                          onTap: (){
                            setState(() {
                              if (vv==0){
                                vv=1;
                              }
                            });
                          },
                          child: onClick(vv!)),
                    ],
                  ):Container(),
                  tt!=-1? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'TableTennis',
                        style: TextStyle(
                          color: Color(0xFFAFB42B),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                          onTap: (){
                            setState(() {
                              if (tt==0){
                                tt=1;
                              }
                            });
                          },
                          child: onClick(tt!)),
                    ],
                  ):Container(),
                  bd!=-1? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Badminton',
                        style: TextStyle(
                          color: Color(0xFFAFB42B),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                          onTap: (){
                            setState(() {
                              if (bd==0){
                                bd=1;
                              }
                            });
                          },
                          child: onClick(bd!)),
                    ],
                  ):Container(),
                  cr!=-1? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Cricket',
                        style: TextStyle(
                          color: Color(0xFFAFB42B),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                          onTap: (){
                            setState(() {
                              if (cr==0){
                                cr=1;
                              }
                            });
                          },
                          child: onClick(cr!)),
                    ],
                  ):Container(),
                  fb!=-1? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'FootBall',
                        style: TextStyle(
                          color: Color(0xFFAFB42B),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                          onTap: (){
                            setState(() {
                              if (fb==0){
                                fb=1;
                              }
                            });
                          },
                          child: onClick(fb!)),
                    ],
                  ):Container(),
                  ch!=-1? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Chess',
                        style: TextStyle(
                          color: Color(0xFFAFB42B),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              GestureDetector(
                  onTap: (){
                    setState(() {
                      if (ch==0){
                        ch=1;
                      }
                    });
                  },
                  child: onClick(bb!)),
                    ],
                  ):Container(),
                  gy!=-1? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Gym',
                        style: TextStyle(
                          color: Color(0xFFAFB42B),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                          onTap: (){
                            setState(() {
                              if (ch==0){
                                ch=1;
                              }
                            });
                          },
                          child: onClick(ch!)),
                    ],
                  ):Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
