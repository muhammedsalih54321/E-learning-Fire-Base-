import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning_firebase/Ui/Components/E-book%20Container.dart';
import 'package:e_learning_firebase/Ui/Components/Toastmessage.dart';
import 'package:e_learning_firebase/Ui/Screens/PDFscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class E_book extends StatefulWidget {
  E_book({super.key});

  @override
  State<E_book> createState() => _E_bookState();
}

class _E_bookState extends State<E_book> {
  final firestorecollection = FirebaseFirestore.instance.collection('Users');

  FirebaseAuth auth = FirebaseAuth.instance;
  void handlePaymentErrorResponse(PaymentFailureResponse response) {
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
                builder: (_) => Pdfscreen(pdf:pdfs )))
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
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  late String pdfs;
  @override
  Widget build(BuildContext context) {
    final E_books = FirebaseFirestore.instance.collection('E-book').snapshots();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'E-book',
          style: GoogleFonts.plusJakartaSans(
            color: Color(0xFF1D1B20),
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            height: 0.05,
            letterSpacing: 0.20,
          ),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: StreamBuilder<QuerySnapshot>(
              stream: E_books,
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  print('loading');

                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (!snapshot.hasData) {
                  print('No data');
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Image.asset('assets/images/Frame.png'),
                      )
                    ],
                  );
                }
                if (snapshot.hasError) {
                  print('Error');
                  return Center(
                    child: Text('error'),
                  );
                }
                if (snapshot.hasData) {
                  print('loaded');
                  return snapshot.data!.docs.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Image.asset('assets/images/Frame.png'),
                            )
                          ],
                        )
                      : GridView.builder(
                          itemCount: snapshot.data!.docs.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 296 / 400,
                                  crossAxisSpacing: 6,
                                  mainAxisSpacing: 10),
                          itemBuilder: (context, index) {
                            pdfs=snapshot
                                                  .data!.docs[index]["PDF URL"]
                                                  .toString();
                            return GestureDetector(
                              onTap: ()async {
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
                                        builder: (_) => Pdfscreen(
                                              pdf: snapshot
                                                  .data!.docs[index]["PDF URL"]
                                                  .toString(),
                                            )));
                              },
                              child: E_bookcontainer(
                                  img: snapshot.data!.docs[index]["Thumnail"]
                                      .toString(),
                                  rating: snapshot.data!.docs[index]["rating"]
                                      .toString(),
                                  title: snapshot.data!.docs[index]["title"]
                                      .toString(),
                                  index: index,
                                  description: snapshot
                                      .data!.docs[index]["description"]
                                      .toString()),
                            );
                          });
                } else {
                  return SizedBox();
                }
              })),
    );
  }
}
