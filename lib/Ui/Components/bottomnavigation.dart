import 'package:e_learning_firebase/Ui/Screens/Chat.dart';
import 'package:e_learning_firebase/Ui/Screens/Course.dart';
import 'package:e_learning_firebase/Ui/Screens/Home/Home.dart';
import 'package:e_learning_firebase/Ui/Screens/Profile/Profile.dart';
import 'package:e_learning_firebase/Ui/Screens/Search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Bottomnavigation extends StatefulWidget {
  const Bottomnavigation({super.key});

  @override
  State<Bottomnavigation> createState() => _BottomnavigationState();
}

class _BottomnavigationState extends State<Bottomnavigation> {
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
                      Container(
                        width: 24.w,
                        height: 24.h,
                        decoration: ShapeDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                "https://via.placeholder.com/24x24"),
                            fit: BoxFit.fill,
                          ),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1.50.w,
                              strokeAlign: BorderSide.strokeAlignOutside,
                              color: Color(0xFFF6C354),
                            ),
                            borderRadius: BorderRadius.circular(83.64.r),
                          ),
                        ),
                      ),
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
