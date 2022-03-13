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

class SixNo extends StatefulWidget {
  const SixNo({Key? key}) : super(key: key);
  static const routeName = '/bb';

  @override
  _SixNoState createState() => _SixNoState();
}

class _SixNoState extends State<SixNo> {
  final formatYMDHM = DateFormat("yyyy-MM-dd HH:mm");
  DateTime? eventDate = DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  String? choosedBall;
  String? choisedSize;
  void _selectedBall(String ball) => choosedBall = ball;
  void _selectedSize(String size) => choisedSize = size;

  Future _submit() async {
    if (choosedBall == null && choisedSize == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 2),
        content: Text(
          'Please enter the Ball Numbers and Ball Size you want to issue',
          style: TextStyle(
            color: Colors.red,
            fontSize: 15,
          ),
        ),
      ));
    } else if (choisedSize == null && choosedBall != null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 2),
        content: Text(
          'Please enter the Ball Size you want to issue',
          style: TextStyle(
            color: Colors.red,
            fontSize: 15,
          ),
        ),
      ));
    } else if (choosedBall == null && choisedSize != null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 2),
        content: Text(
          'Please enter the Ball Number you want to issue',
          style: TextStyle(
            color: Colors.red,
            fontSize: 15,
          ),
        ),
      ));
    } else if (choisedSize == '6') {
      int f =
          int.parse(_leftSix.toString()) - int.parse(choosedBall.toString());
      if (f < 0) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 2),
          content: Text(
            'Oops!! All Balls of size Six are occupied',
            style: TextStyle(
              color: Colors.red,
              fontSize: 15,
            ),
          ),
        ));
      } else {
        await FirebaseFirestore.instance
            .collection('BBEquipment')
            .doc(UserDetails.uid)
            .set({
          'size': choisedSize,
          'timeOfIssue': Timestamp.now(),
          'timeOfReturn': Timestamp.now(),
          'isRequested': 1,
          'isReturn': false,
          'noOfBall': choosedBall,
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
            context, IntialScreen.routeName, (route) => false);
      }
    } else if (choisedSize == '7') {
      int f =
          int.parse(_leftSeven.toString()) - int.parse(choosedBall.toString());

      if (f < 0) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 2),
          content: Text(
            'Oops!! All Balls of size Seven are occupied',
            style: TextStyle(
              color: Colors.red,
              fontSize: 15,
            ),
          ),
        ));
      } else {
        await FirebaseFirestore.instance
            .collection('BBEquipment')
            .doc(UserDetails.uid)
            .set({
          'size': choisedSize,
          'timeOfIssue': Timestamp.now(),
          'timeOfReturn': Timestamp.now(),
          'isRequested': 1,
          'isReturn': false,
          'noOfBall': choosedBall,
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
            context, IntialScreen.routeName, (route) => false);
      }
    } else {
      await FirebaseFirestore.instance
          .collection('BBEquipment')
          .doc(UserDetails.uid)
          .set({
        'size': choisedSize,
        'timeOfIssue': Timestamp.now(),
        'timeOfReturn': Timestamp.now(),
        'isRequested': 1,
        'isReturn': false,
        'noOfBall': choosedBall,
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
          context, IntialScreen.routeName, (route) => false);
    }
  }

  bool _isInit = true;
  dynamic _productId, _leftSix, _leftSeven;
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
      _productId = ModalRoute.of(context)!.settings.arguments as List<String>;
      setState(() {
        _leftSix = _productId[0];
        _leftSeven = _productId[1];
      });
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    double hei = MediaQuery.of(context).size.height;
    double wei = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/bn.jpg'),
          fit: BoxFit.fitHeight,
          opacity: 20,
        )),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 18.0),
              child: Pop(),
            ),
            Container(
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
                    height: hei * 0.5,
                    width: wei * 0.9,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      image: DecorationImage(
                          image: AssetImage('assets/bn.jpg'), fit: BoxFit.fitHeight),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Ball Size',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              DropDown(
                                  itemList: const ['6', '7'],
                                  item1: 'Size',
                                  submitFn: _selectedSize),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Number of Balls',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                              DropDown(
                                  itemList: const ['1', '2'],
                                  item1: 'Ball',
                                  submitFn: _selectedBall),
                            ],
                          ),
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
                                padding: EdgeInsets.all(0.0),
                                child: Text(
                                  '\nTime Of Issuement',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Center(
                                child: DateTimeField(
                                  resetIcon: const Icon(
                                    Icons.close,
                                    color: Colors.redAccent,
                                  ),
                                  initialValue: DateTime.now(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  enabled: true,
                                  enableInteractiveSelection: true,
                                  decoration: const InputDecoration(
                                    icon: FaIcon(
                                      FontAwesomeIcons.calendarDay,
                                      color: Colors.redAccent,
                                      size: 35,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(
                                          color: Colors.redAccent, width: 2),
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
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
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
            )
          ],
        ),
      ),
    );
  }
}
