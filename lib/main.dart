import 'package:covid_care_app/views/report/test_report_view.dart';

import 'core/locator.dart';
import 'core/providers.dart';
import 'core/services/navigator_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme/colors.dart';
import 'theme/theme.dart';
import 'views/home/home_view.dart';
import 'views/onboarding/onboarding_view.dart';
import 'views/setup_location/setup_location_view.dart';
import 'views/setup_notification/setup_notification_view.dart';

void main() async {
  await LocatorInjector.setupLocator();
  runApp(MainApplication());
}

class MainApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: ProviderInjector.providers,
      child: MaterialApp(
          theme: buildAppTheme(),
          navigatorKey: locator<NavigatorService>().navigatorKey,
          //home: OnboardingView(),
          home: TestReportView(),
      )
    );
  }
}
