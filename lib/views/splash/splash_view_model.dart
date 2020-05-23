import 'package:covid_care_app/core/locator.dart';
import 'package:covid_care_app/routes/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  Future navigateToOnboardingScreen() async {
    print("navigateToOnboardingScreen");
    await _navigationService.navigateTo(Routes.onboardingView);
  }
}