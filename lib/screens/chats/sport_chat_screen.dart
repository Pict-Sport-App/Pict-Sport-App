import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:psa/models/user_details.dart';
import 'package:psa/screens/chats/chat_members.dart';
import 'package:psa/widget/constants.dart';
import 'messages.dart';
import 'new_message.dart';

class SportChatScreen extends StatefulWidget {
  const SportChatScreen({Key? key}) : super(key: key);
  static const routeName = '/sport_chat';

  @override
  _SportChatScreenState createState() => _SportChatScreenState();
}

class _SportChatScreenState extends State<SportChatScreen> {
  bool _isInit = true;
  final focusNode = FocusNode();
  Messages? replyMessage;
  dynamic _productId, _key;

  void replyToMessage(Messages message) {
    setState(() {
      replyMessage = message;
    });
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _productId = ModalRoute.of(context)!.settings.arguments as String;
      if (_productId == 'BasketBall') {
        _key = 'BB';
      } else if (_productId == 'VolleyBall') {
        _key = 'VB';
      } else if (_productId == 'TableTennis') {
        _key = 'TT';
      } else if (_productId == 'Badminton') {
        _key = 'BT';
      } else if (_productId == 'Cricket') {
        _key = 'CR';
      } else if (_productId == 'FootBall') {
        _key = 'FB';
      } else if (_productId == 'Chess') {
        _key = 'CH';
      } else if (_productId == 'Gym') {
        _key = 'GY';
      }else if (_productId=='Official BasketBall'){
        _key='OFBB';
      }else if (_productId=='Official VolleyBall'){
        _key='OFVV';
      }else if (_productId=='Official TableTennis'){
        _key='OFTT';
      }else if (_productId=='Official Badminton'){
        _key='OFBD';
      }else if (_productId=='Official Cricket'){
        _key='OFCR';
      }else if (_productId=='Official FootBall'){
        _key='OFFB';
      }else if (_productId=='Official Chess'){
        _key='OFCH';
      }else if (_productId=='Official Gym'){
        _key='OFGY';
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: Column(
          children: [
            Expanded(
                child: Center(
              child: Container(
                color: Colors.blue,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const FaIcon(
                              FontAwesomeIcons.arrowCircleLeft,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          _productId.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 25.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(ChatMembers.routeName,
                              arguments: _productId);
                        },
                        child: const FaIcon(
                          FontAwesomeIcons.users,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
            Expanded(
              flex: 9,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage(kkbackgroundImage),
                      fit: BoxFit.cover
                  ),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    Expanded(
                        child: Messages(
                      uniqueValue: _key,
                    )),
                    UserDetails.isAdmin==true? NewMessage(
                      keyies: _key,
                    ):Container(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
