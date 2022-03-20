import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:psa/models/user_details.dart';
import 'package:psa/screens/intial_page.dart';

class IssueTheRacket extends StatefulWidget {
  const IssueTheRacket({Key? key}) : super(key: key);
  static const routeName = '/tt';

  @override
  State<IssueTheRacket> createState() => _IssueTheRacketState();
}

class _IssueTheRacketState extends State<IssueTheRacket> {
  final _name = UserDetails.name;
  String? choosedTable;
  String? choosedRacket;

  void _selectedTable(String table) => choosedTable = table;
  void _selectedRacket(String racket) => choosedRacket = racket;

  DateTime? eventDate = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  final formatYMDHM = DateFormat("yyyy-MM-dd HH:mm");

  Future submit(BuildContext context) async {
    if (choosedTable == null && choosedRacket == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 2),
        content: Text(
          'Please enter the Table Number and Number of Racket you want to issue',
          style: TextStyle(
            color: Colors.red,
            fontSize: 15,
          ),
        ),
      ));
    } else if (choosedTable == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 2),
        content: Text(
          'Please enter the Table Number',
          style: TextStyle(
            color: Colors.red,
            fontSize: 15,
          ),
        ),
      ));
    } else if (choosedRacket == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 2),
        content: Text(
          'Please enter the Number of Racket you want to issue',
          style: TextStyle(
            color: Colors.red,
            fontSize: 15,
          ),
        ),
      ));
    } else if (choosedTable == 'Table 1') {
      if ((int.parse(_t1.toString()) - int.parse(choosedRacket.toString())) <
          0) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 2),
          content: Text(
            'Oops!! All Rackets are occupied at table 1 .Try another table',
            style: TextStyle(
              color: Colors.red,
              fontSize: 15,
            ),
          ),
        ));
      } else {
        FirebaseFirestore.instance
            .collection('TTEquipment')
            //.doc('TT').collection('Equipment')
            .doc(UserDetails.uid)
            .set({
          'tableNumber': choosedTable,
          'racketNumber': choosedRacket,
          'timeOfIsuue': eventDate,
          'name': UserDetails.name,
          'misId': UserDetails.misId,
          'photourl': UserDetails.photourl,
          'isRequested': 1,
          'isReturn': false,
          'timeOfReturn': Timestamp.now(),
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
    } else if (choosedTable == 'Table 2') {
      var b = int.parse(_t2.toString()) - int.parse(choosedRacket.toString());
      if (b < 0) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 2),
          content: Text(
            'Oops!! All Rackets are occupied at table 2 .Try another table',
            style: TextStyle(
              color: Colors.red,
              fontSize: 15,
            ),
          ),
        ));
      } else {
        FirebaseFirestore.instance
            .collection('TTEquipment')
            //.doc('TT').collection('Equipment')
            .doc(UserDetails.uid)
            .set({
          'tableNumber': choosedTable,
          'racketNumber': choosedRacket,
          'timeOfIsuue': eventDate,
          'name': UserDetails.name,
          'misId': UserDetails.misId,
          'photourl': UserDetails.photourl,
          'isRequested': 1,
          'isReturn': false,
          'timeOfReturn': Timestamp.now(),
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
        // Navigator.of(context).pushReplacementNamed(IntialScreen.routeName);
      }
    } else if (choosedTable == 'Table 3') {
      int h = int.parse(_t3.toString()) - int.parse(choosedRacket.toString());
      if (h < 0) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 2),
          content: Text(
            'Oops!! All Rackets are occupied at table 3 .Try another table',
            style: TextStyle(
              color: Colors.red,
              fontSize: 15,
            ),
          ),
        ));
      } else {
        FirebaseFirestore.instance
            .collection('TTEquipment')
            //.doc('TT').collection('Equipment')
            .doc(UserDetails.uid)
            .set({
          'tableNumber': choosedTable,
          'racketNumber': choosedRacket,
          'timeOfIsuue': eventDate,
          'name': UserDetails.name,
          'misId': UserDetails.misId,
          'photourl': UserDetails.photourl,
          'isRequested': 1,
          'isReturn': false,
          'timeOfReturn': Timestamp.now(),
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
        //Navigator.of(context).pushReplacementNamed(IntialScreen.routeName);
      }
    } else {
      FirebaseFirestore.instance
          .collection('TTEquipment')
          //.doc('TT').collection('Equipment')
          .doc(UserDetails.uid)
          .set({
        'tableNumber': choosedTable,
        'racketNumber': choosedRacket,
        'timeOfIsuue': eventDate,
        'name': UserDetails.name,
        'misId': UserDetails.misId,
        'photourl': UserDetails.photourl,
        'isRequested': 1,
        'isReturn': false,
        'timeOfReturn': Timestamp.now(),
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
      //Navigator.of(context).pushReplacementNamed(IntialScreen.routeName);
    }
    return;
  }

  bool _isInit = true;
  dynamic _productId;
  dynamic _t1, _t2, _t3, _tremain;
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
      _productId = ModalRoute.of(context)!.settings.arguments as List<int>;
      _t1 = _productId[0];
      _t2 = _productId[1];
      _t3 = _productId[2];
      _tremain = _productId[3];
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: const Color(0xff48d683),
        body: Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/TT.png'),
        fit: BoxFit.fitHeight,
        opacity: 20,
      )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 20, bottom: 20),
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
            padding: const EdgeInsets.all(20.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaY: 16,
                  sigmaX: 16,
                ),
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.5,
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
                          image: AssetImage('assets/TT.png'),
                          fit: BoxFit.fitHeight),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    /*alignment: Alignment.bottomCenter,
                        padding: const EdgeInsets.only(bottom: 30, top: 30),
                        // width: ,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.0),
                            topRight: Radius.circular(25.0),
                            bottomRight: Radius.circular(22.0),
                            bottomLeft: Radius.circular(22.0),
                          ),
                        ),*/
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            const Text(
                              "Select\nThe Table",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            DropDown(
                              itemList: const [
                                'Table 1',
                                'Table 2',
                                'Table 3',
                              ],
                              item1: 'Table',
                              submitFn: _selectedTable,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            // const Text("No. of Racket  "),
                            const Text(
                              "Number\nof Racket",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            DropDown(
                                itemList: const ['1', '2', '3', '4'],
                                item1: 'Racket',
                                submitFn: _selectedRacket),
                          ],
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Time Of Issuement',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),),
                              ),
                              Center(
                                child: DateTimeField(
                                  resetIcon: const Icon(
                                    Icons.close,
                                    color: Colors.blue,
                                    size: 35,
                                  ),
                                  initialValue: DateTime.now(),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  enabled: true,
                                  enableInteractiveSelection: true,
                                  decoration: const InputDecoration(
                                    icon: Padding(
                                      padding: EdgeInsets.only(left: 6.0),
                                      child: FaIcon(
                                        FontAwesomeIcons.calendar,
                                        color: Colors.redAccent,
                                        size: 35,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      borderSide: BorderSide(
                                          color: Colors.black12, width: 2),
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
                    )),
              ),
            ),
          ),
          const SizedBox(
            height: 9.0,
          ),
          Center(
            child: RaisedButton(
              onPressed: () {
                submit(context);
              },
              color: Colors.white,
              splashColor: Colors.lightBlueAccent,
              elevation: 10.0,
              shape: const StadiumBorder(),
              child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Text('SEND THE REQUEST')),
            ),
          ),
        ],
      ),
    ));
  }
}

