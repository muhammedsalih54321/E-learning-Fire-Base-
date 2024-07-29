import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning_firebase/Ui/Components/E-book%20Container.dart';
import 'package:e_learning_firebase/Ui/Screens/PDFscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class E_book extends StatelessWidget {
  E_book({super.key});

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
                            return GestureDetector(
                              onTap: () => Navigator.push(context,MaterialPageRoute(builder: (_)=>Pdfscreen(pdf: snapshot.data!.docs[index]["PDF URL"]
                                      .toString(),))),
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
