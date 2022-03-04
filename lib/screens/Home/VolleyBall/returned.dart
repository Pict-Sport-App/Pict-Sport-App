import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:psa/screens/Home/VolleyBall/requested.dart';

class ReturnVolly extends StatefulWidget {
  const ReturnVolly({Key? key}) : super(key: key);

  @override
  _ReturnVollyState createState() => _ReturnVollyState();
}

class _ReturnVollyState extends State<ReturnVolly> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Ball Returned'),
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('VVEquipment')
                .snapshots(),
            builder: (ctx, equimentSnapshot) {
              if (equimentSnapshot.connectionState
                  == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final reqMembers = equimentSnapshot.data!.docs;
              return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: reqMembers.length,
                  itemBuilder: (ctx, index) => reqMembers[index]['isReturn']
                      ?VVRequest(
                      isReturn: reqMembers[index]['isReturn'],
                      image: reqMembers[index]['url'],
                      uid: reqMembers[index]['uid'],
                      timeOfReturn: reqMembers[index]['timeOfReturn'],
                      timeOfIssue: reqMembers[index]['timeOfIssue'],
                      noOfBall: reqMembers[index]['noOfBall'],
                      name: reqMembers[index]['name'],
                      isAdmin: false, misId: reqMembers[index]['misId'])
                      : Container());
            },
          ),
        ));
  }
}
