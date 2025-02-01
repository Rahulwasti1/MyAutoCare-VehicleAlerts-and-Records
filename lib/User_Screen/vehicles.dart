import 'package:automobile_datamanagement/navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final databaseReference = FirebaseDatabase.instance.ref("Storedata");

class UserVehicles extends StatefulWidget {
  const UserVehicles({super.key});

  @override
  State<UserVehicles> createState() => _UserVehiclesState();
}

class _UserVehiclesState extends State<UserVehicles> {
  // TextEditingControllers
  final TextEditingController vehicleNumberController = TextEditingController();
  final TextEditingController vehicleNameController = TextEditingController();
  final TextEditingController vehicleModelController = TextEditingController();
  final TextEditingController vehicleRegnoController = TextEditingController();
  final TextEditingController vehicleTexExpiryController =
      TextEditingController();
  final TextEditingController vehicleLicenseController =
      TextEditingController();
  final TextEditingController vehicleMaintenanceController =
      TextEditingController();

  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  // Input Field Widget with validation
  Widget FromInputField({
    required IconData icon,
    required String hintText,
    required TextInputType keyboardType,
    required TextEditingController mycontroller,
    required String? Function(String?) validator, // Validation function
  }) {
    return TextFormField(
      controller: mycontroller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      ),
      validator: validator, // Use the validator
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formKey, // Attach form key to manage the state
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
                              builder: (context) => userNavBar(),
                            ),
                          );
                        },
                        icon: Icon(Icons.arrow_back),
                      ),
                    ),
                    SizedBox(width: 60.w),
                    Text(
                      "Vehicle Form Fields",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      FromInputField(
                        keyboardType: TextInputType.number,
                        mycontroller: vehicleNumberController,
                        icon: Icons.confirmation_number,
                        hintText: "Vehicle Number",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter vehicle number';
                          }
                          return null; // Return null if the input is valid
                        },
                      ),
                      SizedBox(height: 14),
                      FromInputField(
                        keyboardType: TextInputType.text,
                        mycontroller: vehicleNameController,
                        icon: Icons.directions_car,
                        hintText: "Vehicle Name",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter vehicle name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 14),
                      FromInputField(
                        keyboardType: TextInputType.numberWithOptions(),
                        mycontroller: vehicleModelController,
                        icon: Icons.model_training,
                        hintText: "Model",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter vehicle model';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 14),
                      FromInputField(
                        keyboardType: TextInputType.number,
                        mycontroller: vehicleRegnoController,
                        icon: Icons.description,
                        hintText: "Registration Number",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter registration number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 14),
                      FromInputField(
                        keyboardType: TextInputType.datetime,
                        mycontroller: vehicleTexExpiryController,
                        icon: Icons.account_balance_wallet,
                        hintText: "Tax Expiry Date (MM/DD/YY)",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter tax expiry date';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 14),
                      FromInputField(
                        keyboardType: TextInputType.datetime,
                        mycontroller: vehicleLicenseController,
                        icon: Icons.badge,
                        hintText: "License Expiry Date (MM/DD/YY)",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter license expiry date';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 14),
                      FromInputField(
                        keyboardType: TextInputType.datetime,
                        mycontroller: vehicleMaintenanceController,
                        icon: Icons.build,
                        hintText: "Maintenance Schedule (MM/DD/YY)",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter maintenance schedule';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 25),
                      ElevatedButton(
                        // Inside the ElevatedButton onPressed function
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            try {
                              // Get current user
                              User? user = FirebaseAuth.instance.currentUser;

                              if (user != null) {
                                String userEmail = user.email ?? "Unknown";

                                // Add data to Realtime Database with email
                                databaseReference
                                    .child(DateTime.now()
                                        .microsecondsSinceEpoch
                                        .toString())
                                    .set({
                                  'userEmail':
                                      userEmail, // Store the email in the database
                                  'vehicleNumber': vehicleNumberController.text,
                                  'vehicleName': vehicleNameController.text,
                                  'vehicleModel': vehicleModelController.text,
                                  'vehicleRegno': vehicleRegnoController.text,
                                  'vehicleTaxExpiry':
                                      vehicleTexExpiryController.text,
                                  'vehicleLicenseExpiry':
                                      vehicleLicenseController.text,
                                  'vehicleMaintenanceSchedule':
                                      vehicleMaintenanceController.text,
                                });

                                // Navigate to UserHome after successful addition
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => userNavBar(),
                                  ),
                                );

                                // Provide success feedback
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text("Vehicle Added Successfully!")),
                                );
                              } else {
                                // Handle case when user is not logged in
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("User not logged in!")),
                                );
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text("Failed to add vehicle: $e")),
                              );
                            }
                          } else {
                            // If the form is invalid, show an error
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      "Please fill all the required fields")),
                            );
                          }
                        }
                        // onPressed: () {
                        //   if (_formKey.currentState?.validate() ?? false) {
                        //     // If the form is valid, proceed with the database operation
                        //     try {
                        //       // Add data to Realtime Database
                        //       databaseReference
                        //           .child(DateTime.now()
                        //               .microsecondsSinceEpoch
                        //               .toString())
                        //           .set({
                        //         'vehicleNumber': vehicleNumberController.text,
                        //         'vehicleName': vehicleNameController.text,
                        //         'vehicleModel': vehicleModelController.text,
                        //         'vehicleRegno': vehicleRegnoController.text,
                        //         'vehicleTaxExpiry':
                        //             vehicleTexExpiryController.text,
                        //         'vehicleLicenseExpiry':
                        //             vehicleLicenseController.text,
                        //         'vehicleMaintenanceSchedule':
                        //             vehicleMaintenanceController.text,
                        //       });

                        //       // After successful data addition, navigate to UserHome with data
                        //       Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //           builder: (context) => userNavBar(),
                        //         ),
                        //       );

                        //       // Provide feedback after successful addition
                        //       ScaffoldMessenger.of(context).showSnackBar(
                        //         SnackBar(
                        //             content:
                        //                 Text("Vehicle Added Successfully!")),
                        //       );
                        //     } catch (e) {
                        //       ScaffoldMessenger.of(context).showSnackBar(
                        //         SnackBar(
                        //             content: Text("Failed to add vehicle: $e")),
                        //       );
                        //     }
                        //   } else {
                        //     // If the form is invalid, show an error
                        //     ScaffoldMessenger.of(context).showSnackBar(
                        //       SnackBar(
                        //           content: Text(
                        //               "Please fill all the required fields")),
                        //     );
                        //   }
                        ,
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
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
