import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:psa/screens/Home/Football/requestedScreen.dart';
import 'package:psa/screens/Home/VolleyBall/requested.dart';

class ReturnedFootball extends StatelessWidget {
  const ReturnedFootball({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Ball Returned'),
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('FFEquipment')
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
                      ?FFRequest(
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
