import 'package:covid_care_app/core/constants/storage_keys.dart';
import 'package:covid_care_app/core/locator.dart';
import 'package:covid_care_app/core/services/storage/storage.dart';
import 'package:covid_care_app/routes/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SetupFinishViewModel extends BaseViewModel {
  final Storage _storage = locator<Storage>();
  final NavigationService _navigationService = locator<NavigationService>();

    Future setCompleteSetupStepFinish() async {
    await _storage.setStoreData(
        key: StorageKeys.COMPLETE_SETUP_DONE, value: 'true', isString: true);
    _navigationService.navigateTo(Routes.homeView);
  }
}
