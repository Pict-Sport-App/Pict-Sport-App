import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:psa/appdrawer/settings.dart';
import 'package:psa/models/user_details.dart';
import 'package:psa/screens/announcements/create_annoucement.dart';
import 'package:psa/widget/constants.dart';

class MainSettings extends StatefulWidget {
  const MainSettings({Key? key}) : super(key: key);

  @override
  _MainSettingsState createState() => _MainSettingsState();
}

class _MainSettingsState extends State<MainSettings> {


  Future adminRequest(BuildContext ctx)async{
    await FirebaseFirestore.instance
        .collection('AdminRequest')
        .doc(UserDetails.uid).set({
      'accept': false,
      'name': UserDetails.name,
      'misId': UserDetails.misId,
      'whatappnumber':UserDetails.whatAppNo,
      'photoUrl': UserDetails.photourl,
      'uid':UserDetails.uid,
    });
    ScaffoldMessenger.of(ctx).
    showSnackBar(const SnackBar(content: Text(
      'Request has been send',
    )));
    Navigator.pop(ctx);
  }

  bool _isRequested=false;

  Future getRequestData(BuildContext context)async{
    var v=await FirebaseFirestore.instance.collection('AdminRequest')
    .doc(UserDetails.uid).get();
    if (v.exists){
      setState(() {
        _isRequested= true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRequestData(context);

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const FaIcon(
            FontAwesomeIcons.arrowCircleLeft,
            color: Colors.white,
            size: 25,
          ),
        ),
      ),
      body: UserDetails.isAdmin == true
          ? Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage(kkbackgroundImage),
              fit: BoxFit.cover
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CreateAnnoucement()));
                },
                child: SizedBox(
                  height: 50,
                  child: Row(
                    children: const [
                      Icon(Icons.handyman),
                      SizedBox(width: 10),
                      Text('Create an announcement',
                          style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 50,
                child: Row(
                  children: const [
                    Icon(Icons.handyman),
                    SizedBox(width: 10),
                    Text('Edit an announcement',
                        style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Setting())),
                child: SizedBox(
                  height: 50,
                  child: Row(
                    children: const [
                      Icon(Icons.handyman),
                      SizedBox(width: 10),
                      Text('Edit equipment count',
                          style: TextStyle(fontSize: 18)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )
          : _isRequested==false? Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage(kkbackgroundImage),
              fit: BoxFit.cover
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity - 130,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFF8D),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'Only Admins have \n access to this page',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                adminRequest(context);
              },
              child: const Text('Request for Admin access'),
            )
          ],
        ),
      ):Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage(kkbackgroundImage),
              fit: BoxFit.cover
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity - 130,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFF8D),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'Admin request has been send',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
