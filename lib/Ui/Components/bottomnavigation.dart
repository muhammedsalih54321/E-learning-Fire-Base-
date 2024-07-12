import 'package:e_learning_firebase/Ui/Screens/Chat.dart';
import 'package:e_learning_firebase/Ui/Screens/Course.dart';
import 'package:e_learning_firebase/Ui/Screens/Home.dart';
import 'package:e_learning_firebase/Ui/Screens/Profile.dart';
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
    final screen = [
    Home(),
    Course(),
    Search(),
    Chat(),
    Profile()
  ];
  int currentindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      bottomNavigationBar: Container(
        height: 62.h,
        width: double.infinity,
      
        decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r),topRight: Radius.circular(20.r))),
        child: BottomNavigationBar(
          
                elevation: 0,
                type: BottomNavigationBarType.fixed,
            backgroundColor:Color(0xFF477B72),
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
              
                icon: Icon(Icons.home_filled,size: 28.sp,
                    color: currentindex == 0 ? Colors.orange : Colors.black),
                label: 'Home',
              ),
              BottomNavigationBarItem(
        
                  icon: Icon(
                    Icons.menu_book_rounded,size: 28.sp,
                    color: currentindex == 1 ? Colors.orange : Colors.black,
                  ),
                  label: 'Wishlist'),
              BottomNavigationBarItem(
               
                  icon: Icon(Icons.search,size: 28.sp,
                      color: currentindex == 2 ? Colors.orange : Colors.black),
                  label: 'Catogories'),
              BottomNavigationBarItem(
                  
                  icon: Icon(CupertinoIcons.chat_bubble,size: 28.sp,
                      color: currentindex == 3 ? Colors.orange : Colors.black),
                  label: 'Account'),
              BottomNavigationBarItem(
             
                  icon: CircleAvatar(radius:13.r,backgroundColor: Colors.amber,),
                  label: 'Cart'),
            ]),
      ),
      body: screen[currentindex],
    );
  }
}