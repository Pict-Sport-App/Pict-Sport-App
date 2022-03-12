import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:psa/screens/otherUserDetails/userprofilescreen.dart';
import 'package:psa/widget/constants.dart';

class Official extends StatefulWidget {
  const Official({Key? key}) : super(key: key);
  static const routeName = '/official';

  @override
  _OfficialState createState() => _OfficialState();
}

class _OfficialState extends State<Official> {
  dynamic _productId;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _productId = ModalRoute.of(context)!.settings.arguments as String;
    }
    _isInit = false;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(_productId),
      ),
      body: Container(
        width: width,
        height: height,
        decoration:  const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(kkbackgroundImage),
              fit: BoxFit.cover,
            )
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('User').snapshots(),
            builder: (ctx, grpMemSnapshot){
              if (grpMemSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final grpMembers = grpMemSnapshot.data!.docs;
              //print(grpMembers[0]['Official SportList']['Official BasketBall']);
              return ListView.builder(
                itemCount: grpMembers.length,
                itemBuilder: (ctx,index) {
                  return grpMembers[index]['Official SportList'][_productId]==1?
                  IsOfficial(onTap: (){
                    Map<String,dynamic> s=grpMembers[index]['Official SportList'];
                    s[_productId]=2;
                    FirebaseFirestore.instance.collection('User')
                        .doc(grpMembers[index]['uid']).update({
                    'Official SportList':s,
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
                      '${grpMembers[index]['name']}  is now part of '
                          'the $_productId Team !!!'
                    )));
                    Navigator.pop(context);
                  } ,
                      viewProfile: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return OtherUserProfileScreeen(
                                uid: grpMembers[index]['uid'],
                              );
                            }));
                      },
                      name: grpMembers[index]['name'],
                      misId: grpMembers[index]['misId'],
                      image: grpMembers[index]['photourl'])
                      :Container();
                },
              );
            }
        ),
      ),
    );
  }
}

class IsOfficial extends StatelessWidget {
  final String image,name,misId;
  final VoidCallback onTap,viewProfile;
  const IsOfficial({Key? key,
    required this.viewProfile,
    required this.onTap,
    required this.name,
    required this.misId,
    required this.image,
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: width,
        //height: 200,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            const SizedBox(width: 10,),
            CircleAvatar(
              backgroundImage: NetworkImage(image),
              radius: 25,
            ),
            const SizedBox(width: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                ),),
                Text(misId,style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),),
                Row(
                  children: [
                    FlatButton(onPressed: viewProfile,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'View Profile',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        )),
                    FlatButton(onPressed: onTap,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Accept',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        )),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

