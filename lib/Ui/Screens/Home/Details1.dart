import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning_firebase/Ui/Components/Toastmessage.dart';

import 'package:e_learning_firebase/Ui/Screens/Home/videolist1.dart';


import 'package:firebase_auth/firebase_auth.dart';

import 'package:flick_video_player/flick_video_player.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:video_player/video_player.dart';

class Details1 extends StatefulWidget {
  final String id;
  final int index;
  final String img;
  final String rating;
  final String Coursename;
  final String name;
  final String Price;
  final double star;
  final List<dynamic> videoUrl;

  const Details1(
      {super.key,
      required this.index,
      required this.img,
      required this.rating,
      required this.Coursename,
      required this.name,
      required this.Price,
      required this.star,
      required this.videoUrl,
      required this.id});

  @override
  State<Details1> createState() => _DetailsState();
}

class _DetailsState extends State<Details1> {
  late FlickManager flickManager;

  bool loading = false;

  final firestorecollection = FirebaseFirestore.instance.collection('Users');

  FirebaseAuth auth = FirebaseAuth.instance;
  Duration? videoDuration;
  bool saved = false;
  bool favourate = false;
  late List<dynamic> videos;
  Future<void> initializePlay({String? videoPath}) async {
    flickManager = FlickManager(
        videoPlayerController:
            VideoPlayerController.networkUrl(Uri.parse(videoPath!))
              ..initialize().then((_) {
                videoDuration =
                    VideoPlayerController.networkUrl(Uri.parse(videoPath))
                        .value
                        .duration;
                VideoPlayerController.networkUrl(Uri.parse(videoPath)).pause();
              }));
  }

  @override
  void dispose() {
    flickManager.dispose();

    super.dispose();
  }

