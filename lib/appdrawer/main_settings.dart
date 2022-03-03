import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:psa/appdrawer/settings.dart';
import 'package:psa/models/userDetails.dart';
import 'package:psa/screens/announcements/create_annoucement.dart';

class MainSettings extends StatelessWidget {
  const MainSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: UserDetails.isAdmin==true? Padding(
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
                  Text('Edit an announcement', style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Setting())),
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
      ):Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity-130,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFF8D),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text('Only Admins have \n access to this page',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),),
                  ),
                ),
              ),
            ),
            RaisedButton(onPressed: (){},
            child: const Text('Request for Admin access'),)
          ],
        ),
      ),
    );
  }
}
