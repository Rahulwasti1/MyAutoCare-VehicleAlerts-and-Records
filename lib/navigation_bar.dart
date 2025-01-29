import 'package:automobile_datamanagement/User_Screen/alerts.dart';
import 'package:automobile_datamanagement/User_Screen/home.dart';
import 'package:automobile_datamanagement/User_Screen/profile.dart';
import 'package:automobile_datamanagement/User_Screen/vehicles.dart';
import 'package:flutter/material.dart';

class NavigationBar extends StatefulWidget {
  const NavigationBar({super.key});

  @override
  State<NavigationBar> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  int currentIndex = 0;

  List screens = [UserHome(), UserVehicles(), UserAlert(), UserProfile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