  @override
  void initState() {
    initializePlay(videoPath: widget.videoUrl.first["URL"]);
    checkFavourate();
    checkSaved();
    super.initState();
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    showAlertDialog(context, "Payment Failed",
        "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) async {
    firestorecollection
        .doc(auth.currentUser!.uid.toString())
        .update({"Premium": true}).then(
      (value) => {
        ToastMessage().toastmessage(message: 'Uploaded successfully'),
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) => Videolist2(videoUrl: widget.videoUrl)))
      },
    );
    showAlertDialog(
        context, "Payment Successful", "Payment ID: ${response.paymentId}");
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showAlertDialog(
        context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> checkSaved() async {
    final firestoreCollection = FirebaseFirestore.instance.collection('Users');
    final userDoc = firestoreCollection.doc(auth.currentUser!.uid);

    // Access the subcollection
    final subcollection = userDoc
        .collection('savedcourse'); // Replace with your subcollection name

    // Get all documents in the subcollection
    QuerySnapshot querySnapshot = await subcollection.get();

    // Get data from docs and convert map to List

    for (int i = 0; i < querySnapshot.docs.length; i++) {
      if (querySnapshot.docs[i]['id'].toString() == widget.id.toString()) {
        print("item found");
        setState(() {
          saved = true;
        });
      } else {
        print("item not found");
      }
    }

    // print("hi"+querySnapshot.docs.map((e){});
  }

  Future<void> checkFavourate() async {
    final firestoreCollection = FirebaseFirestore.instance
        .collection('Users')
        .doc(auth.currentUser!.uid)
        .collection('favouratecourse');

    QuerySnapshot querySnapshot = await firestoreCollection.get();

    // Get data from docs and convert map to List

    for (int i = 0; i < querySnapshot.docs.length; i++) {
      if (querySnapshot.docs[i]['id'].toString() == widget.id.toString()) {
        print("item found");
        setState(() {
          favourate = true;
        });
      } else {
        print("item not found");
      }
    }

    // print("hi"+querySnapshot.docs.map((e){});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SafeArea(
          child: Container(
            width: double.infinity,
            height: 280.h,
            color: Colors.black,
            child: FlickVideoPlayer(flickManager: flickManager),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.Coursename.toString(),
                style: GoogleFonts.plusJakartaSans(
                  color: Color(0xFF1D1B20),
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  height: 0.06,
                  letterSpacing: 0.18,
                ),
              ),
              Wrap(
                children: [
                  IconButton(
                      onPressed: () {
                        checkFavourate();
                        if (favourate==true) {
                         firestorecollection
                            .doc(auth.currentUser!.uid.toString())
                            .collection("favouratecourse")
                            .doc(widget.id.toString()).delete().then(
                          (value) {
                            ToastMessage()
                                .toastmessage(message: 'remove');
                            setState(() {
                              favourate = false;
                            });
                          },
                        ).onError(
                          (error, stackTrace) {
                            ToastMessage()
                                .toastmessage(message: error.toString());
                          },
                        );
                            
                        }else{
                        firestorecollection
                            .doc(auth.currentUser!.uid.toString())
                            .collection("favouratecourse")
                            .doc(widget.id.toString())
                            .set({
                          "ischecked": "true",
                          "id": widget.id.toString(),
                          "Course name": widget.Coursename.toString(),
                          "Thumnail": widget.img.toString(),
                          "rating": widget.rating.toString(),
                          "name": widget.name.toString(),
                          "Price": widget.Price.toString(),
                          "videos": widget.videoUrl
                        }).then(
                          (value) {
                            ToastMessage()
                                .toastmessage(message: 'Saved succesfully');
                            setState(() {
                              favourate = true;
                            });
                          },
                        ).onError(
                          (error, stackTrace) {
                            ToastMessage()
                                .toastmessage(message: error.toString());
                          },
                        );
                      }},
                      icon: favourate == true
                          ? Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                          : Icon(Icons.favorite_border_outlined)),
                  IconButton(
                      onPressed: () {
                        checkSaved();
                         if (saved==true) {
                         firestorecollection
                            .doc(auth.currentUser!.uid.toString())
                            .collection("savedcourse")
                            .doc(widget.id.toString()).delete().then(
                          (value) {
                            ToastMessage()
                                .toastmessage(message: 'remove');
                            setState(() {
                              saved = false;
                            });
                          },
                        ).onError(
                          (error, stackTrace) {
                            ToastMessage()
                                .toastmessage(message: error.toString());
                          },
                        );
                            
                        }else{

                        firestorecollection
                            .doc(auth.currentUser!.uid.toString())
                            .collection("savedcourse")
                            .doc(widget.id.toString())
                            .set({
                          "ischecked": "true",
                          "id": widget.id.toString(),
                          "Course name": widget.Coursename.toString(),
                          "Thumnail": widget.img.toString(),
                          "rating": widget.rating.toString(),
                          "name": widget.name.toString(),
                          "Price": widget.Price.toString(),
                          "videos": widget.videoUrl
                        }).then(
                          (value) {
                            ToastMessage()
                                .toastmessage(message: 'added succesful');
                            setState(() {
                              saved = true;
                            });
                          },
                        ).onError(
                          (error, stackTrace) {
                            ToastMessage()
                                .toastmessage(message: error.toString());
                          },
                        );
                      }},
                      icon: saved == true
                          ? Icon(
                              Icons.bookmark,
                              color: Colors.amber,
                            )
                          : Icon(Icons.bookmark_outline)),
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Text(
            'About course',
            style: GoogleFonts.plusJakartaSans(
              color: Color(0xFF1D1B20),
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              height: 0.06,
              letterSpacing: 0.18,
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Text(
            'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. ',
            style: GoogleFonts.plusJakartaSans(
              color: Color(0xFF1D1B20),
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.18,
            ),
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: GestureDetector(
            onTap: () async {
              final firestoreCollections = FirebaseFirestore.instance
                  .collection('Users')
                  .doc(auth.currentUser!.uid.toString());

              DocumentSnapshot<Map<String, dynamic>> querySnapshot =
                  await firestoreCollections.get();

              if (querySnapshot['Premium'] == false) {
                showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.r),
                          topRight: Radius.circular(30.r))),
                  context: context,
                  builder: (context) {
                    return Container(
                      width: double.infinity.w,
                      height: 300.h,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 15..h,
                          ),
                          Icon(
                            Icons.star_rounded,
                            color: Colors.amber,
                            size: 70.sp,
                          ),
                          SizedBox(
                            height: 15..h,
                          ),
                          Text(
                            'Unlock Premium Access',
                            style: GoogleFonts.plusJakartaSans(
                              color: Colors.black,
                              fontSize: 23.sp,
                              fontWeight: FontWeight.w700,
                              height: 0.06,
                              letterSpacing: 0.18,
                            ),
                          ),
                          SizedBox(
                            height: 18.h,
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            'Subscribe for Rs.100 and get access to All courses\n and E-Books. Enjoy additional features like refer\n and earn money.',
                            style: GoogleFonts.plusJakartaSans(
                              color: Color.fromARGB(255, 48, 47, 51),
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.18,
                            ),
                          ),
                          SizedBox(
                            height: 25.h,
                          ),
                          GestureDetector(
                            onTap: () {
                              Razorpay razorpay = Razorpay();
                              var options = {
                                'key': 'rzp_test_gKANZdsNdLqaQs',
                                'amount': 100,
                                'name': 'Acme Corp.',
                                'description': 'Fine T-Shirt',
                                'retry': {'enabled': true, 'max_count': 1},
                                'send_sms_hash': true,
                                'prefill': {
                                  'contact': '8888888888',
                                  'email': 'test@razorpay.com'
                                },
                                'external': {
                                  'wallets': ['paytm']
                                }
                              };
                              razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
                                  handlePaymentErrorResponse);
                              razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                                  handlePaymentSuccessResponse);
                              razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                                  handleExternalWalletSelected);
                              razorpay.open(options);
                            },
                            child: Container(
                              width: 250,
                              height: 57.h,
                              padding: const EdgeInsets.symmetric(vertical: 17),
                              decoration: ShapeDecoration(
                                color: Color(0xD3F8C657),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Subscribe for Rs. 100',
                                  style: GoogleFonts.plusJakartaSans(
                                    color: Colors.black,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    height: 0,
                                    letterSpacing: 0.36,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              }

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => Videolist2(videoUrl: widget.videoUrl)));
            },
            child: Container(
                width: double.infinity,
                height: 57.h,
                padding: const EdgeInsets.symmetric(vertical: 17),
                decoration: ShapeDecoration(
                  color: Color(0xD3F8C657),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Start Course!',
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
        ),
        SizedBox(
          height: 20.h,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: GestureDetector(
            onTap: () {
              setState(() {
                loading == true;
              });

              firestorecollection
                  .doc(auth.currentUser!.uid.toString())
                  .collection("cartcourse")
                  .doc(widget.id.toString())
                  .set({
                "ischecked": "true",
                "id": widget.id.toString(),
                "Course name": widget.Coursename.toString(),
                "Thumnail": widget.img.toString(),
                "rating": widget.rating.toString(),
                "name": widget.name.toString(),
                "Price": widget.Price.toString(),
                "videos": widget.videoUrl
              }).then(
                (value) {
                  ToastMessage().toastmessage(message: 'Saved succesfully');
                  setState(() {
                    loading = false;
                  });
                },
              ).onError(
                (error, stackTrace) {
                  ToastMessage().toastmessage(message: error.toString());
                },
              );
            },
            child: Container(
                width: double.infinity,
                height: 57.h,
                padding: const EdgeInsets.symmetric(vertical: 17),
                decoration: ShapeDecoration(
                  color: Color(0xD3F8C657),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    loading
                        ? CircularProgressIndicator()
                        : Text(
                            'Add to Cart',
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
        ),
      
      ],
    ));
  }
}
