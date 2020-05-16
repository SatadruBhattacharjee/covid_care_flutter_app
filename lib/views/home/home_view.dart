library home_view;

import 'package:stacked/stacked.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'home_view_model.dart';

part 'home_mobile.dart';
part 'home_tablet.dart';
part 'home_desktop.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, viewModel, child) {
        return ScreenTypeLayout(
          mobile: _HomeMobile(viewModel),
          desktop: _HomeDesktop(viewModel),
          tablet: _HomeTablet(viewModel),  
        );
      }
    );
  }
}