import 'package:covid_care_app/views/onboarding/onboarding_view.dart';
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
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => SplashViewModel(),
        builder: (context, model, child) => SplashScreen.navigate(
              name: 'assets/flare/intro.flr',
              next: (_) {
                print("next");
                return OnboardingView();
              },
              //loopAnimation: '1',
              until: () async {
                print("next");
                await Future.delayed(Duration(seconds: 3));
              },
              startAnimation: '1',
            ));
  }
}
