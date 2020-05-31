import 'dart:async';

import 'package:covid_care_app/core/locator.dart';
import 'package:covid_care_app/core/services/startup/startup_service.dart';
import 'package:covid_care_app/core/services/storage/storage.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashViewModel extends FutureViewModel<int> {
  final Storage _storage = locator<Storage>();
  final NavigationService _navigationService = locator<NavigationService>();
  final StartupService _startupService = locator<StartupService>();

  // Future<StartupState> getStartupState() async {
  //   String flag = await _storage.getStoreData(
  //       key: StorageKeys.ONBOARDING_DONE, isString: true);

  //   if (flag == 'true') {
  //     flag = await _storage.getStoreData(
  //       key: StorageKeys.LOCATION_SETUP_DONE, isString: true);

  //     if (flag == 'true') {
  //       return StartupState.SETUP_LOCATION_DONE;
  //     }
  //     return StartupState.ONBOARDING_DONE;
  //   }
  //   return StartupState.INITIAL;
  // }

  @override
  void onError(error) {}

  @override
  Future<int> futureToRun() async {
    int state = await _startupService.getStartupState();
    return state;
  }

  // @override
  // Future<StartupState> futureToRun() => _startupService.getStartupState();
}
