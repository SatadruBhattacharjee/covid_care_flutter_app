import 'package:covid_care_app/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'setup_notification_view_model.dart';

class SetupNotificationView extends StatelessWidget {
  const SetupNotificationView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.nonReactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.virus,
                  color: kPrimaryColor500,
                ),
              );
            },
          ),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Image.asset('assets/images/Phone Alerts.png'),
              Text('Receive Alerts',
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.headline4),
              Text(
                'Enable Notification to receive anonymous alerts if you have come into a contact with a confirmed case of Covid-19.',
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              CupertinoButton.filled(
                onPressed: () {},
                child: Text(
                  'Allow Notification'.toUpperCase(),
                  style: Theme.of(context).textTheme.button,
                ),
              ),
              Text(
                'Helps you to get exposure notification.',
                style: Theme.of(context).textTheme.subtitle2,
              )
            ],
          ),
        ),
      ),
      viewModelBuilder: () => SetupNotificationViewModel(),
    );
  }
}
