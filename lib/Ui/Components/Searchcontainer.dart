import 'package:e_learning_firebase/Ui/Screens/Home/Details1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Searchcontainer extends StatelessWidget {
   final String img;
  final String rating;
  final String Coursename;
  final String name;
  final String Price;
  final double star;
  final int index;
  final String id;
  final List<dynamic> videoUrl;
  const Searchcontainer({super.key, required this.img, required this.rating, required this.Coursename, required this.name, required this.Price, required this.star, required this.index, required this.id, required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => Details1(
                                                index: index, img: img, rating: rating, Coursename: Coursename, name: name, Price: Price, star: star, videoUrl:videoUrl, id:id,
                                                ))),
                                    child: Container(
                                      width: 158.72.h,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 170.w,
                                            height: 115.h,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.r),
                                            ),
                                            child: Image.network(img),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                Text(
                                                  Coursename,
                                                  style: GoogleFonts
                                                      .plusJakartaSans(
                                                    color: Color(0xFF060302),
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.w600,
                                                    height: 0,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 8.h,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                     Price,
                                                      style: GoogleFonts
                                                          .plusJakartaSans(
                                                        color:
                                                            Color(0xFF060302),
                                                        fontSize: 11.40.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        height: 0.10,
                                                      ),
                                                    ),
                                                    RatingBar.builder(
                                                      itemSize: 15,
                                                      initialRating:
                                                          star,
                                                      minRating: 1,
                                                      direction:
                                                          Axis.horizontal,
                                                      allowHalfRating: true,
                                                      itemCount: 5,
                                                      itemBuilder:
                                                          (context, _) => Icon(
                                                        Icons.star,
                                                        color:
                                                            Color(0xFF477B72),
                                                      ),
                                                      onRatingUpdate: (rating) {
                                                        print(rating);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 3.h,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(Icons.person_outline),
                                                    Text(
                                                        name,
                                                        style: GoogleFonts
                                                            .plusJakartaSans(
                                                          color:
                                                              Color(0xFF060302),
                                                          fontSize: 14.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          height: 0,
                                                          letterSpacing: -0.14,
                                                        )),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 13.h,
                                                ),
                                                Text(
                                                 Price,
                                                  style: GoogleFonts
                                                      .plusJakartaSans(
                                                    color: Color(0xFF477B72),
                                                    fontSize: 17.54.sp,
                                                    fontWeight: FontWeight.w800,
                                                    height: 0.06,
                                                    letterSpacing: -0.18,
                                                  ),
                                                ),
                                              ]),
                                        ],
                                      ),
                                    ),
                                  );
  }
}