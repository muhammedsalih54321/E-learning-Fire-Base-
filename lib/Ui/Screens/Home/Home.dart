import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning_firebase/Ui/Components/Home%20Container1.dart';
import 'package:e_learning_firebase/Ui/Components/Home%20Container2.dart';
import 'package:e_learning_firebase/Ui/Screens/Home/section1/StudentAlso.dart';
import 'package:e_learning_firebase/Ui/Screens/Home/section2/Topcourses.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final firestore1 =
      FirebaseFirestore.instance.collection('StudentAlsoSearch').snapshots();
  final firestore2 =
      FirebaseFirestore.instance.collection('TopCoursesinIT').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Text(
              'Welcome',
              style: GoogleFonts.plusJakartaSans(
                color: Color(0xFF1D1B20),
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                height: 0.03,
                letterSpacing: 0.24,
              ),
            ),
            Text(
              ' Khan',
              style: GoogleFonts.plusJakartaSans(
                color: Color(0xFF477B72),
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                height: 0.03,
                letterSpacing: 0.24,
              ),
            ),
          ],
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Categories',
                    style: GoogleFonts.plusJakartaSans(
                      color: Color(0xFF1D1B20),
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      height: 0.06,
                      letterSpacing: 0.18,
                    ),
                  ),
                  Text(
                    'See All',
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.black,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      height: 0.06,
                      letterSpacing: 0.18,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 93.w,
                    height: 37.h,
                    decoration: ShapeDecoration(
                        color: Color(0xFFC6D6D3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(42.r),
                        )),
                    child: Center(
                      child: Text(
                        'Bussiness',
                        style: GoogleFonts.plusJakartaSans(
                          color: Color(0xFF1D1B20),
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.15,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 62.w,
                    height: 37.h,
                    decoration: ShapeDecoration(
                        color: Color(0xFFC6D6D3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(42.r),
                        )),
                    child: Center(
                      child: Text(
                        'UI/UX',
                        style: GoogleFonts.plusJakartaSans(
                          color: Color(0xFF1D1B20),
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.15,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 178.w,
                    height: 37.h,
                    decoration: ShapeDecoration(
                        color: Color(0xFFC6D6D3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(42.r),
                        )),
                    child: Center(
                      child: Text(
                        'Software Engineering',
                        style: GoogleFonts.plusJakartaSans(
                          color: Color(0xFF1D1B20),
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.15,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Students Also Search for',
                    style: GoogleFonts.plusJakartaSans(
                      color: Color(0xFF1D1B20),
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      height: 0.06,
                      letterSpacing: 0.18,
                    ),
                  ),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>Studentalso()));
                  }, child: Text(
                    'See All',
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.black,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      height: 0.06,
                      letterSpacing: 0.18,
                    ),
                  ),)
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                height: 209.h,
                child: Container(
                    child: StreamBuilder<QuerySnapshot>(
                        stream: firestore1,
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 30),
                                  child: Home_container1(
                                      img: snapshot.data!.docs[index]["Thumnail"]
                                          .toString(),
                                      rating: snapshot.data!.docs[index]["rating"]
                                          .toString(),
                                      Coursename: snapshot
                                          .data!.docs[index]["Course name"]
                                          .toString(),
                                      name: snapshot.data!.docs[index]["name"]
                                          .toString(),
                                      Price: snapshot.data!.docs[index]["Price"]
                                          .toString(), star: double.parse(snapshot.data!.docs[index]["rating"]
                                          .toString()), index: index,),
                                );
                              },
                            );
                          } else {
                            return SizedBox();
                          }
                        })),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Top Courses in IT',
                    style: GoogleFonts.plusJakartaSans(
                      color: Color(0xFF1D1B20),
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      height: 0.06,
                      letterSpacing: 0.18,
                    ),
                  ),
                 TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>Topcourses()));
                 }, child: Text(
                    'See All',
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.black,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      height: 0.06,
                      letterSpacing: 0.18,
                    ),
                  ),)
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                height: 209.h,
                child: Container(
                    child: StreamBuilder<QuerySnapshot>(
                        stream: firestore2,
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 30),
                                  child: Home_container2(
                                      img: snapshot.data!.docs[index]["Thumnail"]
                                          .toString(),
                                      rating: snapshot.data!.docs[index]["rating"]
                                          .toString(),
                                      Coursename: snapshot
                                          .data!.docs[index]["Course name"]
                                          .toString(),
                                      name: snapshot.data!.docs[index]["name"]
                                          .toString(),
                                      Price: snapshot.data!.docs[index]["Price"]
                                          .toString(), star:  double.parse(snapshot.data!.docs[index]["rating"]
                                          .toString()), index: index,),
                                );
                              },
                            );
                          } else {
                            return SizedBox();
                          }
                        })),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
