import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:swipe_to/swipe_to.dart';
import 'messageBubble.dart';

class Messages extends StatelessWidget {

  dynamic uniqueValue;
  Messages({Key? key, required this.uniqueValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user= FirebaseAuth.instance.currentUser;

    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('SportsGroup')
        .doc(uniqueValue.toString())
        .collection('Chat')
            .orderBy(
          'createdAt',
          descending: true,
        )
            .snapshots(),
        builder: (ctx, chatSnapshot) {
          if (chatSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final chatDocs = chatSnapshot.data!.docs;
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            reverse: true,
            itemCount: chatDocs.length,
            itemBuilder: (ctx, index) => AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 905),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: SwipeTo(
                    onRightSwipe: (){},
                    child: MessageBubble(
                      chatDocs[index]['text'],
                      chatDocs[index]['createdAt'],
                      chatDocs[index]['userId'] == user?.uid,
                      chatDocs[index]['username'],
                      chatDocs[index]['userImage'],
                      key: ValueKey(chatDocs[index].id),
                    ),
                  ),
                ),
              ),
            )
            );
        });
  }
}
