
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Home_container extends StatelessWidget {
  const Home_container({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
              height: 209.h,
              child: Container(
             
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 30),
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
                                  color: Colors.cyan),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Row(
                              children: [
                                Text(
                                  '4.5',
                                  style: GoogleFonts.plusJakartaSans(
                                    color: Color(0xFF060302),
                                    fontSize: 11.40.sp,
                                    fontWeight: FontWeight.w600,
                                    height: 0.10,
                                  ),
                                ),
                                RatingBar.builder(
                                  itemSize: 15,
                                  initialRating: 4,
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
                              'UI/UX Design',
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
                                  'Stephen Moris',
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
                              '\$14.50',
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
                  },
                ),
              ),
            );
  }
}