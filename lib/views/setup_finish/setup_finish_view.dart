import 'package:covid_care_app/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'setup_finish_view_model.dart';

class SetupFinishView extends StatelessWidget {
  const SetupFinishView({Key key}) : super(key: key);

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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Image.asset('assets/images/Family.png'),
                Text('You’re all set!',
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.headline4),
                SizedBox(height: 10),
                Text(
                  'Thank you for helping protect your communities. You will be notified of potential exposure to COVID-19.',
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(height: 15),
                CupertinoButton.filled(
                  onPressed: () {
                    model.setCompleteSetupStepFinish();
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Get Started'.toUpperCase(),
                      style: Theme.of(context).textTheme.button,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'It works best when everyone uses it.',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                SizedBox(height: 10),
                CupertinoButton.filled(
                  onPressed: () {},
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Tested for COVID-19?'.toUpperCase(),
                      style: Theme.of(context).textTheme.button,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Share your result anonymously to help your community stay safe.',
                  style: Theme.of(context).textTheme.subtitle2,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => SetupFinishViewModel(),
    );
  }
}
