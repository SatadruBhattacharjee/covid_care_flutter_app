import 'dart:io' show Platform;

import 'package:covid_care_app/core/constants/startup_states.dart';
import 'package:covid_care_app/core/locator.dart';
import 'package:covid_care_app/views/home/home_view.dart';
import 'package:covid_care_app/views/login/login_view.dart';
import 'package:covid_care_app/views/onboarding/onboarding_view.dart';
import 'package:covid_care_app/views/setup_finish/setup_finish_view.dart';
import 'package:covid_care_app/views/setup_location/setup_location_view.dart';
import 'package:covid_care_app/views/setup_notification/setup_notification_view.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';

import 'splash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

// class SplashView extends StatefulWidget {
//   SplashView({Key key}) : super(key: key);

//   @override
//   _SplashViewState createState() => _SplashViewState();
// }

// class _SplashViewState extends State<SplashView> {
//   @override
//   Widget build(BuildContext context) {
//     return ViewModelBuilder.reactive(
//         viewModelBuilder: () => SplashViewModel(),
//         builder: (context, model, child) => SplashScreen.navigate(
//               name: 'assets/flare/intro.flr',
//               next: (_) {
//                 print("next");
//                 return OnboardingView();
//               },
//               //loopAnimation: '1',
//               until: () async {
//                 print("next");
//                 await Future.delayed(Duration(seconds: 3));
//               },
//               startAnimation: '1',
//             ));
//   }
// }
class SplashView extends StatelessWidget {
  const SplashView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: locator.allReady(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ViewModelBuilder.reactive(
                viewModelBuilder: () => SplashViewModel(),
                builder: (context, model, child) => SplashScreen.navigate(
                      name: 'assets/flare/intro.flr',
                      next: (_) {
                        if (!model.isBusy) {
                          int startupState = model.data;
                          if (startupState == StartupState.INITIAL) {
                            return OnboardingView();
                          } else if (startupState ==
                              StartupState.ONBOARDING_DONE) {
                            return LoginView();
                          } else if (startupState == StartupState.LOGIN_DONE) {
                            return SetupLocationView();
                          } else if (startupState ==
                              StartupState.SETUP_LOCATION_DONE) {
                            if (Platform.isIOS) {
                              return SetupNotificationView();
                            } else {
                              return SetupFinishView();
                            }
                          } else if (startupState ==
                              StartupState.SETUP_NOTIFICATION_DONE) {
                            return SetupFinishView();
                          } else if (startupState ==
                              StartupState.SETUP_COMPLETE_DONE) {
                            return HomeView();
                          }
                        }
                      },
                      //loopAnimation: '1',
                      until: () async {
                        print("next");
                        await Future.delayed(Duration(seconds: 3));
                      },
                      startAnimation: '1',
                    ));
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
