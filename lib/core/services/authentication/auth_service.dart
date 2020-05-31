import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

enum PhoneAuthState {
  Started,
  CodeSent,
  CodeResent,
  Verified,
  Failed,
  Error,
  AutoRetrievalTimeOut
}

@lazySingleton
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Function _onCodeSentCallback;
  Function _onVerifiedCallback;
  Function _onAutoRetrievalTimeOutCallback;
  Function _onErrorCallback;
  Function _onFailedCallback;

  PhoneAuthState _onVerificationFailed(AuthException authException) {
    print('[AuthService] onVerificationFailed ${authException.message}');
    if (_onFailedCallback != null) _onFailedCallback();
    if (authException.message.contains('not authorized'))
      print('[AuthService] App not authroized');
    else if (authException.message.contains('Network'))
      print(
          '[AuthService] Please check your internet connection and try again');
    else
      print('[AuthService] Something has gone wrong, please try later ' +
          authException.message);

    return PhoneAuthState.Failed;
  }

  Future<PhoneAuthState> _onVerificationCompleted(AuthCredential auth) async {
    print('[AuthService] Auto retrieving verification code');
    return _auth.signInWithCredential(auth).then((AuthResult value) {
      if (value.user != null) {
        print('[AuthService] Authentication successful');
        if (_onVerifiedCallback != null) _onVerifiedCallback();
        return PhoneAuthState.Verified;
      } else {
        print('[AuthService] Invalid code/invalid authentication');
        if (_onErrorCallback != null) _onErrorCallback();
        return PhoneAuthState.Failed;
      }
    }).catchError((error) {
      print('[AuthService] Something has gone wrong, please try later $error');
      if (_onErrorCallback != null) _onErrorCallback();
      return PhoneAuthState.Error;
    });
  }

  Future<PhoneAuthState> verifyPhoneNumber({
    @required String phoneNumber,
    @required Function onCodeSentCallback,
    @required Function onVerifiedCallback,
    @required Function onAutoRetrievalTimeOutCallback,
    @required Function onErrorCallback,
    @required Function onFailedCallback,
  }) {
    _onCodeSentCallback = onCodeSentCallback;
    _onVerifiedCallback = onVerifiedCallback;
    _onAutoRetrievalTimeOutCallback = onAutoRetrievalTimeOutCallback;
    _onErrorCallback = onErrorCallback;
    _onFailedCallback = onFailedCallback;

    return _auth
        .verifyPhoneNumber(
            phoneNumber: phoneNumber,
            timeout: Duration(seconds: 120),
            verificationCompleted: _onVerificationCompleted,
            verificationFailed: _onVerificationFailed,
            codeSent: _onCodeSentCallback,
            codeAutoRetrievalTimeout: _onAutoRetrievalTimeOutCallback)
        .then((value) {
      if (_onCodeSentCallback != null) _onCodeSentCallback('');
      print('[AuthService] Code sent');
      return PhoneAuthState.CodeSent;
    }).catchError((error) {
      if (_onErrorCallback != null) _onErrorCallback();
      print('[AuthService] Error $error.toString()');
      return PhoneAuthState.Error;
    });
  }

  Future<PhoneAuthState> verifyOTPAndLogin(
      {@required String smsCode, @required String actualCode}) async {
    AuthCredential _authCredential = PhoneAuthProvider.getCredential(
        verificationId: actualCode, smsCode: smsCode);

    return _auth
        .signInWithCredential(_authCredential)
        .then((AuthResult result) async {
      print('[AuthService] Authentication successful');
      return PhoneAuthState.Verified;
    }).catchError((error) {
      print(
          '[AuthService] Something has gone wrong, please try later(signInWithPhoneNumber) $error');
      return PhoneAuthState.Error;
    });
  }

  Future<bool> isUserLogged() async {
    FirebaseUser firebaseUser = await getLoggedFirebaseUser();
    if (firebaseUser != null) {
      IdTokenResult tokenResult = await firebaseUser.getIdToken(refresh: true);
      return tokenResult.token != null;
    } else {
      return false;
    }
  }

  Future<FirebaseUser> getLoggedFirebaseUser() {
    return _auth.currentUser();
  }
}
