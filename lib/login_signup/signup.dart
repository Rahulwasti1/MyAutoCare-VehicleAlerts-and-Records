import 'package:automobile_datamanagement/login_signup/login.dart';
import 'package:automobile_datamanagement/navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String? name, email, password;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  /// 📌 Helper function to show Snackbar messages
  void showSnackbar(String message, {Color color = Colors.red}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(
          message,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  /// 📌 Firebase Registration Function
  registration() async {
    if (name == null || email == null || password == null) {
      showSnackbar("Please fill in all fields");
      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);

      print("User registered: ${userCredential.user?.uid}");

      // 🔹 Save user details & FCM token in Firestore
      await saveUserData(email!, name!);

      // Show success message
      showSnackbar("Registered Successfully", color: Colors.green);

      // Navigate to UserHome page
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => userNavBar()));
    } on FirebaseAuthException catch (e) {
      print("Firebase Auth Error: ${e.message}");
      if (e.code == 'weak-password') {
        showSnackbar("Password is too weak");
      } else if (e.code == 'email-already-in-use') {
        showSnackbar("Account already exists");
      } else if (e.code == 'invalid-email') {
        showSnackbar("Invalid email format");
      } else {
        showSnackbar("Error: ${e.message}");
      }
    } catch (e) {
      print("General error: $e");
      showSnackbar("Something went wrong, please try again");
    }
  }

  /// 📌 Store User Data & FCM Token in Firestore
  Future<void> saveUserData(String userEmail, String userName) async {
    String? token = await FirebaseMessaging.instance.getToken();
    
    if (token != null) {
      await FirebaseFirestore.instance.collection("users").doc(userEmail).set({
        "name": userName,
        "email": userEmail,
        "fcm_token": token, // Store FCM Token
      }, SetOptions(merge: true));

      print("User & FCM Token saved: $userEmail, Token: $token");
    } else {
      print("Failed to get FCM Token");
    }
  }

  /// 📌 Custom Text Field Widget
  Widget customTextField({
    required String hintText,
    required IconData icon,
    required TextEditingController mycontroller,
    required String name,
  }) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please Enter your $name";
        }
        return null;
      },
      controller: mycontroller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.w),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.w),
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 80.h),
              Text("Let's Get Started!",
                  style:
                      TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold)),
              Text("Create an account", style: TextStyle(fontSize: 14.sp)),
              Padding(
                padding: EdgeInsets.all(30.w),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      customTextField(
                          hintText: "Username",
                          icon: Icons.person,
                          mycontroller: nameController,
                          name: "Username"),
                      SizedBox(height: 13.h),
                      customTextField(
                          hintText: "Email",
                          icon: Icons.email,
                          mycontroller: emailController,
                          name: "Email"),
                      SizedBox(height: 13.h),
                      customTextField(
                          hintText: "Password",
                          icon: Icons.lock,
                          mycontroller: passwordController,
                          name: "Password"), // Secure password input
                      SizedBox(height: 20.h),
                      ElevatedButton(
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              setState(() {
                                name = nameController.text.trim();
                                email = emailController.text.trim();
                                password = passwordController.text;
                              });
                              registration();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF007dff),
                              minimumSize: Size(350.w, 45.h),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.w))),
                          child: Text(
                            "REGISTER",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.sp),
                          )),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5.h),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already Have an account?"),
                    SizedBox(width: 5.w),
                    InkWell(
                        child: Text("Login here",
                            style: TextStyle(color: Colors.blueAccent)),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        })
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
