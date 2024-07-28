
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class Videolist2 extends StatefulWidget {
  final List<dynamic> videoUrl;
  Videolist2({required this.videoUrl});
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<Videolist2> {
  late VideoPlayerController videoController;
  ChewieController? chewieController;
  int currentindex = 0;

  @override
  void initState() {
    super.initState();
    _initializePlay(widget.videoUrl[currentindex]["URL"]);
  }

  Future<void> _initializePlay(String videoPath) async {
    videoController = VideoPlayerController.networkUrl(Uri.parse(videoPath))
      ..initialize().then((_) {
        setState(() {
          chewieController = ChewieController(
            videoPlayerController: videoController,
            aspectRatio: videoController.value.aspectRatio,
            autoPlay: true,
            looping: false,
          );
        });
      });
  }

  void _changeVideo(String videoPath, int index) {
    setState(() {
      currentindex = index;
    });
    videoController.pause();
    videoController.dispose();
    chewieController?.dispose();
    _initializePlay(videoPath);
  }

  @override
  void dispose() {
    videoController.dispose();
    chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 300.h,
            width: double.infinity,
            child: chewieController != null &&
                    chewieController!.videoPlayerController.value.isInitialized
                ? Chewie(controller: chewieController!)
                : Center(child: CircularProgressIndicator()),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.videoUrl.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    _changeVideo(widget.videoUrl[index]["URL"], index);
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.play_circle,
                      size: 35.sp,
                      color: index == currentindex
                          ? Color(0xFF477B72)
                          : Color(0xFF1D1B20),
                    ),
                    title: Text(
                      widget.videoUrl[index]['title'].toString(),
                      style: GoogleFonts.plusJakartaSans(
                        color: index == currentindex
                            ? Color(0xFF477B72)
                            : Color(0xFF1D1B20),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        height: 0.06,
                        letterSpacing: 0.18,
                      ),
                    ),
                    subtitle: Text(
                      '${widget.videoUrl[index]['Duration'].toString()} min',
                      style: GoogleFonts.plusJakartaSans(
                        color: index == currentindex
                            ? Color(0xFF477B72)
                            : Colors.grey,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        height: 0.06,
                        letterSpacing: 0.18,
                      ),
                    ),
                    trailing: index == currentindex
                        ? Icon(
                            Icons.done,
                            color: Color(0xFF477B72),
                          )
                        : SizedBox(),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}