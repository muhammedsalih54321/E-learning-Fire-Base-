import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class Edit extends StatefulWidget {
  const Edit({super.key});

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  final Picker = ImagePicker();
  File? image;
  Future<void> getimage() async {
    final PickedFile =
        await Picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (PickedFile != null) {
        image = File(PickedFile.path);
      } else {
        print('Not image');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
       
        title: Text(
          'Edit Profile',
          style: GoogleFonts.plusJakartaSans(
            color: Color(0xFF1D1B20),
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            height: 0.05,
            letterSpacing: 0.20,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 35.h,
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                // CircleAvatar(radius: 50.r,backgroundImage: image != null
                //       ? Image.file(image!.absolute):
                // ),
                Container(
                  height: 115.h,
                  width: 115.w,
                  decoration: ShapeDecoration(
                    color: Color(0xFF477B72),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(83.64.r),
                    ),
                  ),
                  child: image != null
                      ? Image.file(image!.absolute)
                      : Center(child: SizedBox())
                ),
                Positioned(
                  top: 80.h,
                  left: 80.w,
                  child: GestureDetector(
                    onTap: () {
                      getimage();
                    },
                    child: Container(
                      width: 36.w,
                      height: 36.h,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 3.w,
                            strokeAlign: BorderSide.strokeAlignOutside,
                            color: Color(0xFF477B72),
                          ),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.photo_size_select_actual_outlined,
                          color: const Color.fromARGB(255, 87, 86, 86),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
