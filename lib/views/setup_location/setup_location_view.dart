import 'package:covid_care_app/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'setup_location_view_model.dart';

class SetupLocationView extends StatelessWidget {
  const SetupLocationView({Key key}) : super(key: key);

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
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Image.asset('assets/images/People Network.png'),
              Text('Privately Connect',
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.headline4),
              //SizedBox(height: 30.0),
              Text(
                'The app uses GPS to collect data when other phones with Covid Care apps are nearby. The generated Location information stays on your phone.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              //SizedBox(height: 30.0),
              CupertinoButton.filled(
                onPressed: () {},
                child: Text(
                  'Allow Location'.toUpperCase(),
                  style: Theme.of(context).textTheme.button,
                ),
              ),
              Text(
                'This is required for the app to work.',
                style: Theme.of(context).textTheme.subtitle2,
              )
            ],
          ),
        ),
      ),
      viewModelBuilder: () => SetupLocationViewModel(),
    );
  }
}
