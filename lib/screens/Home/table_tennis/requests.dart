import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:psa/models/user_details.dart';
import 'package:psa/screens/Home/table_tennis/widget.dart';

class Request extends StatefulWidget {
  const Request({Key? key}) : super(key: key);

  @override
  _RequestState createState() => _RequestState();
}

class _RequestState extends State<Request> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Padding(
            padding: EdgeInsets.only(left: 16.0, top: 12),
            child: FaIcon(
              FontAwesomeIcons.arrowLeft,
              color: Colors.white,
              size: 25,
            ),
          ),
        ),
        centerTitle: true,
        title: const Text('Table Tennis Requests'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('TTEquipment').snapshots(),
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
              itemBuilder: (ctx, index) => reqMembers[index]['isRequested'] == 1
                  ? RequestWidget(
                      returnTime: reqMembers[index]['timeOfReturn'],
                      requestScreen: true,
                      isAdmin: UserDetails.isAdmin ?? false,
                      isViewing: false,
                      name: reqMembers[index]['name'],
                      misId: reqMembers[index]['misId'],
                      image: reqMembers[index]['photourl'],
                      tableNumber: reqMembers[index]['tableNumber'],
                      racketNumber: reqMembers[index]['racketNumber'],
                      time: reqMembers[index]['timeOfIsuue'],
                      uid: reqMembers[index]['uid'],
                    )
                  : Container());
        },
      ),
    ));
  }
}
