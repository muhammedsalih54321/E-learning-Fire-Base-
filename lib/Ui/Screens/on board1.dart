import 'package:e_learning_firebase/Ui/Screens/Auth/Sign%20in.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:introduction_screen/introduction_screen.dart';

class On_board1 extends StatelessWidget {
  const On_board1({super.key});

  @override
  Widget build(BuildContext context) {
    void onIntroEnd(context) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => Sign_in()),
      );
    }

    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Color(0xE0E0E0),
      imagePadding: EdgeInsets.zero,
    );
    return IntroductionScreen(
      pages: [
        PageViewModel(
          titleWidget: Text(
            'Certification and Badges',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 28,
              fontFamily: 'Plus Jakarta Sans',
              fontWeight: FontWeight.w700,
              height: 0,
            ),
          ),
          bodyWidget: Text(
            'Earn a certificate after completion of            every course',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black.withOpacity(0.6299999952316284),
              fontSize: 16,
              fontFamily: 'Plus Jakarta Sans',
              fontWeight: FontWeight.w300,
              height: 0,
            ),
          ),
          image: Column(
            children: [
              SizedBox(
                height: 220.h,
              ),
              Center(
                child: Container(
                    width: 297.54.w,
                    height: 190.h,
                    child: Image.asset('assets/images/img3.png')),
              ),
            ],
          ),
          decoration: pageDecoration.copyWith(
            contentMargin: const EdgeInsets.symmetric(horizontal: 16),
            fullScreen: true,
            bodyFlex: 2,
            imageFlex: 3,
            safeArea: 100,
          ),
        ),
        PageViewModel(
          titleWidget: Text(
            'Progress Tracking',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 32,
              fontFamily: 'Plus Jakarta Sans',
              fontWeight: FontWeight.w700,
              height: 0,
            ),
          ),
          bodyWidget: Text(
            'Check your Progress of every course',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black.withOpacity(0.6299999952316284),
              fontSize: 16,
              fontFamily: 'Plus Jakarta Sans',
              fontWeight: FontWeight.w300,
              height: 0,
            ),
          ),
          image: Column(
            children: [
              SizedBox(
                height: 130.h,
              ),
              Center(
                child: Container(
                    width: 299.64.w,
                    height: 290.h,
                    child: Image.asset('assets/images/img4.png')),
              ),
            ],
          ),
          decoration: pageDecoration.copyWith(
            contentMargin: const EdgeInsets.symmetric(horizontal: 16),
            fullScreen: true,
            bodyFlex: 2,
            imageFlex: 3,
            safeArea: 100,
          ),
        ),
        PageViewModel(
          titleWidget: Text(
            'Off line Access',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 32,
              fontFamily: 'Plus Jakarta Sans',
              fontWeight: FontWeight.w700,
              height: 0,
            ),
          ),
          bodyWidget: Text(
            'Make your course available offline',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black.withOpacity(0.6299999952316284),
              fontSize: 16,
              fontFamily: 'Plus Jakarta Sans',
              fontWeight: FontWeight.w300,
              height: 0,
            ),
          ),
          image: Column(
            children: [
              SizedBox(
                height: 130.h,
              ),
              Center(
                child: Container(
                    width: 281.w,
                    height: 275.76.h,
                    child: Image.asset('assets/images/img5.png')),
              ),
            ],
          ),
          decoration: pageDecoration.copyWith(
            contentMargin: const EdgeInsets.symmetric(horizontal: 16),
            fullScreen: true,
            bodyFlex: 2,
            imageFlex: 3,
            safeArea: 100,
          ),
        ),
        PageViewModel(
          titleWidget: Text(
            'Course Catalog',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 32,
              fontFamily: 'Plus Jakarta Sans',
              fontWeight: FontWeight.w700,
              height: 0,
            ),
          ),
          bodyWidget: Text(
            'View in which courses you are enrolled',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black.withOpacity(0.6299999952316284),
              fontSize: 16,
              fontFamily: 'Plus Jakarta Sans',
              fontWeight: FontWeight.w300,
              height: 0,
            ),
          ),
          image: Column(
            children: [
              SizedBox(
                height: 130.h,
              ),
              Center(
                child: Container(
                    width: 299.64.w,
                    height: 290.h,
                    child: Image.asset('assets/images/img6.png')),
              ),
            ],
          ),
          decoration: pageDecoration.copyWith(
            contentMargin: const EdgeInsets.symmetric(horizontal: 16),
            fullScreen: true,
            bodyFlex: 2,
            imageFlex: 3,
            safeArea: 100,
          ),
        ),
      ],
      onDone: () {
        onIntroEnd(context);
      },
      onSkip: () {
        onIntroEnd(context);
      },
      showSkipButton: true,
      showBackButton: false,
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: Container(
        width: 69.w,
        height: 67.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60.r), color: Colors.amber),
        child: Center(
          child: Icon(
            Icons.arrow_forward,
            color: Colors.white,
            size: 30.sp,
          ),
        ),
      ),
      done: Container(
        width: 69.w,
        height: 67.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60.r), color: Colors.amber),
        child: Center(
          child: Icon(
            Icons.arrow_forward,
            color: Colors.white,
            size: 30.sp,
          ),
        ),
      ),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
    );
  }
}
