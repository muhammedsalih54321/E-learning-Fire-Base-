import 'package:e_learning_firebase/Ui/Components/Profilepagecontainer.dart';
import 'package:e_learning_firebase/Ui/Components/Toastmessage.dart';
import 'package:e_learning_firebase/Ui/Screens/Auth/Sign%20in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'Profile',
          style: GoogleFonts.plusJakartaSans(
            color: Color(0xFF1D1B20),
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            height: 0.05,
            letterSpacing: 0.20,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child:
                IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart)),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  radius: 63.r,
                  backgroundColor: Colors.black,
                ),
                Positioned(
                  top: 85.h,
                  left: 85.w,
                  child: Container(
                    width: 36.w,
                    height: 36.h,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          width: 3.w,
                          strokeAlign: BorderSide.strokeAlignOutside,
                          color: Color(0xFF477B72),
                        ),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.photo_size_select_actual_outlined,
                        color: const Color.fromARGB(255, 87, 86, 86),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              'Muhammed Rafey',
              style: GoogleFonts.plusJakartaSans(
                color: Color(0xFF202244),
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              'muhammadrafey999@gmail.com',
              style: GoogleFonts.plusJakartaSans(
                color: Color(0xFF545454),
                fontSize: 13.sp,
                fontWeight: FontWeight.w700,
                height: 0,
              ),
            ),
            SizedBox(
              height: 60.h,
            ),
            Profilepagecontainer(name: 'Edit'),
            SizedBox(
              height: 20.h,
            ),
            Profilepagecontainer(name: 'Setting'),
            SizedBox(
              height: 20.h,
            ),
            Profilepagecontainer(name: 'Achivements'),
            SizedBox(
              height: 20.h,
            ),
            Profilepagecontainer(name: 'About Us'),
            SizedBox(
              height: 20.h,
            ),
            GestureDetector(
                onTap: () {
                  auth
                      .signOut()
                      .then(
                        (value) => {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => Sign_in()))
                        },
                      )
                      .onError(
                        (error, stackTrace) => ToastMessage()
                            .toastmessage(message: error.toString()),
                      );
                },
                child: Profilepagecontainer(name: 'Logout')),
            SizedBox(
              height: 20.h,
            ),
          ],
        ),
      ),
    );
  }
}
