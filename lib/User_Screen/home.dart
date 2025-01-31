import 'package:flutter/material.dart';

// Vehicle class to store the data
class UserHome extends StatelessWidget {
  // Required named parameters for vehicle details
  final String vehicleNumber;
  final String vehicleName;
  final String vehicleModel;
  final String vehicleRegno;
  final String vehicleTaxExpiry;
  final String vehicleLicenseExpiry;
  final String vehicleMaintenanceSchedule;

  // Constructor to accept the data
  const UserHome({
    super.key,
    required this.vehicleNumber,
    required this.vehicleName,
    required this.vehicleModel,
    required this.vehicleRegno,
    required this.vehicleTaxExpiry,
    required this.vehicleLicenseExpiry,
    required this.vehicleMaintenanceSchedule,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Home")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Vehicle Number: $vehicleNumber"),
            Text("Vehicle Name: $vehicleName"),
            Text("Vehicle Model: $vehicleModel"),
            Text("Registration Number: $vehicleRegno"),
            Text("Tax Expiry Date: $vehicleTaxExpiry"),
            Text("License Expiry Date: $vehicleLicenseExpiry"),
            Text("Maintenance Schedule: $vehicleMaintenanceSchedule"),
          ],
        ),
      ),
    );
  }
}
