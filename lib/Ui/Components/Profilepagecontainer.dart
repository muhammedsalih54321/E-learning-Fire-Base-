
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Profilepagecontainer extends StatefulWidget {
  final String name;
  const Profilepagecontainer({super.key, required this.name});

  @override
  State<Profilepagecontainer> createState() => _ProfilepagecontainerState();
}

class _ProfilepagecontainerState extends State<Profilepagecontainer> {
  @override
  Widget build(BuildContext context) {
    return   Container(
              width: 341.w,
              height: 44.h,
              padding: const EdgeInsets.all(10),
              decoration: ShapeDecoration(
                color: Color(0xFFC6D6D3),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.r)),
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.name,
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.black,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      height: 0.08,
                      letterSpacing: 0.15,
                    ),
                  ),
                  Icon(Icons.keyboard_double_arrow_right)
                ],
              ),
            );
  }
}