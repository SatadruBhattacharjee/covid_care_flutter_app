import 'package:covid_care_app/theme/colors.dart';
import 'package:covid_care_app/views/report/test_report_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:stacked/stacked.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'test_report_view_model.dart';

class TestReportView extends StatelessWidget {
  const TestReportView({Key key}) : super(key: key);

  List<Widget> getSelectionButtons(
      BuildContext context, TestReportViewModel model) {
    List<Widget> widgets = [
      Column(
        children: [
          ButtonTheme(
            minWidth: double.maxFinite,
            height: 58.0,
            child: OutlineButton(
              onPressed: () {
                model.reportState = TestReportState.Nagative;
              },
              borderSide: new BorderSide(
                width: 2.0,
              ),
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
          SizedBox(height: 20),
          ButtonTheme(
            minWidth: double.maxFinite,
            height: 58.0,
            child: OutlineButton(
              onPressed: () {
                model.reportState = TestReportState.Positive;
              },
              borderSide: new BorderSide(
                width: 2.0,
              ),
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(5.0)),
              child: Text(
                "YES, Tested Positive".toUpperCase(),
                style: Theme.of(context).textTheme.button.apply(
                      color: Color(0xFF686868),
                    ),
              ),
            ),
          ),
        ],
      ),
    ];

    return widgets;
  }

  List<Widget> getTestedNegativeButtons(
      BuildContext context, TestReportViewModel model) {
    List<Widget> widgets = [
      Column(
        children: [
          ButtonTheme(
            minWidth: double.maxFinite,
            height: 58.0,
            child: OutlineButton.icon(
              onPressed: () {
                model.reportState = TestReportState.Nagative;
              },
              label: new Text("Not Tested or Negative".toUpperCase()),
              icon: Icon(Icons.check_box),
              color: Colors.green,
              borderSide: new BorderSide(width: 2.0, color: Colors.green),
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(5.0),
              ),
            ),
          ),
          SizedBox(height: 20),
          ButtonTheme(
            minWidth: double.maxFinite,
            height: 58.0,
            child: OutlineButton(
              onPressed: () {
                model.reportState = TestReportState.Positive;
              },
              borderSide: new BorderSide(
                width: 2.0,
              ),
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(5.0)),
              child: Text(
                "YES, Tested Positive".toUpperCase(),
                style: Theme.of(context).textTheme.button.apply(
                      color: Color(0xFF686868),
                    ),
              ),
            ),
          ),
        ],
      ),
      Column(
        children: [
          SizedBox(
            height: 60,
          ),
          Text(
            'Thanks for the update. You can come back here if you test positive to help keep your community safe.',
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.subtitle1.apply(
                  color: Color(0xFF585858),
                ),
          ),
          SizedBox(
            height: 30,
          ),
          CupertinoButton.filled(
            onPressed: () {
              //model.setCompleteSetupStepFinish();
            },
            child: SizedBox(
              width: double.infinity,
              child: Text(
                'Continue'.toUpperCase(),
                style: Theme.of(context).textTheme.button,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    ];

    return widgets;
  }

  List<Widget> getTestedPositiveButtons(
      BuildContext context, TestReportViewModel model) {
    List<Widget> widgets = [
      Column(
        children: [
          ButtonTheme(
            minWidth: double.maxFinite,
            height: 58.0,
            child: OutlineButton(
              onPressed: () {
                model.reportState = TestReportState.Nagative;
              },
              borderSide: new BorderSide(
                width: 2.0,
              ),
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
          SizedBox(height: 20),
          ButtonTheme(
            minWidth: double.maxFinite,
            height: 58.0,
            child: OutlineButton.icon(
              onPressed: () {
                model.reportState = TestReportState.Positive;
              },
              label: new Text("Yes, Tested Positive".toUpperCase()),
              icon: Icon(Icons.check_box),
              color: Colors.redAccent,
              borderSide: new BorderSide(width: 2.0, color: Colors.redAccent),
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(5.0),
              ),
            ),
          ),
        ],
      ),
      SizedBox(
        height: 50,
      ),
      Column(
        children: [
          Text(
            'When did your symptoms start?',
            style: Theme.of(context).textTheme.subtitle2,
          ),
          SizedBox(
            height: 30,
          ),
          ButtonTheme(
            minWidth: double.maxFinite,
            height: 58.0,
            child: OutlineButton(
              onPressed: () async {
                DateTime selectedDate = await getPositiveReportDate(context);
                if (selectedDate != null) {
                  model.reportDate = selectedDate;
                }
              },
              borderSide: new BorderSide(
                width: 1.0,
              ),
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(5.0)),
              child: Text(
                model.getReportDate(),
                style: Theme.of(context).textTheme.button.apply(
                      color: Color(0xFF686868),
                    ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          CupertinoButton.filled(
            onPressed: () {
              //model.setCompleteSetupStepFinish();
            },
            child: SizedBox(
              width: double.infinity,
              child: Text(
                'Report'.toUpperCase(),
                style: Theme.of(context).textTheme.button,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'By clicking "Report", you acknowledge, understand and further agree to our Privacy Policy and Terms & Conditions.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle2.apply(
                  color: Color(0xFF585858),
                ),
          ),
        ],
      ),
    ];

    return widgets;
  }

  List<Widget> getButtonsState(
      TestReportState state, BuildContext context, TestReportViewModel model) {
    switch (state) {
      case TestReportState.Initial:
        return getSelectionButtons(context, model);
      case TestReportState.Nagative:
        return getTestedNegativeButtons(context, model);
      case TestReportState.Positive:
        return getTestedPositiveButtons(context, model);
      default:
        return getSelectionButtons(context, model);
    }
  }

  Future<DateTime> getPositiveReportDate(BuildContext context) {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: Jiffy().subtract(days: 21),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
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
          actions: <Widget>[
            // action button
            IconButton(
              icon: Icon(Icons.close),
              color: Color(0xFF686868),
              onPressed: () {
                model.closePage();
              },
            ),
          ]
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Text(
                'Have you tested positive for COVID-19?',
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(
                height: 50,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: getButtonsState(model.reportState, context, model),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => TestReportViewModel(),
    );
  }
}
