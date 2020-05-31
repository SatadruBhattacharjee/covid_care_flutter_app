import 'package:covid_care_app/core/constants/startup_states.dart';
import 'package:covid_care_app/core/constants/storage_keys.dart';
import 'package:covid_care_app/core/services/authentication/auth_service.dart';
import 'package:covid_care_app/core/services/storage/storage.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class StartupService {
  final Storage _storage;
  final AuthService _authService;

  StartupService(this._storage, this._authService);

  Future<bool> isFirstRunSequenceCompleted() async {
    bool userLoggingStatus = await _authService.isUserLogged();
    String flag = await _storage.getStoreData(
        key: StorageKeys.COMPLETE_SETUP_DONE, isString: true);

    return userLoggingStatus && flag == 'true' || false;
  }

  Future<int> getStartupState() async {
    // if (await isFirstRunSequenceCompleted()) {
    //   return StartupState.SETUP_COMPLETE_DONE;
    // }
    String flag = await _storage.getStoreData(
        key: StorageKeys.ONBOARDING_DONE, isString: true);

    if (flag == 'true') {
      bool userLoggingStatus = await _authService.isUserLogged();
      if (userLoggingStatus) {
        flag = await _storage.getStoreData(
            key: StorageKeys.LOCATION_SETUP_DONE, isString: true);

        if (flag == 'true') {
          flag = await _storage.getStoreData(
              key: StorageKeys.NOTIFICATION_SETUP_DONE, isString: true);

          if (flag == 'true') {
            return StartupState.SETUP_COMPLETE_DONE;
          }
          return StartupState.SETUP_LOCATION_DONE;
        }
        return StartupState.LOGIN_DONE;
      }
      return StartupState.ONBOARDING_DONE;
    }
    return StartupState.INITIAL;
  }
}
