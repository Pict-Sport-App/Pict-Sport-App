import 'package:flutter/material.dart';
import 'package:psa/appdrawer/settings.dart';
import 'package:psa/screens/announcements/create_annoucement.dart';

class MainSettings extends StatelessWidget {
  const MainSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
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
              child: Container(
                height: 50,
                child: Row(
                  children: const [
                    Icon(Icons.handyman),
                    SizedBox(width: 10),
                    Text('Create an annoucement',
                        style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 12),
            Container(
              height: 50,
              child: Row(
                children: const [
                  Icon(Icons.handyman),
                  SizedBox(width: 10),
                  Text('Edit an annoucement', style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
            SizedBox(height: 12),
            GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Setting())),
              child: Container(
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
    );
  }
}
