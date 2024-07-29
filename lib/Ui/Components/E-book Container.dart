import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class E_bookcontainer extends StatelessWidget {
  final String img;
  final String rating;
  final String title;

  final String description;

  final int index;

 E_bookcontainer(
      {super.key,
      required this.img,
      required this.rating,
      required this.title,
      required this.index,
      required this.description,});
      final firestorecollection = FirebaseFirestore.instance.collection('Users');
      FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 158.72.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 170.w,
            height: 105.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Image.network(img),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              color: Color(0xFF060302),
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              height: 0,
            ),
          ),
          Text(
            description,
            style: GoogleFonts.plusJakartaSans(
              color: Colors.grey,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              height: 0,
              letterSpacing: -0.14,
            ),
          ),
          Row(
            children: [
              Text(
                'Rating: ',
                style: GoogleFonts.plusJakartaSans(
                  color: Color(0xFF060302),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                rating,
                style: GoogleFonts.plusJakartaSans(
                  color: Color(0xFF060302),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                width: 40.h,
              ),
              IconButton(
                  onPressed: () {
               
                  },
                  icon: Icon(Icons.add_shopping_cart_outlined))
            ],
          ),
        ],
      ),
    );
  }
}
