import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:psa/screens/login_signUp/userInfo_screen.dart';
import 'package:psa/services/authentication.dart';
import 'package:psa/services/getUserData.dart';

import 'background_image.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String misId = '';
  @override
  Widget build(BuildContext context) {
    /*
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    */
    return SafeArea(
      child: Scaffold(
        body: Background(),
        /*
        appBar: AppBar(
          toolbarHeight: 100,
          centerTitle: true,
          backgroundColor: Colors.white,
          title: const Text("WelCome PICT'ians",style: TextStyle(
            color: Colors.black,fontSize: 28,
            fontWeight: FontWeight.w600,
          ),),
          elevation: 0,
        ),
        color: Colors.black,fontSize: 20,
        fontWeight: FontWeight.w100,
        backgroundColor: Colors.white,

          SingleChildScrollView(
            child:
            Column(
              children: [
                Container(
                  height: height * 0.45,
                  width: width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/logo1.png'),
                    ),
                  ),
                ),
                const Text('Welcome to ',style: TextStyle(
                  color: Color(0xFF303F9F),
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                ),),
                const Text('PICT SPORT APP',style: TextStyle(
                  color: Color(0xFF1A237E),
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
                ),
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Authentication().signInWithGoogle(context).then((result) {
                      if (result == false) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GetUserData()));
                      } else if (result == true) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserInfo()));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            result,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ));
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30,right: 30),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),

                      ),
                  child: Container(
                    height: 100,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(23),
                      border: Border.all(color: Colors.blueAccent),
                    ),
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.all(18.0),
                        //   child: Container(
                        //     height: 90,
                        //     width: 90,
                        //     child: Lottie.network(
                        //         'https://assets4.lottiefiles.com/private_files/lf30_29gwi53x.json'),
                        //   ),
                        // ),
                        // const SizedBox(width: 15,),

                      ],
                    ),
                  ),
                ),
                ),
                ),
              ],
            ),
          ),
          */
      ),
    );
  }
}
