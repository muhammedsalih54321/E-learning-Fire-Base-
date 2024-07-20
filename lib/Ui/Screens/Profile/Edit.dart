import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning_firebase/Ui/Components/Toastmessage.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Edit extends StatefulWidget {
  final String name;
  final int index;
  const Edit({
    super.key,
    required this.name,
    required this.index,
  });

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  final firestore = FirebaseFirestore.instance.collection('Users');
  final firestore1 = FirebaseFirestore.instance.collection('Users').snapshots();
  final auth = FirebaseAuth.instance;
  final updated = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool loading = false;
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
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: StreamBuilder(
              stream: firestore1,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                return SingleChildScrollView(
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
                              child: ClipOval(
                                child: image != null
                                    ? Image.file(
                                        image!.absolute,
                                        fit: BoxFit.cover,
                                      )
                                    : Center(child: SizedBox()),
                              )),
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
                                      strokeAlign:
                                          BorderSide.strokeAlignOutside,
                                      color: Color(0xFF477B72),
                                    ),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.photo_size_select_actual_outlined,
                                    color:
                                        const Color.fromARGB(255, 87, 86, 86),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 60.h,
                      ),
                      Row(
                        children: [
                          Text('Updated Name',
                              style: GoogleFonts.plusJakartaSans(
                                color: Colors.black,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                height: 0,
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: updated,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            filled: true,
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.w, color: Color(0xFFDDDDDD))),
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.w, color: Color(0xFFDDDDDD))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.w, color: Color(0xFFDDDDDD)),
                                borderRadius: BorderRadius.circular(5)),
                            hintStyle: GoogleFonts.poppins(
                              color: Color(0xFF7C7C7C),
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w400,
                              height: 0.10,
                            )),
                        validator: (Phone) {
                          if (Phone!.isEmpty) {
                            return 'Enter your Upated name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            loading == true;
                          });
                          final id =
                              DateTime.now().microsecondsSinceEpoch.toString();
                          firebase_storage.Reference ref = firebase_storage
                              .FirebaseStorage.instance
                              .ref('/foldername/' + id);
                          firebase_storage.UploadTask uploadTask =
                              ref.putFile(image!.absolute);
                          await Future.value(uploadTask).then(
                            (value) async {
                              var newurl = await ref.getDownloadURL();

                              firestore
                                  .doc(snapshot.data!.docs[widget.index]["id"]
                                      .toString())
                                  .update({
                                "FullName": updated.text.toString(),
                                "Profile": newurl.toString()
                              }).then(
                                (value) => {
                                  setState(() {
                                    loading = false;
                                  }),
                                  ToastMessage().toastmessage(
                                      message: 'Uploaded successfully'),
                                  updated.clear(),
                                  Navigator.pop(context),
                                  setState(() {
                                    image = null;
                                  })
                                },
                              );
                            },
                          );
                        },
                        child: Container(
                            width: 316.w,
                            height: 57.h,
                            padding: const EdgeInsets.symmetric(vertical: 17),
                            decoration: ShapeDecoration(
                              color: Color(0xD3F8C657),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                            ),
                            child: Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                loading
                                    ? CircularProgressIndicator()
                                    : Text(
                                        'UPDATED',
                                        style: GoogleFonts.plusJakartaSans(
                                          color: Colors.black,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w600,
                                          height: 0,
                                          letterSpacing: 0.36,
                                        ),
                                      )
                              ],
                            ))),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
