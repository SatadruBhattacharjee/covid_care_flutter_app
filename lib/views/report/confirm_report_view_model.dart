import 'package:covid_care_app/core/locator.dart';
import 'package:covid_care_app/routes/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ConfirmReportViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();

  void confirmed() {
    _navigationService.clearStackAndShow(Routes.homeView);
  }
}
