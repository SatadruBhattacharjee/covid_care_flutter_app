import 'package:covid_care_app/theme/colors.dart';
import 'package:covid_care_app/views/report/confirm_report_view_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';
import 'package:stacked/stacked.dart';

class ConfirmReportView extends StatelessWidget {
  const ConfirmReportView({Key key}) : super(key: key);

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
                color: kAppbarActionButtonColor,
                onPressed: () {
                  model.closePage();
                },
              ),
            ]),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
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
              Container(
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                    border: Border.all(color: kBoxContainerBorderColor),
                    borderRadius: BorderRadius.circular(5.0)),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Please confirm your test results',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'This report is completely anonymous and the community relies on you to be truthful and responsible. Depending on anoymous interaction logs, other Covid Watch users may get notified to self-quarantine and get tested.',
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'COVID-19 Test',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'POSITIVE',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .apply(color: Colors.red[400]),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    ConfirmationSlider(
                      //width: double.maxFinite,
                      backgroundShape: BorderRadius.circular(5.0),
                      foregroundShape: BorderRadius.circular(5.0),
                      foregroundColor: kPrimaryColor500,
                      onConfirmation: () {
                        model.confirmed();
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ButtonTheme(
                      minWidth: double.maxFinite,
                      height: 58.0,
                      child: OutlineButton(
                        onPressed: () {},
                        borderSide: new BorderSide(
                            width: 1.0, color: Color(0xFF686868)),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(5.0)),
                        child: Text(
                          "Cancel".toUpperCase(),
                          style: Theme.of(context).textTheme.button.apply(
                                color: Color(0xFF686868),
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      viewModelBuilder: () => ConfirmReportViewModel(),
    );
  }
}
