import 'package:covid_care_app/views/login/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Image.asset('assets/images/OTP Alert.png'),
              Form(
                key: model.formKey,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InternationalPhoneNumberInput(
                        onInputChanged: model.onMobileNumberInputChange,
                        onInputValidated: (bool value) {
                          print(value);
                        },
                        ignoreBlank: true,
                        autoValidate: false,
                        formatInput: false,
                        inputDecoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Phone Number',
                        ),
                        selectorTextStyle: TextStyle(color: Colors.black),
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        initialValue: model.phoneNumber,
                        textFieldController: model.controller,
                        inputBorder: OutlineInputBorder(),
                      ),
                      RaisedButton(
                        onPressed: () {
                          model.formKey.currentState.validate();
                        },
                        child: Text('Validate'),
                      ),
                    ],
                  ),
                ),
              ),
              CupertinoButton.filled(
                onPressed: () {
                  model.verifyPhoneNumber(model.phoneNumber);
                },
                child: Text(
                  'GET OTP'.toUpperCase(),
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
