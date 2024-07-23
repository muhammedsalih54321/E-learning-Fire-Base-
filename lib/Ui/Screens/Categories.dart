import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning_firebase/Ui/Components/Home%20Container1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late ExpandedTileController _controller;

  void initState() {
    _controller = ExpandedTileController(isExpanded: true);
    super.initState();
  }

  final Categories =
      FirebaseFirestore.instance.collection('Categories').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Categories',
            style: GoogleFonts.plusJakartaSans(
              color: Color(0xFF1D1B20),
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              height: 0.05,
              letterSpacing: 0.20,
            ),
          ),
        ),
        body: Column(children: [
          StreamBuilder<QuerySnapshot>(
              stream: Categories,
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
                  return ExpandedTileList.separated(
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 5.h,
                      );
                    },
                    itemCount: snapshot.data!.docs.length,
                    maxOpened: 2,
                    reverse: true,
                    itemBuilder: (context, index, con) {
                      return ExpandedTile(
                        theme: const ExpandedTileThemeData(
                          headerColor: Color(0xFFC6D6D3),
                        ),
                        controller: con,
                        title:
                            Text(snapshot.data!.docs[index]["name"].toString()),
                        content: SizedBox(
                          height: 209.h,
                          child: Container(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  snapshot.data!.docs[index]["courses"].length,
                              itemBuilder:
                                  (BuildContext context, int position) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 30),
                                  child: GestureDetector(
                                    child: Container(
                                      width: 158.72.h,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 170.w,
                                            height: 105.h,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.r),
                                            ),
                                            child: Image.network(snapshot.data!.docs[index]["courses"][position]['Thumnail']
                                        .toString(),),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                              snapshot.data!.docs[index]["courses"][position]['rating']
                                        .toString(),
                                                style:
                                                    GoogleFonts.plusJakartaSans(
                                                  color: Color(0xFF060302),
                                                  fontSize: 11.40.sp,
                                                  fontWeight: FontWeight.w600,
                                                  height: 0.10,
                                                ),
                                              ),
                                              RatingBar.builder(
                                                itemSize: 15,
                                                initialRating: double.parse(snapshot.data!.docs[index]["courses"][position]['rating']
                                        .toString()),
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemBuilder: (context, _) =>
                                                    Icon(
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
                                           snapshot.data!.docs[index]["courses"][position]['Course name']
                                        .toString(),
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
                                                snapshot.data!.docs[index]["courses"][position]['name']
                                        .toString(),
                                                style:
                                                    GoogleFonts.plusJakartaSans(
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
                                           snapshot.data!.docs[index]["courses"][position]['Price']
                                        .toString(),
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
                                  ),
                                  // child: Home_container1(
                                  //   img: snapshot.data!.docs[index]["courses"][position]["Thumnail"]
                                  //       .toString(),
                                  //   rating: snapshot.data!.docs[index]["rating"][position]
                                  //       .toString(),
                                  //   Coursename: snapshot
                                  //       .data!.docs[index]["Course name"][position]
                                  //       .toString(),
                                  //   name: snapshot.data!.docs[index]["name"][position]
                                  //       .toString(),
                                  //   Price: snapshot.data!.docs[index]["Price"][position]
                                  //       .toString(),
                                  //   star: double.parse(snapshot
                                  //       .data!.docs[index]["rating"][position]
                                  //       .toString()),
                                  //   index: index,
                                  // ),
                                );
                              },
                            ),
                          ),
                        ),
                        onTap: () {
                          debugPrint("tapped!!");
                        },
                        onLongTap: () {
                          debugPrint("looooooooooong tapped!!");
                        },
                      );
                    },
                  );
                } else {
                  return SizedBox();
                }
              })
        ]));
  }
}
