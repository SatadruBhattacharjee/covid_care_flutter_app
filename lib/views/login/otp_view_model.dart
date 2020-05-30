import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:stacked/stacked.dart';

class OTPViewModel extends BaseViewModel {
  final TextEditingController textEditingController = TextEditingController();
  final StreamController<ErrorAnimationType> errorController = StreamController<ErrorAnimationType>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool _hasError = false;
  String _pin;

  String get currentText => _pin;
  bool get hasError => _hasError;

  set currentText(String value) {
    _pin = value;
    notifyListeners();
  }

  set hasError(bool value) {
    _hasError = value;
    notifyListeners();
  }

  void verifyOTPAndLogin({String smsCode, String actualCode}) async {
    var _authCredential = PhoneAuthProvider.getCredential(
        verificationId: actualCode, smsCode: smsCode);

    _auth
        .signInWithCredential(_authCredential)
        .then((AuthResult result) async {
      print('Authentication successful');
      //_addStatus(PhoneAuthState.Verified);
      //if (onVerified != null) onVerified();
    }).catchError((error) {
      print(
          'Something has gone wrong, please try later(signInWithPhoneNumber) $error');
      // if (onError != null) onError();
      // _addStatus(PhoneAuthState.Error);
      // print(
      //     'Something has gone wrong, please try later(signInWithPhoneNumber) $error');
    });
  }
}
