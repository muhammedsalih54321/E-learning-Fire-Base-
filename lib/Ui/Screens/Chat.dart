import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning_firebase/Ui/Components/Toastmessage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Chat extends StatelessWidget {
  Chat({super.key});

  final firestorecollection = FirebaseFirestore.instance.collection('Users');

  final formKey = GlobalKey<FormState>();

  final chat = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final Chats = FirebaseFirestore.instance
        .collection('Users')
        .doc(auth.currentUser!.uid)
        .collection('chat')
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/img1.png'),
            radius: 10.r,
          ),
        ),
        title: Text(
          'Help Center!',
          style: GoogleFonts.plusJakartaSans(
            color: Color(0xFF1D1B20),
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            height: 0.05,
            letterSpacing: 0.20,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: Chats,
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
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return snapshot.data!.docs[index]['response'] == ""
                      ? ChatBubble(
                          clipper:
                              ChatBubbleClipper1(type: BubbleType.sendBubble),
                          alignment: Alignment.topRight,
                          margin: EdgeInsets.only(top: 20),
                          backGroundColor: Color(0xAD477B72),
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.7,
                            ),
                            child: Text(
                              snapshot.data!.docs[index]['message'].toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      : ChatBubble(
                          clipper: ChatBubbleClipper1(
                              type: BubbleType.receiverBubble),
                          alignment: Alignment.bottomLeft,
                          margin: EdgeInsets.only(top: 20),
                          backGroundColor: Color(0xFFF6C354),
                          child: Container(
                            constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.7,
                            ),
                            child: Text(
                              snapshot.data!.docs[index]['response'].toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                },
              );
            } else {
              return SizedBox();
            }
          }),
      bottomNavigationBar: Form(
        key: formKey,
        child: Container(
          height: 60.h,
          width: double.infinity.w,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              controller: chat,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.emoji_emotions_outlined),
                  suffixIcon: IconButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          final id =
                              DateTime.now().microsecondsSinceEpoch.toString();
                          firestorecollection
                              .doc(auth.currentUser!.uid.toString())
                              .collection("chat")
                              .doc(id)
                              .set({
                            'id': id,
                            'ischeked': true,
                            "message": chat.text.toString(),
                            "response": "",
                          }).then(
                            (value) {
                             
                              chat.clear();
                            },
                          ).onError(
                            (error, stackTrace) {
                              ToastMessage()
                                  .toastmessage(message: error.toString());
                            },
                          );
                        }
                      },
                      icon: Icon(Icons.send_outlined)),
                  filled: true,
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide:
                          BorderSide(width: 1.w, color: Color(0xFFDDDDDD))),
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide:
                          BorderSide(width: 1.w, color: Color(0xFFDDDDDD))),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide:
                        BorderSide(width: 1.w, color: Color(0xFFDDDDDD)),
                  ),
                  hintText: 'Type message',
                  hintStyle: GoogleFonts.poppins(
                    color: Color(0xFF7C7C7C),
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400,
                  )),
              validator: (email) {
                if (email!.isEmpty) {
                  return 'Type message';
                }
                return null;
              },
            ),
          ),
        ),
      ),
    );
  }
}
