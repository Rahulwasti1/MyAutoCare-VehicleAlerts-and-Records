import 'package:automobile_datamanagement/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserVehicles extends StatefulWidget {
  const UserVehicles({super.key});

  @override
  State<UserVehicles> createState() => _UserVehiclesState();
}

final databaseReference = FirebaseDatabase.instance.of("Storedata");

class _UserVehiclesState extends State<UserVehicles> {

  Widget FromInputField({required IconData icon, required String hintText}) {
    return TextField(
      decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => userNavBar()));
                      },
                      icon: Icon(Icons.arrow_back)),
                ),
                SizedBox(width: 60.w),
                Text(
                  "Vehicle Form Fields",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  FromInputField(
                      icon: Icons.directions_car, hintText: "Vehicle Name"),
                  SizedBox(height: 14),
                  FromInputField(icon: Icons.model_training, hintText: "Model"),
                  SizedBox(height: 14),
                  FromInputField(
                      icon: Icons.confirmation_number,
                      hintText: "Registration Number"),
                  SizedBox(height: 14),
                  FromInputField(
                      icon: Icons.account_balance_wallet,
                      hintText: "Tax Expiry Date"),
                  SizedBox(height: 14),
                  FromInputField(
                      icon: Icons.badge, hintText: "License Expiry Date"),
                  SizedBox(height: 14),
                  FromInputField(
                      icon: Icons.build, hintText: "Maintenance Schedule"),
                  SizedBox(height: 25),
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(330.w, 45.h),
                        backgroundColor: const Color(0xFF007dff),
                      ),
                      child: Text(
                        "Add Vehicle",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ))
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
