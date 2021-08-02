import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:time_tracker/app/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Moved all authenticate code inside the class

class SignInManager {
  SignInManager({@required this.auth, @required this.isLoading});
  final AuthBase auth;
  final ValueNotifier<bool> isLoading;

  Future<User> _signIn(Future<User> Function() signInMethod) async {
    try {
      isLoading.value = true;
      return await signInMethod();
    } catch (e) {
      isLoading.value = false;
      //when sign in succeed, we don't need to do this because the signing page will be replaced by the home page anyway
      rethrow;
    }
  }

  //we can pass functions as input arguments to other functions
  Future<User> signInAnonymously() async => _signIn(auth.signInAnonymously);

  Future<User> signInWithGoogle() async => _signIn(auth.signInWithGoogle);

  Future<User> signInWithFacebook() async => _signIn(auth.signInWithFacebook);
}
