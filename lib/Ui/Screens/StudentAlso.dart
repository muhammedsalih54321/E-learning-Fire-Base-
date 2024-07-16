import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning_firebase/Ui/Components/Home%20Container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Studentalso extends StatefulWidget {
  const Studentalso({super.key});

  @override
  State<Studentalso> createState() => _StudentalsoState();
}

class _StudentalsoState extends State<Studentalso> {
  final firestore1 =
      FirebaseFirestore.instance.collection('StudentAlsoSearch').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Students Also Search for',
            style: GoogleFonts.plusJakartaSans(
              color: Color(0xFF1D1B20),
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              height: 0.06,
              letterSpacing: 0.18,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal:18),
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
                  return GridView.builder(
                      itemCount: snapshot.data!.docs.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 320 / 400,
                          crossAxisSpacing: 6,
                          mainAxisSpacing: 10),
                      itemBuilder: (context, index) { 
                           return  Padding(
                             padding: const EdgeInsets.symmetric(horizontal: 5),
                             child: Home_container(
                              
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
                                            .toString()),),
                           );
          
                      });
                } else {
                  return SizedBox();
                }
              }),
        ));
  }
}
