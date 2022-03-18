import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:psa/widget/constants.dart';

class GymScreen extends StatelessWidget {
  const GymScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            decoration: const BoxDecoration(image:
            DecorationImage(image: AssetImage(kkbackgroundImage),
                fit:BoxFit.fitHeight)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
              child: Column(
                children: <Widget>[
                  Container(
                    height: height * 0.11,
                    width: double.infinity,
                    child: Row(
                      children: <Widget>[
                        IconButton(
                            onPressed: () => {Navigator.pop(context)},
                            icon: const Icon(Icons.arrow_back)),
                        SizedBox(
                          width: width * 0.3,
                        ),
                        const Center(
                            child: Text(
                              'Gym',
                              style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )),
                      ],
                    ),
                    decoration: const BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(35),
                            bottomRight: Radius.circular(35))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                      'Timings :  ☀ 8 am - 4 pm \t |  🌙 7 pm - 9 pm',
                      style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 18,
                          color: Colors.grey[900]!.withOpacity(1),
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    ' Equipments🏋️‍♀️ ',
                    style: TextStyle(color: Colors.indigo[900]!.withOpacity(1),fontFamily:'Righteous',fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Container(
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(25),
                              topLeft: Radius.circular(25)),
                        ),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(0, 10, 5, 0),
                          width: double.infinity,
                          height: height * 0.60,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(25))),

                          //child:SvgPicture.asset('assets/ellipse7.svg',color: Colors.green,height: 10,width: 25,)

                          child: ListView(
                            physics: const BouncingScrollPhysics(),
                              children: <Widget>[

                            const Rightile('Treadmill',
                                'A large wheel turned by the weight of pe'
                                    'ople or animals treading on steps fitted i'
                                    'nto its inner surface, formerly used to'
                                    ' drive machinery.', 'https://rukminim2.flixcart.com/image/612/612/kt8zb0w0/treadmill/1/r/8/majesty-s1-treadmill-with-massager-2hp-peak-multipurpose-original-imag6n4ghnsgmump.jpeg?q=70'),
                            const SizedBox(height: 60),
                            Left_tile('Weights', 'Weight training can help you ton'
                                'e your muscles, improve your appearance and fight'
                                ' age-related muscle loss', 'https://hips.hearstapps.com/vader-prod.s3.amazonaws.com/1554130528-51Fv11O8HZL.jpg?crop=1.00xw:0.948xh;0,0.00200xh&resize=480:*'),
                            const SizedBox(height: 60),
                                const Rightile('Treadmill',
                                    'A large wheel turned by the weight of pe'
                                        'ople or animals treading on steps fitted i'
                                        'nto its inner surface, formerly used to'
                                        ' drive machinery.', 'https://rukminim2.flixcart.com/image/612/612/kt8zb0w0/treadmill/1/r/8/majesty-s1-treadmill-with-massager-2hp-peak-multipurpose-original-imag6n4ghnsgmump.jpeg?q=70'),
                                const SizedBox(height: 60),
                                Left_tile('Weights', 'Weight training can help you ton'
                                    'e your muscles, improve your appearance and fight'
                                    ' age-related muscle loss', 'https://hips.hearstapps.com/vader-prod.s3.amazonaws.com/1554130528-51Fv11O8HZL.jpg?crop=1.00xw:0.948xh;0,0.00200xh&resize=480:*'),
                                const SizedBox(height: 60),
                          ]), //*/
                        )),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class Rightile extends StatelessWidget {
  const Rightile( this.name,
      this.description,
      this.img);
  final String name,description,img;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.222,
      width: width * 0.6,
      decoration: BoxDecoration(
          color: Colors.grey[600]!.withOpacity(0.5),
          borderRadius: const BorderRadius.all(Radius.circular(150))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          const SizedBox(
            width: 10,
          ),
          equipments(name, description),
          const SizedBox(
            width: 10,
          ),
          Stack(
              alignment: Alignment.center,
              children:<Widget>[
                CircleAvatar(radius: 70
                  ,backgroundColor: Colors.grey[800],),
                CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(img),
                ),
              ])
        ],
      ),
    );
  }
}

class Left_tile extends StatelessWidget {
  Left_tile(this.name, this.description, this.img);
  String name;
  String description;
  String img;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.222,
      width: width * 0.6,
      decoration: BoxDecoration(
          color: Colors.deepPurple[300]!.withOpacity(0.6),
          borderRadius: const BorderRadius.all(Radius.circular(150))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.hardEdge,
              children:<Widget>[
                CircleAvatar(
                  radius: 75,
                  backgroundColor: Colors.deepPurple[600],
                ),
                CircleAvatar(radius: 60,backgroundImage: NetworkImage(img) ,)]
          ),
          const SizedBox(
            width: 10,
          ),
          equipments(name, description),
        ],
      ),
    );
  }
}

class equipments extends StatelessWidget {
  equipments(this.name, this.description);
  String name;
  String description;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: height * 0.198,
      width: width * 0.47,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(
              child: Text(
                name,
                style: const TextStyle(fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              )),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(fontSize: 15,

                fontFamily:'Righteous'),
          )
        ],
      ),
    );
  }
}
