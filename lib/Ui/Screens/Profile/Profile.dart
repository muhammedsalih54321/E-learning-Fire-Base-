

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning_firebase/Ui/Components/Profilepagecontainer.dart';
import 'package:e_learning_firebase/Ui/Components/Toastmessage.dart';
import 'package:e_learning_firebase/Ui/Screens/Auth/Sign%20in.dart';
import 'package:e_learning_firebase/Ui/Screens/Profile/Edit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


class Profile extends StatefulWidget {
  const Profile({
    super.key,
  });

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final firestore1 = FirebaseFirestore.instance.collection('Users').snapshots();
  final auth = FirebaseAuth.instance;


  int index = 0;
  Future<void> getUser(AsyncSnapshot<QuerySnapshot> snapshot) async {
    final firestoreCollection = FirebaseFirestore.instance.collection('Users');

    // Get all documents in the subcollection
    QuerySnapshot querySnapshot = await firestoreCollection.get();

    // Get data from docs and convert map to List

    for (int i = 0; i < querySnapshot.docs.length; i++) {
      if (querySnapshot.docs[i]['id'].toString() ==
          auth.currentUser!.uid.toString()) {
        setState(() {
          index = i;
        });
      } else {
        print("item not found");
      }
    }
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
            child: Column(
          children: [
            SizedBox(
              height: 35.h,
            ),
            StreamBuilder<QuerySnapshot>(
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
                    getUser(snapshot);

                    return Container(
                      height: 200.h,
                      width: double.infinity.w,
                      child: Column(
                        children: [
                          Container(
                              height: 115.h,
                              width: 115.w,
                              decoration: ShapeDecoration(
                                color: Color(0xFF477B72),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(83.64.r),
                                ),
                              ),
                              child:  Center(
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.white,
                                      ),
                                    ),),
                          SizedBox(
                            height: 8.h,
                          ),
                          Text(
                            auth.currentUser!.uid.toString() ==
                                    snapshot.data!.docs[index]["id"].toString()
                                ? snapshot.data!.docs[index]["FullName"]
                                    .toString()
                                : "",
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
                            auth.currentUser!.uid.toString() ==
                                    snapshot.data!.docs[index]["id"].toString()
                                ? snapshot.data!.docs[index]["email"].toString()
                                : "",
                            style: GoogleFonts.plusJakartaSans(
                              color: Color(0xFF545454),
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                }),
            SizedBox(
              height: 50.h,
            ),
            GestureDetector(
                onTap: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => Edit())),
                child: Profilepagecontainer(name: 'Edit')),
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
        )));
  }
}
