import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:psa/models/user_details.dart';
import 'package:psa/screens/Home/table_tennis/table_tennis_issue_screen.dart';
import 'package:psa/widget/commonSportText.dart';
import '../../intial_page.dart';

class FootBallIssue extends StatefulWidget {
  const FootBallIssue({Key? key}) : super(key: key);
  static const routeName = '/ff';

  @override
  _FootBallIssueState createState() => _FootBallIssueState();
}

class _FootBallIssueState extends State<FootBallIssue> {

  final formatYMDHM = DateFormat("yyyy-MM-dd HH:mm");
  DateTime? eventDate = DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  String? chossedBall;
  void _selectedBall(String ball)=>chossedBall=ball;

  Future _submit()async{
    var v = 0;
    if (chossedBall != null) {
      v = int.parse(_productId.toString()) - int.parse(chossedBall.toString());
    }

    if (chossedBall==null){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 1),content: Text(
        'Please enter the number of ball',style: TextStyle(
        color: Colors.green,
        fontSize: 15,
      ),
      )));
    }else if (v<0){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 2),
        content: Text(
          'Oops!!! The number of balls requested are not available',
          style: TextStyle(
            color: Colors.red,
            fontSize: 15,
          ),
        ),
      ));
    } else{
      print('eee');
      FirebaseFirestore.instance
          .collection('FFEquipment')
          .doc(UserDetails.uid).set({
        'noOfBall': chossedBall,
        'timeOfIssue': Timestamp.now(),
        'timeOfReturn': Timestamp.now(),
        'isRequested': 1,
        'isReturn': false,
        'name': UserDetails.name,
        'misId': UserDetails.misId,
        'url': UserDetails.photourl,
        'uid': UserDetails.uid,
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 1),content: Text(
        'Request have been send',style: TextStyle(
        color: Colors.green,
        fontSize: 15,
      ),
      )));
      Navigator.pushNamedAndRemoveUntil(context,
          IntialScreen.routeName
          , (route) => false);
    }
  }

  bool _isInit=true;
  dynamic _productId;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_isInit) {
      _productId = ModalRoute.of(context)!.settings.arguments as int;
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/football.jpg'),
              fit: BoxFit.fitHeight,
              opacity: 20,
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 30,top: 20,bottom: 20),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const FaIcon(
                  FontAwesomeIcons.arrowCircleLeft,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 35.0,left: 15),
              child: Container(
                width: width * 0.89,
                height: height * 0.48,
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
                      // height: height * 10.5,
                      // width: width * 0.9,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        image: DecorationImage(
                            image: AssetImage('assets/football.jpg'), fit: BoxFit.fitHeight),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text(
                                'Number of \nBalls',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              DropDown(
                                  itemList: const ['1', '2','3','4','5'],
                                  item1: 'Ball',
                                  submitFn: _selectedBall),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(top: 15.0),
                                  child: Text(
                                    'Time Of Issuement',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: DateTimeField(
                                    resetIcon: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                    ),
                                    initialValue: DateTime.now(),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    enabled: true,
                                    enableInteractiveSelection: true,
                                    decoration:  const InputDecoration(
                                      icon: FaIcon(
                                        FontAwesomeIcons.calendar,
                                        color: Colors.white,
                                        size: 35,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 2),
                                      ),
                                    ),
                                    format: formatYMDHM,
                                    onShowPicker: (context, currentValue) async {
                                      final date = await showDatePicker(
                                        context: context,
                                        firstDate: DateTime.now(),
                                        initialDate:
                                        currentValue ?? DateTime.now(),
                                        lastDate: DateTime(2100),
                                      );
                                      if (date != null) {
                                        final time = await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.fromDateTime(
                                            currentValue ?? DateTime.now(),
                                          ),
                                        );
                                        eventDate =
                                            DateTimeField.combine(date, time);
                                        return DateTimeField.combine(date, time);
                                      } else {
                                        eventDate = currentValue;
                                        return currentValue;
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  _submit();
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(20)),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
