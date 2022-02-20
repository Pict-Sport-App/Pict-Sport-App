import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavigationModel {
  String title;
  // IconData icon;
  int num;
  NavigationModel({required this.title, required this.num});
}

List<NavigationModel> navigationItems = [
  NavigationModel(title: "App User", num: 1),
  NavigationModel(title: "Setting", num: 2),
  NavigationModel(title: "Notifications", num: 3),
  NavigationModel(title: "Calender", num: 4),
  NavigationModel(title: "LogOut", num: 5),
];
