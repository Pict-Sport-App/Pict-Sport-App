import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:psa/widget/constants.dart';

class PrivatePage extends StatefulWidget {
  const PrivatePage({Key? key}) : super(key: key);

  @override
  _PrivatePageState createState() => _PrivatePageState();
}

class _PrivatePageState extends State<PrivatePage> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      width: deviceWidth,
      height: deviceHeight,
     // color: Colors.white,
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage(kkbackgroundImage,
          ),fit: BoxFit.cover
        )
      ),
      child: DefaultTabController(
        length: 2,
        child: Column(children: [
          Container(
            padding: EdgeInsets.fromLTRB(deviceWidth * .05, deviceWidth * .15,
                deviceWidth * .05, deviceWidth * .05),
            color: Colors.white,
            child: Column(
              children: [
               // const SizedBox(height: 45),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  child: Container(
                    width: deviceWidth * .85,
                    height: deviceWidth * .115,
                    // padding: EdgeInsets.symmetric(vertical: deviceWidth* .015),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TabBar(
                      isScrollable: false,
                      labelColor: Colors.black,
                      indicatorColor: Colors.white,
                      indicator: BoxDecoration(
                          color: const Color(0xFF517294),
                          borderRadius: BorderRadius.circular(25)),
                      tabs: const [
                        Tab(
                          child: Text(
                            'Admin',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                                fontSize: 16),
                          ),
                        ),
                        Tab(
                            child: Text('Request',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    fontSize: 16)))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: TabBarView(
            children: [
               StreamBuilder<QuerySnapshot>(
                 stream: FirebaseFirestore.instance.collection('User').snapshots(),
                 builder: (ctx,userSnapshot){
                   if (userSnapshot.connectionState == ConnectionState.waiting) {
                     return const Center(
                       child: CircularProgressIndicator(),
                     );
                   }
                   final usersnap = userSnapshot.data!.docs;
                   return ListView.builder(
                     itemCount: usersnap.length,
                       itemBuilder: (ctx,index)=>
                   usersnap[index]['isAdmin']?
                       AdminWidget(misId: usersnap[index]['misId'],
                           name: usersnap[index]['name'],
                           url: usersnap[index]['photourl']):Container());
                 },
               ),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('AdminRequest').
                snapshots(),
                builder: (ctx, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final usersnap = userSnapshot.data!.docs;
                  return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: usersnap.length,
                      itemBuilder: (ctx, index) =>
                      usersnap[index]['accept']?Container():
                          AdminRequestWidget(
                              misId: usersnap[index]['misId'],
                              name: usersnap[index]['name'],
                              url: usersnap[index]['photoUrl'],
                              number: usersnap[index]['whatappnumber']
                            , onTap: ()async {
                                await FirebaseFirestore.instance
                                    .collection('User')
                                    .doc(usersnap[index]['uid'])
                                    .update({
                                  'isAdmin':true,
                                });
                               await FirebaseFirestore.instance
                                .collection('AdminRequest')
                                .doc(usersnap[index]['uid'])
                                .update({
                                  'accept':true,
                                });
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
                                Text(
                                  '${usersnap[index]['name']} having misId ${usersnap[index]['misId']} '
                                      'has been made Admin successfully'
                                )));
                                Navigator.pop(context);
                          },)
                  );
                },
              )
            ],
          )),
        ]),
      ),
    );
  }
}


class AdminWidget extends StatelessWidget {
  final String name,url,misId;
  const AdminWidget({Key? key,required this.misId,
  required this.name,
  required this.url}): super(key: key);

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: width-20,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(url),
              radius: 20,
            ),
            const SizedBox(width: 30,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8,),
                  child: Text(name,style: const TextStyle(
                      fontSize: 15
                  ),),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5,bottom: 8),
                  child: Text(misId,style: const TextStyle(
                      fontSize: 15
                  )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}


class AdminRequestWidget extends StatelessWidget {
  final String url,name,misId,number;
  final VoidCallback onTap;


  const AdminRequestWidget({Key? key, required this.misId,
    required this.onTap,
    required this.name,
    required this.url,
    required this.number,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: width,
        //height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey[100],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(url),
              radius: 20,
            ),
            const SizedBox(width: 30,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8,),
                  child: Text(name,style: const TextStyle(
                      fontSize: 15
                  ),),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5,bottom: 8),
                  child: Text(misId,style: const TextStyle(
                      fontSize: 15
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(onPressed: onTap,
                    child: const Text('Accept'),),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
