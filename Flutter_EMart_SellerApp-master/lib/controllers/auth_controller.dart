import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../const/const.dart';

class AutheController extends GetxController {
  var isloading = false.obs;
  //textcontrollers
  var emaileController = TextEditingController();
  var passwordeController = TextEditingController();

  //login method
  Future<UserCredential?> loginiMethod({context}) async {
    UserCredential? vendorCredential;

    try {
      vendorCredential = await auth.signInWithEmailAndPassword(
          email: emaileController.text, password: passwordeController.text);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return vendorCredential;
  }

  //signout method
  signoutMethod(context) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}
