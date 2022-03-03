import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_oauth/firebase_auth_oauth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:psa/screens/login_signUp/signUp_screen.dart';

class Authentication
{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;

  //SIGN OUT METHOD
  Future signOut(context) async {
    await GoogleSignIn().disconnect();
    FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => Signup()),
            (route) => false);
  }

  //google sign in
  Future signInWithGoogle(context) async {
    late final bool isuser;
    try {
      UserCredential userCredential;
      if (kIsWeb) {
        var googleProvider = GoogleAuthProvider();
        userCredential = await _auth.signInWithPopup(googleProvider);
      } else {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
        final googleAuthCredential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        userCredential = await _auth.signInWithCredential(googleAuthCredential);
        isuser = userCredential.additionalUserInfo!.isNewUser;
      }
      return isuser;
    } catch (e) {
      return e;
    }
  }

  /*
  *  //google sign in
  Future signInWithGoogle(context) async {
    print('starting');
    late final isuser;
    try {
      // ignore: unused_local_variable
      UserCredential userCredential;
      if (kIsWeb) {
        var googleProvider = GoogleAuthProvider();
        userCredential = await _auth.signInWithPopup(googleProvider);
      } else {
        print('ggooggle');
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
        final googleAuthCredential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        userCredential = await _auth.signInWithCredential(googleAuthCredential);
        isuser = userCredential.additionalUserInfo!.isNewUser;
        //isLogined();

        if (UserDetails.uid!=userCredential.user?.uid){
          FirebaseFirestore.instance
              .collection('User')
              .doc(userCredential.user?.uid).set({
            'email': userCredential.user?.email,
            'name':userCredential.user?.displayName,
            'photourl':userCredential.user?.photoURL,
            'uid':userCredential.user?.uid,
          });
          UserDetails.uid=userCredential.user?.uid;
          UserDetails.email=userCredential.user?.email;
          UserDetails.photourl=userCredential.user?.photoURL;
          UserDetails.name=userCredential.user?.displayName;
          print('eyyy');
        }else{
          print('Already a user!');
          FirebaseFirestore.instance
              .collection('User')
              .doc(UserDetails.uid)
              .update({
            'misId':UserDetails.misId,
            'SportList': UserDetails.sportList,
          });
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
            return IntialScreen();
          }));
        }

      }
      return isuser;

    } catch (e) {
      return e;
    }
  }
  * */

  //microsoft sign in
  Future microsoftSignIn(String provider, List<String> scopes,
      Map<String, String> parameters) async {
    bool isNewUser = false;
    User? user;
    try {
      user = await FirebaseAuthOAuth()
          .openSignInFlow(provider, scopes, parameters);
      String lastSignInTime = user!.metadata.lastSignInTime.toString();
      String creationTime = user.metadata.creationTime.toString();
      lastSignInTime = lastSignInTime.substring(0, lastSignInTime.length - 7);
      creationTime = creationTime.substring(0, creationTime.length - 7);

      if (lastSignInTime == creationTime) {
        isNewUser = true;
      }
      return isNewUser;
    } on PlatformException catch (error) {

      return error;
    }
  }


}