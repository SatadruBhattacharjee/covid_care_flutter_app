
import 'package:auto_route/auto_route_annotations.dart';
import 'package:covid_care_app/views/home/home_view.dart';
import 'package:covid_care_app/views/onboarding/onboarding_view.dart';
import 'package:covid_care_app/views/setup_finish/setup_finish_view.dart';
import 'package:covid_care_app/views/setup_location/setup_location_view.dart';
import 'package:covid_care_app/views/setup_notification/setup_notification_view.dart';
import 'package:covid_care_app/views/splash/splash_view.dart';

@MaterialAutoRouter()
class $Router {
  @initial
  SplashView splashView;
  OnboardingView onboardingView;
  SetupLocationView setupLocationView;
  SetupNotificationView setupNotificationView;
  SetupFinishView setupFinishView;
  HomeView homeView;
}