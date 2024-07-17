
import 'package:e_learning_firebase/Ui/Screens/Home/section1/Details1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Home_container1 extends StatelessWidget {
  final String img;
  final String rating;
  final String Coursename;
  final String name;
  final String Price;
  final double star;
  final int index;
  const Home_container1(
      {super.key,
      required this.img,
      required this.rating,
      required this.Coursename,
      required this.name,
      required this.Price, required this.star, required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,MaterialPageRoute(builder: (_)=>Details1(index: index))),
      child: Container(
      
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
            Row(
              children: [
                Text(
                  rating,
                  style: GoogleFonts.plusJakartaSans(
                    color: Color(0xFF060302),
                    fontSize: 11.40.sp,
                    fontWeight: FontWeight.w600,
                    height: 0.10,
                  ),
                ),
                RatingBar.builder(
                  itemSize: 15,
                  initialRating: star,
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
              Coursename,
              style: GoogleFonts.plusJakartaSans(
                color: Color(0xFF060302),
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                height: 0,
              ),
            ),
            SizedBox(
              height: 6.h,
            ),
            Row(
              children: [
                Icon(Icons.person_outline),
                Text(
                  name,
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
              height: 13.h,
            ),
            Text(
              Price,
              style: GoogleFonts.plusJakartaSans(
                color: Color(0xFF477B72),
                fontSize: 17.54.sp,
                fontWeight: FontWeight.w800,
                height: 0.06,
                letterSpacing: -0.18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
