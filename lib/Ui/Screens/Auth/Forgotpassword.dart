import 'package:e_learning_firebase/Ui/Components/Toastmessage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Forgotpassword extends StatefulWidget {
  const Forgotpassword({super.key});

  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  final forgot = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 243, 242, 242),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Form(
                key: formKey,
                child: SafeArea(
                    child: Column(children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Text('Reset Password',
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.black,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w700,
                        height: 0,
                      )),
                  SizedBox(
                    height: 150.h,
                  ),
                  Row(
                    children: [
                      Text('Email',
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
                    controller: forgot,
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
                        hintText: 'email address',
                        hintStyle: GoogleFonts.poppins(
                          color: Color(0xFF7C7C7C),
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w400,
                          height: 0.10,
                        )),
                    validator: (email) {
                      if (email!.isEmpty ||
                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(email)) {
                        return 'Enter a valid email!';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        await auth
                            .sendPasswordResetEmail(
                                email: forgot.text.toString())
                            .then(
                              (value) => {
                                ToastMessage().toastmessage(
                                    message:
                                        'Send your email for  Recover password'),
                                Navigator.pop(context)
                              },
                            )
                            .onError(
                              (error, stackTrace) => ToastMessage()
                                  .toastmessage(message: error.toString()),
                            );
                      }
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
                            Text(
                              'SUBMIT',
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
                ])))));
  }
}
