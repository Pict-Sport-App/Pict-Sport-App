import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:psa/models/settings.dart';

Future GetEquiment()async{
  var v= await  FirebaseFirestore.instance.
  collection('Settings').doc('xx').get();

  if (v.exists){
    Equiment.basketball_Six=v.get('basketball_Size_Six');
    Equiment.basketball_Seven=v.get('basketball_Size_Seven');
    Equiment.tabletennis=v.get('tabletennis');
    Equiment.vollyball=v.get('vollyball');
  }else{
    return const CircularProgressIndicator();
  }
  return;
}