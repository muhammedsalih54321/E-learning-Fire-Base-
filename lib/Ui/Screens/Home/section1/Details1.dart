import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning_firebase/Ui/Components/Toastmessage.dart';
import 'package:e_learning_firebase/Ui/Screens/Home/section1/videolist1.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class Details1 extends StatefulWidget {
  final int index;
  const Details1({super.key, required this.index});

  @override
  State<Details1> createState() => _DetailsState();
}

class _DetailsState extends State<Details1> {
  late FlickManager flickManager;
  final firestore1 =
      FirebaseFirestore.instance.collection('StudentAlsoSearch').snapshots();
  final firestorecollection = FirebaseFirestore.instance
      .collection('Users');
  
  FirebaseAuth auth = FirebaseAuth.instance;
  Duration? videoDuration;
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

  Future<void> startPlay(String videoPath) async {
    await _clearPrevious(videoPath).then((_) {
      initializePlay(videoPath: videoPath);
    });
  }

  Future<bool> _clearPrevious(String videoPath) async {
    await VideoPlayerController.networkUrl(Uri.parse(videoPath)).pause();
    VideoPlayerController.networkUrl(Uri.parse(videoPath)).dispose();
    return true;
  }

Future<void> checkSaved() async {
  final firestoreCollection = FirebaseFirestore.instance.collection('Users');
  final userDoc = firestoreCollection.doc(auth.currentUser!.uid);
  
  // Access the subcollection
  final subcollection = userDoc.collection('savedcourse'); // Replace with your subcollection name
  
  // Get all documents in the subcollection
  QuerySnapshot querySnapshot = await subcollection.get();
  
  // Get data from docs and convert map to List
  final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
  print("hi"+allData.toString());
 // print("hi"+querySnapshot.docs.map((e){});
  
}




  @override
  void dispose() {
    flickManager.dispose();

    super.dispose();
  }

  @override
  void initState() {
    initializePlay();
    checkSaved();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: firestore1,
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                initializePlay(
                    videoPath: snapshot
                        .data?.docs[widget.index]['videos'][0]['URL']
                        .toString());
                    
                return Column(
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
                            snapshot
                                .data!.docs[widget.index]['videos'][0]['title']
                                .toString(),
                            style: GoogleFonts.plusJakartaSans(
                              color: Color(0xFF1D1B20),
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w700,
                              height: 0.06,
                              letterSpacing: 0.18,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                             
                                firestorecollection.doc(auth.currentUser!.uid.toString()).collection("savedcourse").doc(snapshot.data!.docs[widget.index]["id"].toString()).set({
                                  "id":snapshot.data!.docs[widget.index]["id"].toString() ,
                                  "Course name": snapshot
                                      .data!.docs[widget.index]["Course name"]
                                      .toString(),
                                  "Thumnail": snapshot.data!.docs[widget.index]["Thumnail"]
                                      .toString(),
                                  "rating": snapshot.data!.docs[widget.index]["rating"]
                                      .toString(),
                                  "name":
                                      snapshot.data!.docs[widget.index]["name"].toString(),
                                  "Price": snapshot.data!.docs[widget.index]["Price"]
                                      .toString(),
                                  "videos": snapshot.data!.docs[widget.index]["videos"]
                                     
                                }).then(
                                  (value) {
                                    ToastMessage()
                                        .toastmessage(message: 'Saved succesfully');
                                  },
                                ).onError(
                                  (error, stackTrace) {
                                    ToastMessage().toastmessage(
                                        message: error.toString());
                                  },
                                );
                                ;
                              },
                              icon: Icon(Icons.bookmark))
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
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => Videolist2(
                                    videoUrl: snapshot.data!.docs[widget.index]
                                        ['videos']))),
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
                  ],
                );
              } else {
                return SizedBox();
              }
            }));
  }
}