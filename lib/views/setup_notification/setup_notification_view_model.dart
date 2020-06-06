import 'package:covid_care_app/core/locator.dart';
import 'package:covid_care_app/core/services/notification/local_notification_service.dart';
import 'package:stacked/stacked.dart';

class SetupNotificationViewModel extends BaseViewModel {

  final LocalNotificationService _localNotificationService = locator<LocalNotificationService>();

  void initialize() {
    _localNotificationService.initialize();
  }

  void requestPermissions() {
    _localNotificationService.requestIOSPermissions();
    _localNotificationService.showNotification();
  }
}
