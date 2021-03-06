import 'package:background_fetch/background_fetch.dart';
import 'package:covid_care_app/core/services/background/background_service.dart';
import 'package:covid_care_app/routes/router.gr.dart';
import 'package:stacked_services/stacked_services.dart';

import 'core/locator.dart';
import 'core/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme/theme.dart';

void main() async {
  setupLocator();
  runApp(MainApplication());
  BackgroundFetch.registerHeadlessTask(BackgroundTaskService.onBackgroundFetchHeadlessTask);
}

class MainApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: ProviderInjector.providers,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: buildAppTheme(),
          //navigatorKey: locator<NavigatorService>().navigatorKey,
          initialRoute: Routes.splashView,
          onGenerateRoute: Router().onGenerateRoute,
          navigatorKey: locator<NavigationService>().navigatorKey,
          //onGenerateRoute: Router.,
          //navigatorKey: Router.navigatorKey,
          //home: OnboardingView(),
          // builder: (ctx, __) => ExtendedNavigator<Router>(
          //   initialRoute: Routes.splashView,
          //   router: Router(),
          // ),
        ));
  }
}
