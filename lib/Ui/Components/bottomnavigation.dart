import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning_firebase/Ui/Screens/Chat.dart';
import 'package:e_learning_firebase/Ui/Screens/Course.dart';
import 'package:e_learning_firebase/Ui/Screens/Home/Home.dart';
import 'package:e_learning_firebase/Ui/Screens/Profile/Profile.dart';
import 'package:e_learning_firebase/Ui/Screens/Search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Bottomnavigation extends StatefulWidget {
  const Bottomnavigation({super.key});

  @override
  State<Bottomnavigation> createState() => _BottomnavigationState();
}

class _BottomnavigationState extends State<Bottomnavigation> {
  final firestore1 = FirebaseFirestore.instance.collection('Users').snapshots();
  final auth = FirebaseAuth.instance;
  int index = 0;
  Future<void> getUser(AsyncSnapshot<QuerySnapshot> snapshot) async {
    final firestoreCollection = FirebaseFirestore.instance.collection('Users');

    // Get all documents in the subcollection
    QuerySnapshot querySnapshot = await firestoreCollection.get();

    // Get data from docs and convert map to List

    for (int i = 0; i < querySnapshot.docs.length; i++) {
      if (querySnapshot.docs[i]['id'].toString() ==
          auth.currentUser!.uid.toString()) {
        setState(() {
          index = i;
        });
      } else {}
    }
  }

  final screen = [Home(), Course(), Search(), Chat(), Profile()];
  int currentindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 71.h,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r))),
        child: BottomNavigationBar(
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Color(0xFF477B72),
            selectedItemColor: Colors.orange,
            showUnselectedLabels: false,
            showSelectedLabels: false,
            unselectedItemColor: Colors.black,
            currentIndex: currentindex,
            onTap: (index) {
              setState(() {
                currentindex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Column(
                  children: [
                    Icon(Icons.home_filled,
                        size: 28.sp,
                        color:
                            currentindex == 0 ? Colors.orange : Colors.black),
                    SizedBox(
                      height: 5.h,
                    ),
                    currentindex == 0
                        ? Container(
                            height: 2.h,
                            width: 20.w,
                            color: Colors.yellow,
                          )
                        : SizedBox()
                  ],
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                  icon: Column(
                    children: [
                      Icon(
                        Icons.menu_book_rounded,
                        size: 28.sp,
                        color: currentindex == 1 ? Colors.orange : Colors.black,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      currentindex == 1
                          ? Container(
                              height: 2.h,
                              width: 20.w,
                              color: Colors.yellow,
                            )
                          : SizedBox()
                    ],
                  ),
                  label: 'Wishlist'),
              BottomNavigationBarItem(
                  icon: Column(
                    children: [
                      Icon(Icons.search,
                          size: 28.sp,
                          color:
                              currentindex == 2 ? Colors.orange : Colors.black),
                      SizedBox(
                        height: 5.h,
                      ),
                      currentindex == 2
                          ? Container(
                              height: 2.h,
                              width: 20.w,
                              color: Colors.yellow,
                            )
                          : SizedBox()
                    ],
                  ),
                  label: 'Catogories'),
              BottomNavigationBarItem(
                  icon: Column(
                    children: [
                      Icon(CupertinoIcons.chat_bubble,
                          size: 28.sp,
                          color:
                              currentindex == 3 ? Colors.orange : Colors.black),
                      SizedBox(
                        height: 5.h,
                      ),
                      currentindex == 3
                          ? Container(
                              height: 2.h,
                              width: 20.w,
                              color: Colors.yellow,
                            )
                          : SizedBox()
                    ],
                  ),
                  label: 'Account'),
              BottomNavigationBarItem(
                  icon: Column(
                    children: [
                      StreamBuilder<QuerySnapshot>(
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
                              getUser(snapshot);
                              return Container(
                                  width: 24.w,
                                  height: 24.h,
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
//
                                      side: BorderSide(
                                        width: 1.50.w,
                                        strokeAlign:
                                            BorderSide.strokeAlignOutside,
                                        color: Color(0xFFF6C354),
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(83.64.r),
                                    ),
                                  ),
                                  child: snapshot
                                          .data!.docs[index]["Profile"].isEmpty
                                      ? Center(
                                          child: Icon(Icons.person),
                                        )
                                      : ClipOval(
                                          child: Image.network(
                                          snapshot.data!.docs[index]["Profile"]
                                              .toString(),
                                          fit: BoxFit.cover,
                                        ))
                                        
                                        );
                            } else {
                              return SizedBox();
                            }
                          }),
                      SizedBox(
                        height: 5.h,
                      ),
                      currentindex == 4
                          ? Container(
                              height: 2.h,
                              width: 20.w,
                              color: Colors.yellow,
                            )
                          : SizedBox()
                    ],
                  ),
                  label: 'Cart'),
            ]),
      ),
      body: screen[currentindex],
    );
  }
}
//  decoration: ShapeDecoration(
//                               color: Color(0xFF477B72),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(83.64.r),
//                               ),
//                             ),
//                             child: snapshot.data!.docs[index]["Profile"].isEmpty
//                                 ? Center(
//                                     child: Icon(Icons.person),
//                                   )
//                                 : ClipOval(
//                                     child: Image.network(
//                                     snapshot.data!.docs[index]["Profile"]
//                                         .toString(),
//                                     fit: BoxFit.cover,
//                                   ))),
