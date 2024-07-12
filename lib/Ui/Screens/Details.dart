import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  late VideoPlayerController videoController;
  late FlickManager flickManager;
  final firestore1 =
      FirebaseFirestore.instance.collection('StudentAlsoSearch').snapshots();
  final firestore2 =
      FirebaseFirestore.instance.collection('TopCoursesinIT').snapshots();

  Duration? videoDuration;
  Future<void> initializePlay({String? videoPath}) async {
    flickManager = FlickManager(
        videoPlayerController:
            VideoPlayerController.networkUrl(Uri.parse(videoPath!))
              ..initialize().then((_) {
                videoDuration = videoController.value.duration;
                videoController.play();
              }));
  }

  Future<void> startPlay(String videoPath) async {
    await _clearPrevious().then((_) {
      initializePlay(videoPath: videoPath);
    });
  }

  Future<bool> _clearPrevious() async {
    await videoController.pause();
    videoController.dispose();
    return true;
  }

  @override
  void dispose() {
    videoController.dispose();
    super.dispose();
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
                initializePlay();
                return Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 300.h,
                      color: Colors.black,
                      child: FlickVideoPlayer(flickManager: flickManager),
                    )
                  ],
                );
              } else {
                return SizedBox();
              }
            }));
  }
}
