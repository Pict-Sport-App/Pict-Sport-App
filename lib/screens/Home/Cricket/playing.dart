import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:psa/screens/Home/Cricket/requested.dart';

class PlayingCricket extends StatelessWidget {
  const PlayingCricket({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading:  IconButton(
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
            title: const Text('Ball Issued'),
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('CREquipment')
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
                  itemBuilder: (ctx, index) =>
                  reqMembers[index]['isRequested'] == 2
                      ? CRWidget(
                    isReturn: reqMembers[index]['isReturn'],
                    image: reqMembers[index]['url'],
                    uid: reqMembers[index]['uid'],
                    timeOfReturn: reqMembers[index]['timeOfReturn'],
                    timeOfIssue: reqMembers[index]['timeOfIssue'],
                    ball: reqMembers[index]['ball'].toString(),
                    bat: reqMembers[index]['bat'].toString(),
                    innerPad: reqMembers[index]['innerPad'],
                    pad: reqMembers[index]['pad'],
                    helmet: reqMembers[index]['helmet'],
                    gloves: reqMembers[index]['gloves'],
                    name: reqMembers[index]['name'],
                    isAdmin: false,
                    misId: reqMembers[index]['misId'],
                  )
                      : Container());
            },
          ),
        ));
  }
}
