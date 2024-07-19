import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning_firebase/Ui/Components/Toastmessage.dart';
import 'package:e_learning_firebase/Ui/Components/bottomnavigation.dart';
import 'package:e_learning_firebase/Ui/Screens/Auth/Phone.dart';
import 'package:e_learning_firebase/Ui/Screens/Auth/Sign%20in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Sign_up extends StatefulWidget {
  const Sign_up({super.key});

  @override
  State<Sign_up> createState() => _Sign_upState();
}

class _Sign_upState extends State<Sign_up> {
  final name = TextEditingController();
  
  final email = TextEditingController();
  final password = TextEditingController();
  final Mobile = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool loading = false;
  final firestore = FirebaseFirestore.instance.collection('Users');
  var isobscure;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    isobscure = true;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 243, 242, 242),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Form(
            key: formKey,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Text('Sign up',
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.black,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w700,
                        height: 0,
                      )),
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    children: [
                      Text('Full Name',
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
                    controller: name,
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
                        hintText: 'Your Name',
                        hintStyle: GoogleFonts.poppins(
                          color: Color(0xFF7C7C7C),
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w400,
                          height: 0.10,
                        )),
                    validator: (email) {
                      if (email!.isEmpty) {
                        return 'Enter Your name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 25.h,
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
                    controller: email,
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
                    height: 25.h,
                  ),
                  Row(
                    children: [
                      Text('Password',
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
                    controller: password,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1.w, color: Color(0xFFDDDDDD))),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1.w, color: Color(0xFFDDDDDD))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1.w, color: Color(0xFFDDDDDD)),
                            borderRadius: BorderRadius.circular(5)),
                        hintText: 'Enter password  ',
                        hintStyle: GoogleFonts.poppins(
                          color: Color(0xFF7C7C7C),
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w400,
                          height: 0.10,
                        ),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isobscure = !isobscure;
                              });
                            },
                            icon: isobscure
                                ? Icon(
                                    Icons.visibility_outlined,
                                    color: Colors.black,
                                    size: 20,
                                  )
                                : Icon(
                                    Icons.visibility_off_outlined,
                                    color: Colors.black,
                                    size: 20,
                                  ))),
                    obscureText: isobscure,
                    validator: (password) {
                      if (password!.isEmpty || password.length < 6) {
                        return 'Enter a valid password!';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Row(
                    children: [
                      Text('Mobile Number',
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
                    keyboardType: TextInputType.number,
                    controller: Mobile,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      errorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.w, color: Color(0xFFDDDDDD))),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.w, color: Color(0xFFDDDDDD))),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1.w, color: Color(0xFFDDDDDD)),
                          borderRadius: BorderRadius.circular(5)),
                      hintText: 'Enter Mobile number  ',
                      hintStyle: GoogleFonts.poppins(
                        color: Color(0xFF7C7C7C),
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                        height: 0.10,
                      ),
                    ),
                   
                    validator: (password) {
                      if (password!.isEmpty || password.length < 10) {
                        return 'Enter your mobile number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          loading = true;
                        });

                        await auth
                            .createUserWithEmailAndPassword(
                                email: email.text.toString(),
                                password: password.text.toString())
                            .then(
                          (value) async {
                            firestore.doc(value.user!.uid.toString()).set({
                              "id": value.user!.uid.toString(),
                              "FullName": name.text.toString(),
                              "email": email.text.toString(),
                              "Phone": Mobile.text.toString(),
                              "Profile":"",
                            });

                            setState(() {
                              loading = false;
                            });
                            ToastMessage().toastmessage(message: 'Succesfull');
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>Bottomnavigation()));
                          },
                        ).onError(
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
                            loading
                                ? CircularProgressIndicator()
                                : Text(
                                    'SIGN UP',
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
                  SizedBox(height: 40),
                  Text(
                    'Or Login With',
                    style: GoogleFonts.plusJakartaSans(
                        color: Colors.black,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        height: 0.10),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (_) => Phone())),
                        child: Container(
                          width: 223.w,
                          height: 46.h,
                          decoration: ShapeDecoration(
                            color: Color(0xFF1877F2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(
                                Icons.phone,
                                color: Colors.white,
                                size: 28.sp,
                              ),
                              Text(
                                'Sign In with Phone',
                                style: GoogleFonts.plusJakartaSans(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      Container(
                        width: 82,
                        height: 46,
                        padding: const EdgeInsets.all(10),
                        decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1, color: Color(0xFFDDDDDD)),
                                borderRadius: BorderRadius.circular(10.r))),
                        child: Image.asset(
                          'assets/images/img7.png',
                          height: 80.h,
                          width: 80.w,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: GoogleFonts.plusJakartaSans(
                            color: Color(0xFF6C6C6C),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            height: 0.10,
                            letterSpacing: 0.26),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => Sign_in()));
                        },
                        child: Text(
                          ' Login Here',
                          style: GoogleFonts.inter(
                              color: Color(0xFFF8C657),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              height: 0.10,
                              letterSpacing: 0.24),
                        ),
                      )
                    ],
                  ),
                ]),
              ),
            )),
      ),
    );
  }
}
