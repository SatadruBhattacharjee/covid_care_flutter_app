import 'package:covid_care_app/core/constants/values.dart';
import 'package:covid_care_app/core/locator.dart';
import 'package:covid_care_app/core/services/authentication/auth_service.dart';
import 'package:covid_care_app/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:stacked/stacked.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _authService = locator<AuthService>();

  PhoneNumber phoneNumber = PhoneNumber(isoCode: Values.PHONE_CODE_INITIAL_COUNTRY);
  FirebaseAuth _auth = FirebaseAuth.instance;

  String _actualCode;

  void onMobileNumberInputChange(PhoneNumber number) {
    print(number.phoneNumber);
    phoneNumber = number;
    //notifyListeners();
  }

  onVerified() async {
    // _showSnackBar(
    //     "${Provider
    //         .of<PhoneAuthDataProvider>(context, listen: false)
    //         .message}");
    // await Future.delayed(Duration(seconds: 1));
    // Navigator.of(context)
    //     .push(MaterialPageRoute(builder: (BuildContext context) => LetsChat()));
    _navigationService.navigateTo(Routes.otpView,
        arguments: OTPViewArguments(verificationId: _actualCode));
  }

  onFailed() {
    // _showSnackBar(phoneAuthDataProvider.message);
    // _showSnackBar("PhoneAuth failed");
  }

  onError() {
    print("on error");
//    _showSnackBar(phoneAuthDataProvider.message);
    // _showSnackBar(
    //     "PhoneAuth error ${Provider
    //         .of<PhoneAuthDataProvider>(context, listen: false)
    //         .message}");
  }

  void onAutoRetrievalTimeOut(String verificationId) {
    print("PhoneAuth autoretrieval timeout");
    _actualCode = verificationId;
    //_showSnackBar("PhoneAuth autoretrieval timeout");
//    _showSnackBar(phoneAuthDataProvider.message);
  }

  void onCodeSent(String verificationId, [int forceResendingToken]) async {
    print("OPT sent");
    _actualCode = verificationId;
    _navigationService.navigateTo(Routes.otpView,
        arguments: OTPViewArguments(verificationId: _actualCode));
    //_showSnackBar("OPT sent");
//    _showSnackBar(phoneAuthDataProvider.message);
  }

  onVerificationFailed(AuthException authException) {
    print('${authException.message}');
    //_addStatus(PhoneAuthState.Failed);
    if (onFailed != null) onFailed();
    if (authException.message.contains('not authorized'))
      print('App not authroized');
    else if (authException.message.contains('Network'))
      print('Please check your internet connection and try again');
    else
      print('Something has gone wrong, please try later ' +
          authException.message);
  }

  onVerificationCompleted(AuthCredential auth) {
    print('Auto retrieving verification code');
    _auth.signInWithCredential(auth).then((AuthResult value) {
      if (value.user != null) {
        print('Authentication successful');
        //_addStatus(PhoneAuthState.Verified);
        if (onVerified != null) onVerified();
      } else {
        if (onFailed != null) onFailed();
        //_addStatus(PhoneAuthState.Failed);
        print('Invalid code/invalid authentication');
      }
    }).catchError((error) {
      if (onError != null) onError();
      //_addStatus(PhoneAuthState.Error);
      print('Something has gone wrong, please try later $error');
    });
  }

  void verifyPhoneNumber(PhoneNumber number) {
    _authService.verifyPhoneNumber(
      phoneNumber: number.phoneNumber,
      onCodeSentCallback: onCodeSent,
      onVerifiedCallback: onVerificationCompleted,
      onAutoRetrievalTimeOutCallback: onAutoRetrievalTimeOut,
      onErrorCallback: onError,
      onFailedCallback: onFailed,
    ).then( (PhoneAuthState phoneAuthState) {
      print('PhoneAuthState: ${phoneAuthState.toString()}');
    });
    // _auth
    //     .verifyPhoneNumber(
    //         phoneNumber: number.phoneNumber,
    //         timeout: Duration(seconds: 120),
    //         verificationCompleted: onVerificationCompleted,
    //         verificationFailed: onVerificationFailed,
    //         codeSent: onCodeSent,
    //         codeAutoRetrievalTimeout: onAutoRetrievalTimeOut)
    //     .then((value) {
    //   if (onCodeSent != null) onCodeSent('');
    //   //_addStatus(PhoneAuthState.CodeSent);
    //   print('Code sent');
    // }).catchError((error) {
    //   if (onError != null) onError();
    //   // _addStatus(PhoneAuthState.Error);
    //   print(error.toString());
    // });
  }
}
