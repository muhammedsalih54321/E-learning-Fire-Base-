import 'dart:async';

import 'package:e_learning_firebase/Ui/Components/bottomnavigation.dart';
import 'package:e_learning_firebase/Ui/Screens/Auth/Sign%20in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  void islogin() {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user != null) {
      Timer(
          Duration(seconds: 3),
          () => Navigator.push(
              context, MaterialPageRoute(builder: (_) => Sign_in())));
    } else {
      Timer(
          Duration(seconds: 3),
          () => Navigator.push(
              context, MaterialPageRoute(builder: (_) => Bottomnavigation())));
    }
  }

  @override
  void initState() {
    super.initState();
    islogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                    width: 239.w,
                    height: 106.h,
                    child: Image.asset("assets/images/img1.png")),
                Positioned(
                  left: -40.w,
                  top: -22.h,
                  child: Container(
                      width: 77.80.w,
                      height: 77.80.h,
                      child: Image.asset("assets/images/img2.png")),
                )
              ],
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
        ],
      ),
    );
  }
}
