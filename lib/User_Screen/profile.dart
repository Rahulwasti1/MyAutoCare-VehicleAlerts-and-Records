import 'package:automobile_datamanagement/login_signup/login.dart';
import 'package:automobile_datamanagement/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            color: Color(0xFF007dff),
            height: 280,
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
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          )),
                    ),
                    SizedBox(width: 110.w),
                    Text(
                      "Profile",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Image.asset(
                  "assets/images/profile.png",
                  width: 120,
                  height: 120,
                ),
              ],
            )),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(right: 280),
            child: Text(
              "Username",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: TextField(
              enabled: false,
              decoration: InputDecoration(hintText: "Bishal Shamra"),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(right: 315),
            child: Text(
              "Email",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: TextField(
              enabled: false,
              decoration: InputDecoration(hintText: "bishalsharma@gmail.com"),
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF007dff),
                    minimumSize: Size(350.w, 45.h),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.w))),
                child: Text(
                  "LOGOUT",
                  style: TextStyle(color: Colors.white, fontSize: 15.sp),
                )),
          )
        ],
      ),
    );
  }
}
