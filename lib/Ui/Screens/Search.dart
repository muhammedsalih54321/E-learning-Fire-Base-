import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning_firebase/Ui/Components/Searchcontainer.dart';

import 'package:flutter/material.dart';

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
                                  child: Searchcontainer(
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
                                          .toString(),
                                      star: double.parse(snapshot
                                          .data!.docs[index]["rating"]
                                          .toString()),
                                      index: index,
                                      id: snapshot.data!.docs[index]["id"]
                                          .toString(),
                                      videoUrl: snapshot.data!.docs[index]["videos"]));
                            } else if (name.toLowerCase().contains(
                                search.text.toLowerCase().toLowerCase())) {
                              return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Searchcontainer(
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
                                          .toString(),
                                      star: double.parse(snapshot
                                          .data!.docs[index]["rating"]
                                          .toString()),
                                      index: index,
                                      id: snapshot.data!.docs[index]["id"]
                                          .toString(),
                                      videoUrl: snapshot.data!.docs[index]["videos"]));
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
