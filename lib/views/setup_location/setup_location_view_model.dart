import 'dart:ui';
import 'dart:io' show Platform;
import 'dart:isolate';

import 'package:background_locator/location_dto.dart';
import 'package:covid_care_app/core/constants/values.dart';
import 'package:covid_care_app/core/locator.dart';
import 'package:covid_care_app/core/services/location/location_service.dart';
import 'package:covid_care_app/core/services/storage/storage.dart';
import 'package:covid_care_app/routes/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:covid_care_app/core/constants/storage_keys.dart';

class SetupLocationViewModel extends BaseViewModel {
  final ReceivePort port = ReceivePort();
  final Storage _storage = locator<Storage>();
  final NavigationService _navigationService = locator<NavigationService>();

  int initialized = 0;

  void initialize() {
    if (IsolateNameServer.lookupPortByName(Values.ISOLATE_LOCATOR_NAME) !=
        null) {
      IsolateNameServer.removePortNameMapping(Values.ISOLATE_LOCATOR_NAME);
    }

    IsolateNameServer.registerPortWithName(
        port.sendPort, Values.ISOLATE_LOCATOR_NAME);

    port.listen(
      (dynamic data) async {
        print('Location $data');
        initialized = 1;
        notifyListeners();

        Future.delayed(const Duration(milliseconds: 1000), () async {
          //await setLocationSetupStepFinish();
        });
      },
    );

    LocationService.initialize();
  }

  void checkLocationPermission() async {
    bool allowed = await LocationService.checkLocationPermission();
    if (!allowed) {
      initialized = -1;
      notifyListeners();
    } else {
      await setLocationSetupStepFinish();
    }
  }

  Future setLocationSetupStepFinish() async {
    await _storage.setStoreData(
        key: StorageKeys.LOCATION_SETUP_DONE, value: 'true', isString: true);
    if (Platform.isIOS) {
      _navigationService.navigateTo(Routes.setupNotificationView);
    } else {
      _navigationService.navigateTo(Routes.setupFinishView);
    }
  }
}
