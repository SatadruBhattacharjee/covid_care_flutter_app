import 'dart:ffi';

import 'package:covid_care_app/theme/colors.dart';
import 'package:covid_care_app/views/report/test_report_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'test_report_view_model.dart';

class TestReportView extends StatelessWidget {
  const TestReportView({Key key}) : super(key: key);

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
              Text(
                'Have you tested positive for COVID-19?',
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.headline5,
              ),
              ButtonTheme(
                minWidth: double.maxFinite,
                height: 58.0,
                child: OutlineButton(
                  onPressed: () {},
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(5.0)),
                  child: Text(
                    "Not Tested or Negative".toUpperCase(),
                    style: Theme.of(context).textTheme.button.apply(
                          color: Color(0xFF686868),
                        ),
                  ),
                ),
              ),
              ButtonTheme(
                minWidth: double.maxFinite,
                height: 58.0,
                child: OutlineButton.icon(
                  onPressed: () {},
                  label: new Text("Not Tested or Negative".toUpperCase()),
                  icon: Icon(Icons.check_box),
                  color: Colors.green,
                  borderSide: new BorderSide(width: 2.0, color: Colors.green),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(5.0),
                  ),
                ),
              ),
              ButtonTheme(
                minWidth: double.maxFinite,
                height: 58.0,
                child: OutlineButton.icon(
                  onPressed: () {},
                  label: new Text("Yes, Tested Positive".toUpperCase()),
                  icon: Icon(Icons.check_box),
                  color: Colors.redAccent,
                  borderSide: new BorderSide(width: 2.0, color: Colors.redAccent),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(5.0),
                  ),
                ),
              ),
              Text(
                'Thanks for the update. You can come back here if you test positive to help keep your community safe.',
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.subtitle1.apply(
                      color: Color(0xFF585858),
                    ),
              ),
              ButtonTheme(
                minWidth: double.maxFinite,
                height: 58.0,
                child: CupertinoButton.filled(
                  onPressed: () {},
                  child: Text(
                    'Allow Notification'.toUpperCase(),
                    style: Theme.of(context).textTheme.button,
                  ),
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
      viewModelBuilder: () => TestReportViewModel(),
    );
  }
}
