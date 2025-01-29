import 'package:automobile_datamanagement/login_signup/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  Widget customTextField({required String hintText, required IconData icon}) {
    return TextField(
      decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.w),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.w),
              borderSide: BorderSide(color: Colors.blue))),
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
                padding: EdgeInsets.all(30.w), // Use .w for width scaling
                child: Column(
                  children: [
                    customTextField(hintText: "Username", icon: Icons.person),
                    SizedBox(height: 13.h),
                    customTextField(hintText: "Email", icon: Icons.email),
                    SizedBox(height: 13.h),
                    customTextField(hintText: "Password", icon: Icons.lock),
                    SizedBox(height: 20.h),
                    ElevatedButton(
                        onPressed: () {},
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
