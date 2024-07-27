import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning_firebase/Ui/Screens/Home/Details1.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final Serachcollection =
      FirebaseFirestore.instance.collection('StudentAlsoSearch').snapshots();
  final Serachcollection2 =
      FirebaseFirestore.instance.collection('TopCoursesinIT').snapshots();
  final search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: TextFormField(
                textInputAction: TextInputAction.done,
                onChanged: (value) {
                  setState(() {});
                },
                controller: search,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    suffixIcon: Icon(Icons.search_rounded),
                    filled: true,
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide:
                            BorderSide(width: 1.w, color: Color(0xFFDDDDDD))),
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide:
                            BorderSide(width: 1.w, color: Color(0xFFDDDDDD))),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide:
                          BorderSide(width: 1.w, color: Color(0xFFDDDDDD)),
                    ),
                    hintText: 'Serch ...',
                    hintStyle: GoogleFonts.poppins(
                      color: Color(0xFF7C7C7C),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                    )),
                validator: (email) {
                  if (email!.isEmpty) {
                    return 'Search Here';
                  }
                  return null;
                },
              ),
            ),
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: Serachcollection,
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
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            final name = snapshot
                                .data!.docs[index]["Course name"]
                                .toString();
                            if (search.text.isEmpty) {
                              return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: GestureDetector(
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => Details1(
                                                  index: index,
                                                  img: snapshot.data!
                                                      .docs[index]["Thumnail"]
                                                      .toString(),
                                                  rating: snapshot.data!
                                                      .docs[index]["rating"]
                                                      .toString(),
                                                  Coursename: snapshot
                                                      .data!
                                                      .docs[index]
                                                          ["Course name"]
                                                      .toString(),
                                                  name: snapshot
                                                      .data!.docs[index]["name"]
                                                      .toString(),
                                                  Price: snapshot.data!
                                                      .docs[index]["Price"]
                                                      .toString(),
                                                  star: double.parse(snapshot
                                                      .data!
                                                      .docs[index]["rating"]
                                                      .toString()),
                                                  videoUrl: snapshot.data!
                                                      .docs[index]["videos"],
                                                  id: snapshot
                                                      .data!.docs[index]["id"]
                                                      .toString(),
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
                                            child: Image.network(snapshot
                                                .data!.docs[index]["Thumnail"]
                                                .toString()),
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
                                                  snapshot
                                                      .data!
                                                      .docs[index]
                                                          ["Course name"]
                                                      .toString(),
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
                                                      snapshot.data!
                                                          .docs[index]["rating"]
                                                          .toString(),
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
                                                          double.parse(snapshot
                                                              .data!
                                                              .docs[index]
                                                                  ["rating"]
                                                              .toString()),
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
                                                        snapshot.data!
                                                            .docs[index]["name"]
                                                            .toString(),
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
                                                  snapshot.data!
                                                      .docs[index]["Price"]
                                                      .toString(),
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
                                  ));
                            } else if (name.toLowerCase().contains(
                                search.text.toLowerCase().toLowerCase())) {
                              return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: GestureDetector(
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => Details1(
                                                  index: index,
                                                  img: snapshot.data!
                                                      .docs[index]["Thumnail"]
                                                      .toString(),
                                                  rating: snapshot.data!
                                                      .docs[index]["rating"]
                                                      .toString(),
                                                  Coursename: snapshot
                                                      .data!
                                                      .docs[index]
                                                          ["Course name"]
                                                      .toString(),
                                                  name: snapshot
                                                      .data!.docs[index]["name"]
                                                      .toString(),
                                                  Price: snapshot.data!
                                                      .docs[index]["Price"]
                                                      .toString(),
                                                  star: double.parse(snapshot
                                                      .data!
                                                      .docs[index]["rating"]
                                                      .toString()),
                                                  videoUrl: snapshot.data!
                                                      .docs[index]["videos"],
                                                  id: snapshot
                                                      .data!.docs[index]["id"]
                                                      .toString(),
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
                                            child: Image.network(snapshot
                                                .data!.docs[index]["Thumnail"]
                                                .toString()),
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
                                                  snapshot
                                                      .data!
                                                      .docs[index]
                                                          ["Course name"]
                                                      .toString(),
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
                                                      snapshot.data!
                                                          .docs[index]["rating"]
                                                          .toString(),
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
                                                          double.parse(snapshot
                                                              .data!
                                                              .docs[index]
                                                                  ["rating"]
                                                              .toString()),
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
                                                        snapshot.data!
                                                            .docs[index]["name"]
                                                            .toString(),
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
                                                  snapshot.data!
                                                      .docs[index]["Price"]
                                                      .toString(),
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
                                  ));
                            } else {
                              return Container();
                            }
                          },
                        );
                      } else {
                        return SizedBox();
                      }
                    })),
           
          ],
        ),
      ),
    );
  }
}
