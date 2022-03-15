import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:psa/screens/Home/Badminton/requested.dart';

class BadmintonReturn extends StatelessWidget {
  const BadmintonReturn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const FaIcon(
                FontAwesomeIcons.arrowCircleLeft,
                color: Colors.white,
                size: 30,
              ),
            ),
            centerTitle: true,
            title: const Text('Ball Returned'),
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream:
            FirebaseFirestore.instance.collection('BTEquipment').snapshots(),
            builder: (ctx, equimentSnapshot) {
              if (equimentSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final reqMembers = equimentSnapshot.data!.docs;
              return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: reqMembers.length,
                  itemBuilder: (ctx, index) => reqMembers[index]['isReturn']
                      ? BTReturn(
                      isReturn: reqMembers[index]['isReturn'],
                      image: reqMembers[index]['url'],
                      uid: reqMembers[index]['uid'],
                      timeOfReturn: reqMembers[index]['timeOfReturn'],
                      timeOfIssue: reqMembers[index]['timeOfIssue'],
                      noOfRacket: reqMembers[index]['noOfRacket'].toString(),
                      noOfCock: reqMembers[index]['noOfCock'].toString(),
                      name: reqMembers[index]['name'],
                      isAdmin: false,
                      misId: reqMembers[index]['misId'])
                      : Container());
            },
          ),
        ));
  }
}
