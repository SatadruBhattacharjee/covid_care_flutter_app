import 'package:covid_care_app/core/locator.dart';
import 'package:jiffy/jiffy.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'confirm_report_view.dart';

enum TestReportState { Initial, Positive, Nagative }

class TestReportViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  TestReportState _reportState = TestReportState.Initial;
  DateTime _reportDate = DateTime.now();

  TestReportState get reportState {
    return _reportState;
  }

  set reportState(TestReportState result) {
    _reportState = result;
    notifyListeners();
  }

  set reportDate(DateTime date) {
    _reportDate = date;
    notifyListeners();
  }

  String getReportDate() {
    DateTime date = _reportDate;
    return Jiffy(date.toString()).yMMMMd;
  }

  void closePage() {
    _navigationService.back();
  }

  Future navigateToConfirmReportPage() async {
    await _navigationService.navigateWithTransition(ConfirmReportView(), transition: 'downToUp');
  }
}
