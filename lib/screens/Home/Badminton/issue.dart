import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:psa/models/user_details.dart';
import 'package:psa/screens/Home/table_tennis/table_tennis_issue_screen.dart';
import '../../intial_page.dart';

class BadmintonIssue extends StatefulWidget {
  const BadmintonIssue({Key? key}) : super(key: key);
  static const routeName = '/bd';

  @override
  _BadmintonIssueState createState() => _BadmintonIssueState();
}

class _BadmintonIssueState extends State<BadmintonIssue> {

  String? chossedRacket,chossedCock;
  final formatYMDHM = DateFormat("yyyy-MM-dd HH:mm");
  DateTime? eventDate = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  void _selectedRacket(String ball) => chossedRacket = ball;
  void _selectedCock(String b)=> chossedCock=b;

  Future _submit() async {
    var vracket = 0;
    if (chossedRacket != null) {
      vracket = int.parse(_productId[0].toString()) - int.parse(chossedRacket.toString());
    }
    var vcock = 0;
    if (chossedCock != null) {
      vcock = int.parse(_productId[1].toString()) - int.parse(chossedCock.toString());
    }

    if (chossedRacket==null && chossedCock==null){
      //showToast('Please enter the Number of rackets and shuttle cock you want to issue');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 2),
        content: Text(
          'Please enter the Number of rackets and shuttle cock you want to issue',
          style: TextStyle(
            color: Colors.red,
            fontSize: 15,
          ),
        ),
      ));
    }else if (vracket<0){
      //showToast('Oops!!! The number of rackets requested are not available');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 2),
        content: Text(
          'Oops!!! The number of rackets requested are not available',
          style: TextStyle(
            color: Colors.red,
            fontSize: 15,
          ),
        ),
      ));
    }else if (vcock<0){
      //showToast('Oops!!! The number of Cock requested are not available');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 2),
        content: Text(
          'Oops!!! The number of Cock requested are not available',
          style: TextStyle(
            color: Colors.red,
            fontSize: 15,
          ),
        ),
      ));
    }
    else if (chossedRacket==null){
      chossedRacket='0';
      await FirebaseFirestore.instance
          .collection('BTEquipment')
          .doc(UserDetails.uid)
          .set({
        'noOfRacket': chossedRacket,
        'noOfCock':chossedCock,
        'timeOfIssue': Timestamp.now(),
        'timeOfReturn': Timestamp.now(),
        'isRequested': 1,
        'isReturn': false,
        'name': UserDetails.name,
        'misId': UserDetails.misId,
        'url': UserDetails.photourl,
        'uid': UserDetails.uid,
      });
      //showToast('Request have been send');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 1),
          content: Text(
            'Request have been send',
            style: TextStyle(
              color: Colors.green,
              fontSize: 15,
            ),
          )));
      Navigator.pushNamedAndRemoveUntil(
          context, IntialScreen.routeName,
              (route) => false);

    }else if (chossedCock==null){
      chossedCock='0';
      await FirebaseFirestore.instance
          .collection('BTEquipment')
          .doc(UserDetails.uid)
          .set({
        'noOfRacket': chossedRacket,
        'noOfCock':chossedCock,
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
          duration: Duration(seconds: 1),
          content: Text(
            'Request have been send',
            style: TextStyle(
              color: Colors.green,
              fontSize: 15,
            ),
          )));
      Navigator.pushNamedAndRemoveUntil(
          context, IntialScreen.routeName,
              (route) => false);

    }
  }
  bool _isInit = true;
  dynamic _productId;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_isInit) {
      _productId = ModalRoute.of(context)!.settings.arguments as List;
    }
    _isInit = false;
  }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/badminton.jpg'),
              fit: BoxFit.fitHeight,
              opacity: 20,
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              padding:
              const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
              child: Container(
                // width: width * 0.8,
                height: height * 0.5,
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
                      height: height * 0.5,
                      // width: width * 0.9,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            offset: Offset(
                              0,
                              0,
                            ),
                            blurRadius: 10.0,
                            spreadRadius: 3.0,
                          ), //BoxShadow
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 0.0,
                            spreadRadius: 0.0,
                          ), //BoxShadow
                        ],
                        image: DecorationImage(
                            image: AssetImage('assets/badminton.jpg'),
                            fit: BoxFit.fitHeight),
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
                                'Number of \nRacket',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              DropDown(
                                  itemList: const ['1', '2','3','4','5'],
                                  item1: 'Racket',
                                  submitFn: _selectedRacket),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.08,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text(
                                'Number of \nShuttle Cock',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              DropDown(
                                  itemList: const ['1', '2','3','4','5'],
                                  item1: 'Shuttle Cock',
                                  submitFn: _selectedRacket),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
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
                                    decoration: const InputDecoration(
                                      icon: FaIcon(
                                        FontAwesomeIcons.calendarCheck,
                                        color: Colors.redAccent,
                                        size: 35,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 2),
                                      ),
                                    ),
                                    format: formatYMDHM,
                                    onShowPicker:
                                        (context, currentValue) async {
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
                                        return DateTimeField.combine(
                                            date, time);
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
