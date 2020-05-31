// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:covid_care_app/core/services/authentication/auth_service.dart';
import 'package:covid_care_app/core/services/third_party_services_module.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:covid_care_app/core/services/storage/local_key_value_persistence.dart';
import 'package:covid_care_app/core/services/storage/storage.dart';
import 'package:covid_care_app/core/services/detection/intersect_notification.dart';
import 'package:covid_care_app/core/services/startup/startup_service.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  final thirdPartyServicesModule = _$ThirdPartyServicesModule();
  g.registerLazySingleton<AuthService>(() => AuthService());
  g.registerLazySingleton<DialogService>(
      () => thirdPartyServicesModule.dialogService);
  g.registerLazySingleton<LocalKeyValuePersistence>(
      () => LocalKeyValuePersistence());
  g.registerLazySingleton<NavigationService>(
      () => thirdPartyServicesModule.navigationService);
  g.registerLazySingleton<SnackbarService>(
      () => thirdPartyServicesModule.snackBarService);
  g.registerLazySingleton<Storage>(
      () => Storage(g<LocalKeyValuePersistence>()));
  g.registerLazySingleton<IntersectNotification>(
      () => IntersectNotification(g<Storage>()));
  g.registerLazySingleton<StartupService>(
      () => StartupService(g<Storage>(), g<AuthService>()));
}

class _$ThirdPartyServicesModule extends ThirdPartyServicesModule {
  @override
  DialogService get dialogService => DialogService();
  @override
  NavigationService get navigationService => NavigationService();
  @override
  SnackbarService get snackBarService => SnackbarService();
}
