import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:psa/models/user_details.dart';
import 'package:psa/screens/intial_page.dart';
import 'package:psa/services/get_settings.dart';
import 'package:psa/services/loading.dart';
import 'update_user_info.dart';

class GetUserData extends StatelessWidget {
  late String documentId;

  GetUserData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    documentId = uid;
    CollectionReference users = FirebaseFirestore.instance.collection('User');
    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(documentId).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData && !snapshot.data!.exists) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            UserDetails.email = data['email'].toString();
            UserDetails.name = data['name'].toString();
            UserDetails.misId = data['misId'].toString();
            UserDetails.photourl = data['photourl'].toString();
            UserDetails.uid = data['uid'].toString();
            UserDetails.isAdmin = data['isAdmin'];
            UserDetails.isDeveloper=data['isDeveloper'];
            UserDetails.sportList =
                Map<String, bool?>.from(data['SportList']).cast<String, bool>();
            UserDetails.officialsportMap=
            Map<String,int?>.from(data['Official SportList']).cast<String,int>();
            checkmysportlist();
            UserDetails.location = data['location'].toString();
            UserDetails.headline = data['headLine'].toString();
            UserDetails.rollNo = data['rollNo'].toString();
            UserDetails.achivement = data['achievement'].toString();
            UserDetails.aboutMe = data['aboutMe'].toString();
            UserDetails.instaUrl = data['insta'].toString();
            UserDetails.twitterUrl = data['twitter'].toString();
            UserDetails.linkedInUrl = data['linkedIn'].toString();
            UserDetails.whatAppNo = data['whatAppNo'].toString();
            UserDetails.birthday = data['dob'].toString();
            getequiment();
            return const IntialScreen();
          }
          return const Loading();
        });
  }
}
