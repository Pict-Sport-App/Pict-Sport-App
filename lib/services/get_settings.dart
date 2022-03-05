import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:psa/models/settings.dart';

Future getequiment()async{
  var v= await  FirebaseFirestore.instance.
  collection('Settings').doc('xx').get();

  if (v.exists){
    Equipment.basketballsix=v.get('basketball_Size_Six');
    Equipment.basketballseven=v.get('basketball_Size_Seven');
    Equipment.tabletennis=v.get('tabletennis');
    Equipment.vollyball=v.get('vollyball');
    Equipment.cricketbat=v.get('cricket_bat');
    Equipment.cricketball=v.get('cricket_ball');
    Equipment.crickethelmet=v.get('cricket_helmet');
    Equipment.cricketinnerpad=v.get('cricket_innerPad');
    Equipment.cricketpad=v.get('cricket_pad');
    Equipment.cricketgloves=v.get('cricket_gloves');
    Equipment.football=v.get('football');
  }else{
    return const CircularProgressIndicator();
  }
  return;
}