class DropDown extends StatefulWidget {
  final List itemList;
  final String item1;
  final void Function(String selectedValue) submitFn;
  const DropDown(
      {Key? key,
      required this.itemList,
      required this.item1,
      required this.submitFn})
      : super(key: key);
  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String? selectedValue = "";

  @override
  void initState() {
    // TODO: implement initState
    selectedValue = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton2(
      isExpanded: true,
      hint: Row(
        children: [
          const FaIcon(
            FontAwesomeIcons.bars,
            color: Colors.yellow,
            size: 16,
          ),
          const SizedBox(
            width: 4,
          ),
          Expanded(
            child: Center(
              child: Text(
                widget.item1,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
      items: widget.itemList
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ))
          .toList(),
      value: selectedValue,
      onChanged: (value) {
        setState(() {
          selectedValue = value as String;
          widget.submitFn(selectedValue!);
          // print("itrt = $trt");
          value = null;
        });
      },
      icon: const Padding(
        padding: EdgeInsets.only(bottom: 9.0),
        child: FaIcon(
          FontAwesomeIcons.sortDown,
          color: Colors.yellow,
          size: 20,
        ),
      ),
      iconSize: 34,
      iconEnabledColor: Colors.yellow,
      iconDisabledColor: Colors.grey,
      buttonHeight: 50,
      buttonWidth: 150,
      buttonPadding: const EdgeInsets.only(left: 14, right: 14),
      buttonDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.black26,
        ),
        color: Colors.redAccent,
      ),
      buttonElevation: 2,
      itemHeight: 40,
      itemPadding: const EdgeInsets.only(left: 14, right: 14),
      dropdownMaxHeight: 200,
      dropdownWidth: 200,
      dropdownPadding: null,
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.redAccent,
      ),
      dropdownElevation: 8,
      scrollbarRadius: const Radius.circular(40),
      scrollbarThickness: 6,
      scrollbarAlwaysShow: true,
      offset: const Offset(-20, 0),
    );
  }
}
