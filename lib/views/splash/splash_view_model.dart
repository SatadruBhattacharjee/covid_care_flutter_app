import 'package:covid_care_app/core/constants/startup_states.dart';
import 'package:covid_care_app/core/constants/storage_keys.dart';
import 'package:covid_care_app/core/locator.dart';
import 'package:covid_care_app/core/services/storage/storage.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashViewModel extends FutureViewModel<int> {
  final Storage _storage = locator<Storage>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future<int> getStartupState() async {
    String flag = await _storage.getStoreData(
        key: StorageKeys.ONBOARDING_DONE, isString: true);

    if (flag == 'true') {
      return StartupState.ONBOARDING_DONE;
    }
    return StartupState.INITIAL;
  }

  @override
  void onError(error) {}

  @override
  Future<int> futureToRun() => getStartupState();
}
