import 'package:covid_care_app/core/locator.dart';
import 'package:covid_care_app/routes/router.gr.dart';
import 'package:covid_care_app/views/report/test_report_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  int _counter;

  HomeViewModel({int counter = 0}) : this._counter = counter;

  int get counter => this._counter;
  set counter(int value) {
    this._counter = value;
    notifyListeners();
  }

  void increment() => this.counter += 1;

  void navigateToReportPage() {
    _navigationService.navigateWithTransition(TestReportView(), transition: 'downToUp');
  }
}