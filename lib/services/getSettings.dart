import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:psa/models/settings.dart';

Future GetEquiment()async{
  var v= await  FirebaseFirestore.instance.
  collection('Settings').doc('xx').get();

  if (v.exists){
    Equiment.basketball_Six=v.get('basketball_Size_Six');
    //print(Equiment.basketball_Six);
    Equiment.basketball_Seven=v.get('basketball_Size_Seven');
    Equiment.tabletennis=v.get('tabletennis');
  }else{
    return const CircularProgressIndicator();
  }
  return;
}

/*class GetSettings extends StatelessWidget {
  
  //String documentId='xx';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.
      collection('Settings').doc('xx').get(),
        builder:
    (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
    if (snapshot.hasError) {
    return const Center(child: CircularProgressIndicator());
    }
    if (snapshot.hasData && !snapshot.data!.exists) {
    return const Center(child: CircularProgressIndicator());
    }
    if (snapshot.connectionState == ConnectionState.done){
      Map<String, dynamic> data =
      snapshot.data!.data() as Map<String, dynamic>;
      Equiment.basketball_Six=data['basketball_Size_Six'];
      Equiment.basketball_Seven=data['basketball_Size_Seven'];
      Equiment.tabletennis=data['tabletennis'];
    }
    return null;
    });
  }
}*/
