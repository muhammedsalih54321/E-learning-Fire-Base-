import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning_firebase/Ui/Components/Toastmessage.dart';

import 'package:e_learning_firebase/Ui/Screens/Home/section2/videolist2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class Details2 extends StatefulWidget {
  final int index;
  const Details2({super.key, required this.index});

  @override
  State<Details2> createState() => _Details2State();
}

class _Details2State extends State<Details2> {
  late FlickManager flickManager;
  bool saved = false;
  bool favourate = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  final id = DateTime.now().microsecondsSinceEpoch.toString();
  final firestore2 =
      FirebaseFirestore.instance.collection('TopCoursesinIT').snapshots();
  final firestorecollection = FirebaseFirestore.instance.collection('Users');

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

  @override
  void dispose() {
    flickManager.dispose();

    super.dispose();
  }

  @override
  void initState() {
    initializePlay();

    super.initState();
  }

  Future<void> checkSaved(AsyncSnapshot<QuerySnapshot> snapshot) async {
    final firestoreCollection = FirebaseFirestore.instance.collection('Users');
    final userDoc = firestoreCollection.doc(auth.currentUser!.uid);

    // Access the subcollection
    final subcollection = userDoc
        .collection('savedcourse'); // Replace with your subcollection name

    // Get all documents in the subcollection
    QuerySnapshot querySnapshot = await subcollection.get();

    // Get data from docs and convert map to List

    for (int i = 0; i < querySnapshot.docs.length; i++) {
      if (querySnapshot.docs[i]['id'].toString() ==
          snapshot.data!.docs[widget.index]['id'].toString()) {
        print("item found");
        setState(() {
          saved = true;
        });
      } else {
        print("item not found");
      }
    }
  }
   Future<void> checkFavourate(AsyncSnapshot<QuerySnapshot> snapshot) async {
    final firestoreCollection = FirebaseFirestore.instance.collection('Users');
    final userDoc = firestoreCollection.doc(auth.currentUser!.uid);

    // Access the subcollection
    final subcollection = userDoc
        .collection('favouratecourse'); // Replace with your subcollection name

    // Get all documents in the subcollection
    QuerySnapshot querySnapshot = await subcollection.get();

    // Get data from docs and convert map to List

    for (int i = 0; i < querySnapshot.docs.length; i++) {
      if (querySnapshot.docs[i]['id'].toString() ==
          snapshot.data!.docs[widget.index]['id'].toString()) {
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
        body: StreamBuilder<QuerySnapshot>(
            stream: firestore2,
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
                checkSaved(snapshot);
                checkFavourate(snapshot);

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
                          SizedBox(
                            height: 58.h,
                            width: 230.w,
                            child: Text(
                              snapshot
                                  .data!.docs[widget.index]['videos'][0]['title']
                                  .toString(),
                              style: GoogleFonts.plusJakartaSans(
                                color: Color(0xFF1D1B20),
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w700,
                              
                                letterSpacing: 0.18,
                              ),
                            ),
                          ),
                         Wrap(
                            children: [
                                 IconButton(onPressed: (){
                                    firestorecollection
                                        .doc(auth.currentUser!.uid.toString())
                                        .collection("favouratecourse")
                                        .doc(snapshot.data!.docs[widget.index]["id"]
                                            .toString())
                                        .set({
                                       "ischecked":"true",   
                                      "id": snapshot.data!.docs[widget.index]["id"]
                                          .toString(),
                                      "Course name": snapshot
                                          .data!.docs[widget.index]["Course name"]
                                          .toString(),
                                      "Thumnail": snapshot
                                          .data!.docs[widget.index]["Thumnail"]
                                          .toString(),
                                      "rating": snapshot
                                          .data!.docs[widget.index]["rating"]
                                          .toString(),
                                      "name": snapshot
                                          .data!.docs[widget.index]["name"]
                                          .toString(),
                                      "Price": snapshot
                                          .data!.docs[widget.index]["Price"]
                                          .toString(),
                                      "videos": snapshot.data!.docs[widget.index]
                                          ["videos"]
                                    }).then(
                                      (value) {
                                        ToastMessage().toastmessage(
                                            message: 'Saved succesfully');
                                           setState(() {
                                              favourate == true;
                                            });
                                            
                                      },
                                    ).onError(
                                      (error, stackTrace) {
                                        ToastMessage().toastmessage(
                                            message: error.toString());
                                      },
                                    );
                                }, icon:  favourate == true
                                      ? Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        )
                                      : Icon(Icons.favorite_border_outlined)),
                              IconButton(
                                  onPressed: () {
                                    firestorecollection
                                        .doc(auth.currentUser!.uid.toString())
                                        .collection("savedcourse")
                                        .doc(snapshot.data!.docs[widget.index]["id"]
                                            .toString())
                                        .set({
                                        "ischecked":"false", 
                                      "id": snapshot.data!.docs[widget.index]["id"]
                                          .toString(),
                                      "Course name": snapshot
                                          .data!.docs[widget.index]["Course name"]
                                          .toString(),
                                      "Thumnail": snapshot
                                          .data!.docs[widget.index]["Thumnail"]
                                          .toString(),
                                      "rating": snapshot
                                          .data!.docs[widget.index]["rating"]
                                          .toString(),
                                      "name": snapshot
                                          .data!.docs[widget.index]["name"]
                                          .toString(),
                                      "Price": snapshot
                                          .data!.docs[widget.index]["Price"]
                                          .toString(),
                                      "videos": snapshot.data!.docs[widget.index]
                                          ["videos"]
                                    }).then(
                                      (value) {
                                        ToastMessage().toastmessage(
                                            message: 'Saved succesfully');
                                            setState(() {
                                              saved == true;
                                            });
                                            
                                     
                                      },
                                    ).onError(
                                      (error, stackTrace) {
                                        ToastMessage().toastmessage(
                                            message: error.toString());
                                      },
                                    );
                                    ;
                                  },
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
                      height: 30.h,
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
                                      videoUrl: snapshot
                                          .data!.docs[widget.index]['videos'],
                                    ))),
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
                     SizedBox(height: 20.h,),
                      Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: GestureDetector(
                        onTap: () {
                           firestorecollection
                                        .doc(auth.currentUser!.uid.toString())
                                        .collection("cartcourse")
                                        .doc(snapshot.data!.docs[widget.index]["id"]
                                            .toString())
                                        .set({
                                       "ischecked":"true",   
                                      "id": snapshot.data!.docs[widget.index]["id"]
                                          .toString(),
                                      "Course name": snapshot
                                          .data!.docs[widget.index]["Course name"]
                                          .toString(),
                                      "Thumnail": snapshot
                                          .data!.docs[widget.index]["Thumnail"]
                                          .toString(),
                                      "rating": snapshot
                                          .data!.docs[widget.index]["rating"]
                                          .toString(),
                                      "name": snapshot
                                          .data!.docs[widget.index]["name"]
                                          .toString(),
                                      "Price": snapshot
                                          .data!.docs[widget.index]["Price"]
                                          .toString(),
                                      "videos": snapshot.data!.docs[widget.index]
                                          ["videos"]
                                    }).then(
                                      (value) {
                                        ToastMessage().toastmessage(
                                            message: 'Saved succesfully');
                                       
                                            
                                      },
                                    ).onError(
                                      (error, stackTrace) {
                                        ToastMessage().toastmessage(
                                            message: error.toString());
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
                                Text(
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
                );
              } else {
                return SizedBox();
              }
            }));
  }
}
