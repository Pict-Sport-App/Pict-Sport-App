import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:psa/appdrawer/users.dart';
import 'package:psa/widget/constants.dart';

class ChatMembers extends StatefulWidget {
  static const routeName = '/chat_members';
  const ChatMembers({Key? key}) : super(key: key);

  @override
  _ChatMembersState createState() => _ChatMembersState();
}

class _ChatMembersState extends State<ChatMembers> {
  dynamic _productId;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _productId = ModalRoute.of(context)!.settings.arguments as String;
      if (_productId == 'BasketBall') {
      } else if (_productId == 'VolleyBall') {
      } else if (_productId == 'TableTennis') {
      } else if (_productId == 'Badminton') {
      } else if (_productId == 'Cricket') {
      } else if (_productId == 'FootBall') {
      } else if (_productId == 'Chess') {
      } else if (_productId == 'Gym') {
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage(kkbackgroundImage),
                fit: BoxFit.cover
            ),
          ),
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('User').snapshots(),
              builder: (ctx, grpMemSnapshot) {
                if (grpMemSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final grpMembers = grpMemSnapshot.data!.docs;
                return Column(
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        height: height * 0.11,
                        decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            )),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15,top: 10,bottom: 5),
                              child: Text(
                                _productId,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                'Group Members',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                          itemCount: grpMembers.length,
                          itemBuilder: (ctx, index) =>
                              _productId[0]=='O'?
                              grpMembers[index]['Official SportList'][_productId]==2?
                              AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 905),
                                child: SlideAnimation(
                                  verticalOffset: 50.0,
                                  child: FadeInAnimation(
                                    child: UserWidget(
                                        onTap: () {},
                                        misId: grpMembers[index]['misId'],
                                        name: grpMembers[index]['name'],
                                        url: grpMembers[index]['photourl']),
                                  ),
                                ),
                              ):
                                  Container():grpMembers[index]
                              ['SportList'][_productId]==true
                                  ? AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 905),
                                child: SlideAnimation(
                                  verticalOffset: 50.0,
                                  child: FadeInAnimation(
                                    child: UserWidget(
                                        onTap: () {},
                                        misId: grpMembers[index]['misId'],
                                        name: grpMembers[index]['name'],
                                        url: grpMembers[index]['photourl']),
                                  ),
                                ),
                              )
                                  : Container()


                        /* _productId[0]=='O'?
                          grpMembers[index]['Official SportList'][_productId]==2?
                          AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 905),
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                child: UserWidget(
                                    onTap: () {},
                                    misId: grpMembers[index]['misId'],
                                    name: grpMembers[index]['name'],
                                    url: grpMembers[index]['photourl']),
                              ),
                            ),
                          ):
                              _productId[0]!='0'? grpMembers[index]
                                  ['SportList'][_productId]==true
                              ? AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 905),
                                child: SlideAnimation(
                                  verticalOffset: 50.0,
                                  child: FadeInAnimation(
                                    child: UserWidget(
                                        onTap: () {},
                                        misId: grpMembers[index]['misId'],
                                        name: grpMembers[index]['name'],
                                        url: grpMembers[index]['photourl']),
                                  ),
                                ),
                              )
                              : Container():Container():Container()*/
                      )
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
