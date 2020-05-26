import 'package:covid_care_app/core/locator.dart';
import 'package:covid_care_app/core/services/storage/storage.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:covid_care_app/core/constants/storage_keys.dart';

class SetupLocationViewModel extends BaseViewModel {
  final Storage _storage = locator<Storage>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future setLocationSetupStepFinish() async {
    await _storage.setStoreData(
        key: StorageKeys.ONBOARDING_DONE, value: 'true', isString: true);
  }
}
