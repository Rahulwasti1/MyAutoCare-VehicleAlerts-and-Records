import 'package:flutter/material.dart';

class UserHome extends StatefulWidget {
  final String vehicleNumber;
  final String vehicleName;
  final String vehicleModel;
  final String vehicleRegno;
  final String vehicleTaxExpiry;
  final String vehicleLicenseExpiry;
  final String vehicleMaintenanceSchedule;

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
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Home"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${widget.vehicleName} (${widget.vehicleModel})",
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Vehicle Number: ${widget.vehicleNumber}",
                      style: const TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    const SizedBox(height: 10),
                    ExpansionTile(
                      title: const Text("View Vehicle Details"),
                      trailing: Icon(_isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down),
                      onExpansionChanged: (expanded) {
                        setState(() {
                          _isExpanded = expanded;
                        });
                      },
                      children: [
                        ListTile(
                          title: Text("Registration Number: ${widget.vehicleRegno}"),
                        ),
                        ListTile(
                          title: Text("Tax Expiry Date: ${widget.vehicleTaxExpiry}"),
                        ),
                        ListTile(
                          title: Text("License Expiry Date: ${widget.vehicleLicenseExpiry}"),
                        ),
                        ListTile(
                          title: Text("Maintenance Schedule: ${widget.vehicleMaintenanceSchedule}"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
