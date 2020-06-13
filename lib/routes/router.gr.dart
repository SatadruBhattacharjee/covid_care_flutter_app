// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:covid_care_app/views/splash/splash_view.dart';
import 'package:covid_care_app/views/onboarding/onboarding_view.dart';
import 'package:covid_care_app/views/login/login_view.dart';
import 'package:covid_care_app/views/login/otp_view.dart';
import 'package:covid_care_app/views/setup_location/setup_location_view.dart';
import 'package:covid_care_app/views/setup_notification/setup_notification_view.dart';
import 'package:covid_care_app/views/setup_finish/setup_finish_view.dart';
import 'package:covid_care_app/views/home/home_view.dart';
import 'package:covid_care_app/views/report/test_report_view.dart';

abstract class Routes {
  static const splashView = '/';
  static const onboardingView = '/onboarding-view';
  static const loginViewl = '/login-viewl';
  static const otpView = '/otp-view';
  static const setupLocationView = '/setup-location-view';
  static const setupNotificationView = '/setup-notification-view';
  static const setupFinishView = '/setup-finish-view';
  static const homeView = '/home-view';
  static const testReportView = '/test-report-view';
  static const all = {
    splashView,
    onboardingView,
    loginViewl,
    otpView,
    setupLocationView,
    setupNotificationView,
    setupFinishView,
    homeView,
    testReportView,
  };
}

class Router extends RouterBase {
  @override
  Set<String> get allRoutes => Routes.all;

  @Deprecated('call ExtendedNavigator.ofRouter<Router>() directly')
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<Router>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.splashView:
        if (hasInvalidArgs<SplashViewArguments>(args)) {
          return misTypedArgsRoute<SplashViewArguments>(args);
        }
        final typedArgs = args as SplashViewArguments ?? SplashViewArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => SplashView(key: typedArgs.key),
          settings: settings,
        );
      case Routes.onboardingView:
        if (hasInvalidArgs<OnboardingViewArguments>(args)) {
          return misTypedArgsRoute<OnboardingViewArguments>(args);
        }
        final typedArgs =
            args as OnboardingViewArguments ?? OnboardingViewArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => OnboardingView(key: typedArgs.key),
          settings: settings,
        );
      case Routes.loginViewl:
        if (hasInvalidArgs<LoginViewArguments>(args)) {
          return misTypedArgsRoute<LoginViewArguments>(args);
        }
        final typedArgs = args as LoginViewArguments ?? LoginViewArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => LoginView(key: typedArgs.key),
          settings: settings,
        );
      case Routes.otpView:
        if (hasInvalidArgs<OTPViewArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<OTPViewArguments>(args);
        }
        final typedArgs = args as OTPViewArguments;
        return MaterialPageRoute<dynamic>(
          builder: (context) => OTPView(
              key: typedArgs.key, verificationId: typedArgs.verificationId),
          settings: settings,
        );
      case Routes.setupLocationView:
        if (hasInvalidArgs<SetupLocationViewArguments>(args)) {
          return misTypedArgsRoute<SetupLocationViewArguments>(args);
        }
        final typedArgs =
            args as SetupLocationViewArguments ?? SetupLocationViewArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => SetupLocationView(key: typedArgs.key),
          settings: settings,
        );
      case Routes.setupNotificationView:
        if (hasInvalidArgs<SetupNotificationViewArguments>(args)) {
          return misTypedArgsRoute<SetupNotificationViewArguments>(args);
        }
        final typedArgs = args as SetupNotificationViewArguments ??
            SetupNotificationViewArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => SetupNotificationView(key: typedArgs.key),
          settings: settings,
        );
      case Routes.setupFinishView:
        if (hasInvalidArgs<SetupFinishViewArguments>(args)) {
          return misTypedArgsRoute<SetupFinishViewArguments>(args);
        }
        final typedArgs =
            args as SetupFinishViewArguments ?? SetupFinishViewArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => SetupFinishView(key: typedArgs.key),
          settings: settings,
        );
      case Routes.homeView:
        if (hasInvalidArgs<HomeViewArguments>(args)) {
          return misTypedArgsRoute<HomeViewArguments>(args);
        }
        final typedArgs = args as HomeViewArguments ?? HomeViewArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => HomeView(key: typedArgs.key),
          settings: settings,
        );
      case Routes.testReportView:
        if (hasInvalidArgs<TestReportViewArguments>(args)) {
          return misTypedArgsRoute<TestReportViewArguments>(args);
        }
        final typedArgs =
            args as TestReportViewArguments ?? TestReportViewArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => TestReportView(key: typedArgs.key),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

// *************************************************************************
// Arguments holder classes
// **************************************************************************

//SplashView arguments holder class
class SplashViewArguments {
  final Key key;
  SplashViewArguments({this.key});
}

//OnboardingView arguments holder class
class OnboardingViewArguments {
  final Key key;
  OnboardingViewArguments({this.key});
}

//LoginView arguments holder class
class LoginViewArguments {
  final Key key;
  LoginViewArguments({this.key});
}

//OTPView arguments holder class
class OTPViewArguments {
  final Key key;
  final String verificationId;
  OTPViewArguments({this.key, @required this.verificationId});
}

//SetupLocationView arguments holder class
class SetupLocationViewArguments {
  final Key key;
  SetupLocationViewArguments({this.key});
}

//SetupNotificationView arguments holder class
class SetupNotificationViewArguments {
  final Key key;
  SetupNotificationViewArguments({this.key});
}

//SetupFinishView arguments holder class
class SetupFinishViewArguments {
  final Key key;
  SetupFinishViewArguments({this.key});
}

//HomeView arguments holder class
class HomeViewArguments {
  final Key key;
  HomeViewArguments({this.key});
}

//TestReportView arguments holder class
class TestReportViewArguments {
  final Key key;
  TestReportViewArguments({this.key});
}
