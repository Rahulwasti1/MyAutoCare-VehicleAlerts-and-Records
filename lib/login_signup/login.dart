import 'package:automobile_datamanagement/login_signup/signup.dart';
import 'package:automobile_datamanagement/navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Widget customTextField(
      {required String hintText,
      required IconData icon,
      required String name,
      required TextEditingController mycontroller}) {
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
              borderSide: BorderSide(color: Colors.blue))),
    );
  }

  String email = "";
  String password = "";

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  userlogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => userNavBar()));
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "No User Found for that email",
              style: TextStyle(fontSize: 18),
            ),
          ),
        );
      } else if (e.code == "wrong-password") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "Wrong Password",
              style: TextStyle(fontSize: 18),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 50.h),
                Center(
                  child: Image.asset(
                    "assets/images/login.png",
                    height: 300.h,
                    width: 300.w,
                  ),
                ),
                Text("Welcome back!",
                    style: TextStyle(
                        fontSize: 25.sp, fontWeight: FontWeight.bold)),
                Text("Login to your existant account",
                    style: TextStyle(fontSize: 14.sp)),
                Padding(
                  padding: EdgeInsets.all(30.w), // Use .w for width scaling
                  child: Column(
                    children: [
                      customTextField(
                          name: "Email",
                          hintText: "Email",
                          icon: Icons.email,
                          mycontroller: emailController),
                      SizedBox(height: 13.h),
                      customTextField(
                          name: "Password",
                          hintText: "Password",
                          icon: Icons.lock,
                          mycontroller: passwordController),
                      SizedBox(height: 20.h),
                      ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                email = emailController.text;
                                password = passwordController.text;
                              });
                            }
                            userlogin();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF007dff),
                              minimumSize: Size(350.w, 45.h),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.w))),
                          child: Text(
                            "LOG IN",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15.sp),
                          ))
                    ],
                  ),
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?"),
                      SizedBox(width: 5.w),
                      InkWell(
                        child: Text("Sign up",
                            style: TextStyle(color: Colors.blueAccent)),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupPage()));
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
