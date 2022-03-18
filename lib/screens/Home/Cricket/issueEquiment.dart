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

class CricketIssue extends StatefulWidget {
  const CricketIssue({Key? key}) : super(key: key);
  static const routeName = '/cr';

  @override
  _CricketIssueState createState() => _CricketIssueState();
}

class _CricketIssueState extends State<CricketIssue> {

  final formatYMDHM = DateFormat("yyyy-MM-dd HH:mm");
  DateTime? eventDate = DateTime.now();
  TimeOfDay time = TimeOfDay.now();

  String? chossedBall,
      chossedBat,chossedGloves,
      chossedPad,chossedInnerPad,
      chossedHelmet;

  void _selectedBall(String ball)=>chossedBall=ball;
  void _selectedBat(String bat)=>chossedBat=bat;
  void _selectedGloves(String gloves)=>chossedGloves=gloves;
  void _selectedPad(String pad)=>chossedPad=pad;
  void _selectedInnerPad(String innerPad)=>chossedInnerPad=innerPad;
  void _selectedHelmet(String hel)=>chossedHelmet=hel;

  Future _submit()async{
    var bALL=0,bAT=0,gLOVES=0,iNNERPAD=0,pAD=0,hELMET=0;

    if (chossedBall!=null){
      bALL=int.parse(_productId[0].toString()) - int.parse(chossedBall.toString());
    }else{chossedBall="0";}
    if (chossedBat!=null){
      bAT=int.parse(_productId[1].toString()) - int.parse(chossedBat.toString());
    }else{chossedBat="0";}
    if (chossedGloves!=null){
      gLOVES=int.parse(_productId[2].toString()) - int.parse(chossedGloves.toString());
    }else{chossedGloves="0";}
    if (chossedInnerPad!=null){
      iNNERPAD=int.parse(_productId[3].toString()) - int.parse(chossedInnerPad.toString());
    }else{chossedInnerPad="0";}
    if (chossedPad!=null){
      pAD=int.parse(_productId[4].toString()) - int.parse(chossedPad.toString());
    }else{chossedPad="0";}
    if (chossedHelmet!=null){
      hELMET=int.parse(_productId[5].toString()) - int.parse(chossedHelmet.toString());
    }else{chossedHelmet="0";}
    print(chossedBat);
    print(chossedGloves);
    print(chossedInnerPad);
    print(chossedPad);
    print(chossedHelmet);
    print(chossedBall);
    print('hello');
    if (chossedHelmet==null
    && chossedInnerPad==null
    && chossedPad==null &&
    chossedGloves==null
    && chossedBat==null
    && chossedBall==null){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 2),
        content: Text(
          'Please select at least one field',
          style: TextStyle(
            color: Colors.red,
            fontSize: 15,
          ),
        ),
      ));
    }else if (bALL<0){
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
    }else if (bAT<0){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 2),
        content: Text(
          'Oops!!! The number of bat requested are not available',
          style: TextStyle(
            color: Colors.red,
            fontSize: 15,
          ),
        ),
      ));
    }else if (gLOVES<0){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 2),
        content: Text(
          'Oops!!! The number of gloves requested are not available',
          style: TextStyle(
            color: Colors.red,
            fontSize: 15,
          ),
        ),
      ));
    }else if (iNNERPAD<0){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 2),
        content: Text(
          'Oops!!! The number of inner pad requested are not available',
          style: TextStyle(
            color: Colors.red,
            fontSize: 15,
          ),
        ),
      ));
    }else if (pAD<0){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 2),
        content: Text(
          'Oops!!! The number of pad requested are not available',
          style: TextStyle(
            color: Colors.red,
            fontSize: 15,
          ),
        ),
      ));
    }else if (hELMET<0){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 2),
        content: Text(
          'Oops!!! The number of helmet requested are not available',
          style: TextStyle(
            color: Colors.red,
            fontSize: 15,
          ),
        ),
      ));
    } else{
      FirebaseFirestore.instance.collection('CREquipment')
          .doc(UserDetails.uid).set({
        'bat': chossedBat,
        'ball':chossedBall,
        'gloves':chossedGloves,
        'pad':chossedPad,
        'innerPad':chossedInnerPad,
        'helmet':chossedHelmet,
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
      _productId = ModalRoute.of(context)!.settings.arguments as List;
    }
    _isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    double wei = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/cricket.jpg'),
              fit: BoxFit.fitHeight,
              opacity: 20,
            )),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
                child: Container(
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
                        //height: hei * 0.5,
                        width: wei * 0.9,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          image: DecorationImage(
                              image: AssetImage('assets/cricket.jpg'),
                              fit: BoxFit.fill),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 25,),
                            Row(
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
                                    itemList: const ['1','2','3','4','5','6'],
                                    item1: 'Ball',
                                    submitFn: _selectedBall),
                              ],
                            ),
                            const SizedBox(height: 15,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text(
                                  'Number of \nBat',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                DropDown(
                                    itemList: const ['1', '2','3','4','5'],
                                    item1: 'Bat',
                                    submitFn: _selectedBat),
                              ],
                            ),
                            const SizedBox(height: 15,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text(
                                  'Number of \nGloves',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                DropDown(
                                    itemList: const ['1', '2','3','4','5'],
                                    item1: 'Gloves',
                                    submitFn: _selectedGloves),
                              ],
                            ),
                            const SizedBox(height: 15,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text(
                                  'Number of \nPad',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                DropDown(
                                    itemList: const ['1', '2','3','4','5'],
                                    item1: 'Pad',
                                    submitFn: _selectedPad),
                              ],
                            ),
                            const SizedBox(height: 15,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text(
                                  'Number of \nInnerPad',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                DropDown(
                                    itemList: const ['1', '2','3','4','5'],
                                    item1: 'InnerPad',
                                    submitFn: _selectedInnerPad),
                              ],
                            ),
                            const SizedBox(height: 15,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text(
                                  'Number of \nHelmet',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                DropDown(
                                    itemList: const ['1', '2','3','4','5'],
                                    item1: 'Helmet',
                                    submitFn: _selectedHelmet),
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
                                      decoration:  const InputDecoration(
                                        icon: FaIcon(
                                          FontAwesomeIcons.calendarDay,
                                          color: Colors.redAccent,
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
                            const SizedBox(height: 25,),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
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
      ),
    );
  }
}
