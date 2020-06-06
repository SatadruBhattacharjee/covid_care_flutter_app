import 'package:covid_care_app/core/constants/storage_keys.dart';
import 'package:covid_care_app/core/locator.dart';
import 'package:covid_care_app/core/services/notification/local_notification_service.dart';
import 'package:covid_care_app/core/services/storage/storage.dart';
import 'package:covid_care_app/routes/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SetupNotificationViewModel extends BaseViewModel {
  final Storage _storage = locator<Storage>();
  final LocalNotificationService _localNotificationService =
      locator<LocalNotificationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  void initialize() {
    _localNotificationService.initialize();
  }

  Future<void> requestPermissions() async {
    _localNotificationService.requestIOSPermissions();
    _localNotificationService.showNotification();
    await setNotificationSetupStepFinish();
  }

  Future setNotificationSetupStepFinish() async {
    await _storage.setStoreData(
        key: StorageKeys.NOTIFICATION_SETUP_DONE, value: 'true', isString: true);
    _navigationService.navigateTo(Routes.setupFinishView);
  }
}
