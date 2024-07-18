import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:e_learning_firebase/Ui/Components/course%20container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Course extends StatefulWidget {
  const Course({super.key});

  @override
  State<Course> createState() => _CourseState();
}

final auth = FirebaseAuth.instance;
final firestore2 = FirebaseFirestore.instance
    .collection('Users')
    .doc(auth.currentUser!.uid)
    .collection('savedcourse')
    .snapshots();
final ref = FirebaseFirestore.instance
    .collection('Users')
    .doc(auth.currentUser!.uid)
    .collection('savedcourse');

class _CourseState extends State<Course> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            'Courses',
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: StreamBuilder<QuerySnapshot>(
              stream: firestore2,
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
                  return GridView.builder(
                      itemCount: snapshot.data!.docs.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 320 / 400,
                          crossAxisSpacing: 6,
                          mainAxisSpacing: 10),
                      itemBuilder: (context, index) {
                        return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: GestureDetector(
                              // onTap: () => Navigator.push(context,MaterialPageRoute(builder: (_)=>Details1(index: index))),

                              child: Container(
                                width: 158.72.h,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 170.w,
                                      height: 105.h,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                      ),
                                      child: Image.network(
                                        snapshot.data!.docs[index]["Thumnail"]
                                            .toString(),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          snapshot.data!.docs[index]["rating"]
                                              .toString(),
                                          style: GoogleFonts.plusJakartaSans(
                                            color: Color(0xFF060302),
                                            fontSize: 11.40.sp,
                                            fontWeight: FontWeight.w600,
                                            height: 0.10,
                                          ),
                                        ),
                                        RatingBar.builder(
                                          itemSize: 15,
                                          initialRating: double.parse(snapshot
                                              .data!.docs[index]["rating"]
                                              .toString()),
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: Color(0xFF477B72),
                                          ),
                                          onRatingUpdate: (rating) {
                                            print(rating);
                                          },
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    Text(
                                      snapshot.data!.docs[index]["Course name"]
                                          .toString(),
                                      style: GoogleFonts.plusJakartaSans(
                                        color: Color(0xFF060302),
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                        height: 0,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.person_outline),
                                        Text(
                                          snapshot.data!.docs[index]["name"]
                                              .toString(),
                                          style: GoogleFonts.plusJakartaSans(
                                            color: Color(0xFF060302),
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                            letterSpacing: -0.14,
                                          ),
                                        ),
                                      
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          snapshot.data!.docs[index]["Price"]
                                              .toString(),
                                          style: GoogleFonts.plusJakartaSans(
                                            color: Color(0xFF477B72),
                                            fontSize: 17.54.sp,
                                            fontWeight: FontWeight.w800,
                                            height: 0.06,
                                            letterSpacing: -0.18,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                               ref.doc(snapshot.data!.docs[index]["id"].toString(),).delete();
                                          },
                                          child: Icon(Icons.delete,color: Colors.red,))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ));
                      });
                } else {
                  return SizedBox();
                }
              }),
        ));
  }
}



 //  Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [

      //   Center(child: Image.asset('assets/images/Frame.png'),)
      // ],),