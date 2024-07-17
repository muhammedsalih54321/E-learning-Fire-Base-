import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning_firebase/Ui/Components/Profilepagecontainer.dart';
import 'package:e_learning_firebase/Ui/Components/Toastmessage.dart';
import 'package:e_learning_firebase/Ui/Screens/Auth/Sign%20in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
 
  const Profile({super.key,});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final firestore1 = FirebaseFirestore.instance.collection('Users').snapshots();
  final auth = FirebaseAuth.instance;
  final Picker = ImagePicker();
  File? image;
  Future<void> getimage() async {
    final PickedFile =
        await Picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (PickedFile != null) {
        image = File(PickedFile.path);
      } else {
        print('Not image');
      }
    });
  }

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
          child: StreamBuilder<QuerySnapshot>(
              stream: firestore1,
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text('error'),
                  );
                }
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 35.h,
                      ),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            height: 115.h,
                            width: 115.w,
                            decoration: ShapeDecoration(
                              color: Color(0xFF477B72),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(83.64.r),
                              ),
                            ),
                            child:  image != null
                      ? Image.file(image!.absolute)
                      : Center(
                          child: SizedBox()
                        )
            
                          ),
                          Positioned(
                            top: 80.h,
                            left: 80.w,
                            child: GestureDetector(
                              onTap: () {
                                getimage();
                              },
                              child: Container(
                                width: 36.w,
                                height: 36.h,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 3.w,
                                      strokeAlign:
                                          BorderSide.strokeAlignOutside,
                                      color: Color(0xFF477B72),
                                    ),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.photo_size_select_actual_outlined,
                                    color:
                                        const Color.fromARGB(255, 87, 86, 86),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(
                        snapshot.data!.docs[0]["FullName"].toString(),
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
                        snapshot.data!.docs[0]["email"].toString(),
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
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => Sign_in()))
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
                  );
                } else {
                  return SizedBox();
                }
              })),
    );
  }
}
