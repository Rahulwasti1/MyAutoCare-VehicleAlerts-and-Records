import 'package:automobile_datamanagement/User_Screen/home.dart';
import 'package:automobile_datamanagement/User_Screen/profile.dart';
import 'package:automobile_datamanagement/User_Screen/vehicles.dart';
import 'package:flutter/material.dart';

class userNavBar extends StatefulWidget {
  const userNavBar({super.key});

  @override
  State<userNavBar> createState() => _userNavBarState();
}

class _userNavBarState extends State<userNavBar> {
  int currentIndex = 0;
  // Creating list of screens
  List screens = [
    UserHome(
      vehicleNumber: '12',
      vehicleLicenseExpiry: '12',
      vehicleMaintenanceSchedule: '123',
      vehicleModel: '123',
      vehicleName: 'qwe',
      vehicleRegno: '123',
      vehicleTaxExpiry: 'ad',
    ),
    UserVehicles(),
    UserProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    currentIndex = 0;
                  });
                },
                icon: Icon(
                  Icons.home,
                  size: 30,
                  color: currentIndex == 0 ? Color(0xFF029BFA) : Colors.grey,
                )),
            IconButton(
                onPressed: () {
                  setState(() {
                    currentIndex = 1;
                  });
                },
                icon: Icon(
                  Icons.directions_car,
                  size: 30,
                  color: currentIndex == 1 ? Color(0xFF029BFA) : Colors.grey,
                )),
            IconButton(
                onPressed: () {
                  setState(() {
                    currentIndex = 2;
                  });
                },
                icon: Icon(
                  Icons.person,
                  size: 30,
                  color: currentIndex == 2 ? Color(0xFF029BFA) : Colors.grey,
                )),
          ],
        ),
      ),
      body: screens[currentIndex],
    );
  }
}
