// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:covid_care_app/core/services/third_party_services_module.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:covid_care_app/core/services/storage/local_key_value_persistence.dart';
import 'package:covid_care_app/core/services/storage/repository.dart';
import 'package:covid_care_app/core/services/storage/storage.dart';
import 'package:covid_care_app/core/services/detection/intersect_notification.dart';
import 'package:get_it/get_it.dart';

void $initGetIt(GetIt g, {String environment}) {
  final thirdPartyServicesModule = _$ThirdPartyServicesModule();
  g.registerLazySingleton<DialogService>(
      () => thirdPartyServicesModule.dialogService);
  g.registerFactory<IRepository>(() => LocalKeyValuePersistence());
  g.registerLazySingleton<NavigationService>(
      () => thirdPartyServicesModule.navigationService);
  g.registerLazySingleton<SnackbarService>(
      () => thirdPartyServicesModule.snackBarService);
  g.registerLazySingletonAsync<Storage>(() => Storage.create(repository: g()));
  g.registerLazySingleton<IntersectNotification>(
      () => IntersectNotification(g<Storage>()));
}

class _$ThirdPartyServicesModule extends ThirdPartyServicesModule {
  @override
  DialogService get dialogService => DialogService();
  @override
  NavigationService get navigationService => NavigationService();
  @override
  SnackbarService get snackBarService => SnackbarService();
}
