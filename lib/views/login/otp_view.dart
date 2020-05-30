import 'package:covid_care_app/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:stacked/stacked.dart';

import 'otp_view_model.dart';

class OTPView extends StatelessWidget {
  final String verificationId;

  const OTPView({Key key, @required this.verificationId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OTPViewModel>.reactive(
        viewModelBuilder: () => OTPViewModel(),
        builder: (context, model, child) => Scaffold(
                  appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: kPrimaryColor500,
                ),
              );
            },
          ),
        ),
              body: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    children: <Widget>[
                      // Container(
                      //   height: MediaQuery.of(context).size.height / 3,
                      //   child: FlareActor(
                      //     "assets/otp.flr",
                      //     animation: "otp",
                      //     fit: BoxFit.fitHeight,
                      //     alignment: Alignment.center,
                      //   ),
                      // ),
                      Image.asset(
                        'assets/images/OTP Enter.png',
                        height: MediaQuery.of(context).size.height / 3,
                        fit: BoxFit.fitHeight,
                      ),
                      //Image.asset('assets/images/OTP Enter.png'),
                      SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'Phone Number Verification',
                          style: Theme.of(context).textTheme.headline5,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 8),
                        child: RichText(
                          text: TextSpan(
                              text: "Enter the code sent to ",
                              children: [
                                TextSpan(
                                    text: "+91 9163885258",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15)),
                              ],
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 15)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 30),
                          child: PinCodeTextField(
                            length: 6,
                            obsecureText: false,
                            autoFocus: false,
                            animationType: AnimationType.fade,
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.underline,
                              //borderRadius: BorderRadius.circular(5),
                              fieldHeight: 50,
                              fieldWidth: 40,
                              activeFillColor:
                                  model.hasError ? Colors.orange : Colors.white,
                            ),
                            animationDuration: Duration(milliseconds: 300),
                            //backgroundColor: Colors.blue.shade50,
                            //enableActiveFill: true,
                            errorAnimationController: model.errorController,
                            controller: model.textEditingController,
                            onCompleted: (v) {
                              print("Completed");
                              model.verifyOTPAndLogin(smsCode: model.currentText, actualCode: verificationId);
                            },
                            onChanged: (value) {
                              print(value);
                              model.currentText = value;
                              // setState(() {
                              //   currentText = value;
                              // });
                            },
                            beforeTextPaste: (text) {
                              print("Allowing to paste $text");
                              //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                              //but you can show anything you want here, like your pop up saying wrong paste format or etc
                              return true;
                            },
                          )),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Text(
                          model.hasError
                              ? "*Please fill up all the cells properly"
                              : "",
                          style: TextStyle(
                              color: Colors.red.shade300, fontSize: 15),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: "Didn't receive the code? ",
                            style:
                                TextStyle(color: Colors.black54, fontSize: 15),
                            children: [
                              TextSpan(
                                  text: " RESEND",
                                  //recognizer: onTapRecognizer,
                                  style: TextStyle(
                                      color: Color(0xFF91D3B3),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16))
                            ]),
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 30),
                        child: ButtonTheme(
                          height: 50,
                          child: FlatButton(
                            onPressed: () {
                              // conditions for validating
                              if (model.currentText.length != 6 ||
                                  model.currentText != "towtow") {
                                model.errorController.add(ErrorAnimationType
                                    .shake); // Triggering error shake animation
                                model.hasError = true;
                              } else {
                                model.hasError = false;
                                model.verifyOTPAndLogin(smsCode: model.currentText, actualCode: verificationId);
                                // setState(() {
                                //   hasError = false;
                                //   scaffoldKey.currentState.showSnackBar(SnackBar(
                                //     content: Text("Aye!!"),
                                //     duration: Duration(seconds: 2),
                                //   ));
                                // });
                              }
                            },
                            child: Center(
                                child: Text(
                              "VERIFY".toUpperCase(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.deepPurple.shade200,
                                  offset: Offset(1, -2),
                                  blurRadius: 5),
                              BoxShadow(
                                  color: Colors.deepPurple.shade200,
                                  offset: Offset(-1, 2),
                                  blurRadius: 5)
                            ]),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FlatButton(
                            child: Text("Clear"),
                            onPressed: () {
                              model.textEditingController.clear();
                            },
                          ),
                          FlatButton(
                            child: Text("Set Text"),
                            onPressed: () {
                              model.textEditingController.text = "1234";
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}
