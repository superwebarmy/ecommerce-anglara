import 'package:ecommerce/View/AuthPage.dart';
import 'package:ecommerce/View/Dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthProvider extends ChangeNotifier {

  bool isLoadingLogin = false;
  bool isLoadingRegister = false;
  final _auth = FirebaseAuth.instance;

  void login(BuildContext context, String email, String password) async {
    try{
      isLoadingLogin = true;
      notifyListeners();
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      if(userCredential.user != null){
        isLoadingLogin = false;
        notifyListeners();
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Dashboard()));
      }
    } on FirebaseAuthException catch(e){
      isLoadingLogin = false;
      notifyListeners();
      if(e.code == 'invalid-email'){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('EMAIL INVALID', style: GoogleFonts.oswald()), backgroundColor: Colors.black));
      }
      if(e.code == 'user-not-found'){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('USER NOT FOUND', style: GoogleFonts.oswald()), backgroundColor: Colors.black));
      }
      if(e.code == 'wrong-password'){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('PASSWORD IS INCORRECT', style: GoogleFonts.oswald()), backgroundColor: Colors.black));
      }
    }
  }

  void register(BuildContext context, String email, String password) async {
    try{
      isLoadingRegister = true;
      notifyListeners();
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      if(userCredential.user != null){
        isLoadingRegister = false;
        notifyListeners();
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Dashboard()));
      }
    } on FirebaseAuthException catch(e){
      isLoadingRegister = false;
      notifyListeners();
      if(e.code == 'invalid-email'){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('EMAIL INVALID', style: GoogleFonts.oswald()), backgroundColor: Colors.black));
      }
      if(e.code == 'email-already-in-use'){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('EMAIL ALREADY IN USE', style: GoogleFonts.oswald()), backgroundColor: Colors.black));
      }
      if(e.code == 'weak-password'){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('PASSWORD IS WEAK', style: GoogleFonts.oswald()), backgroundColor: Colors.black));
      }
    }
  }

  void logout(BuildContext context) async {
    await _auth.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const AuthPage()));
  }

}