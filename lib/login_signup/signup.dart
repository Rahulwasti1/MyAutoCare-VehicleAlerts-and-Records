import 'package:automobile_datamanagement/User_Screen/home.dart';
import 'package:automobile_datamanagement/login_signup/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // Making variable to store the controller values
  String? name, email, password;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // It allows you to validate all the form fields at once
  final _formkey = GlobalKey<FormState>();

  registration() async {
    if (name == null && email == null && password == null) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email!, password: password!);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              "Registered Successfully",
              style: TextStyle(fontSize: 20),
            )));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => UserHome()));
      } on FirebaseException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text("Passowrd Provided is too weak",
                  style: TextStyle(fontSize: 20))));
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text("Account Already Exists",
                  style: TextStyle(fontSize: 20))));
        }
      }
    }
  }

  Widget customTextField(
      {required String hintText,
      required IconData icon,
      required TextEditingController mycontroller,
      required String name}) {
    return TextFormField(
      // After adding GlobalKey
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
                          name: "Password"),
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
