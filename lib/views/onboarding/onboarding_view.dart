import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'onboarding_view_model.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OnboardingViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: PageView(
            controller: model.pageController,
            onPageChanged: model.handleSlideChange,
            children: model.getSlides(),
          ),
        ),
        bottomSheet: model.slideIndex != 2
            ? Container(
                margin: EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        model.pageController.animateToPage(2,
                            duration: Duration(milliseconds: 400),
                            curve: Curves.linear);
                      },
                      splashColor: Colors.blue[50],
                      child: Text(
                        "SKIP",
                        style: TextStyle(
                            color: Color(0xFF0074E4),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          for (int i = 0; i < 3; i++)
                             PageIndicator(pageIndex: i)
                        ],
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        model.pageController.animateToPage(model.slideIndex + 1,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.linear);
                      },
                      splashColor: Colors.blue[50],
                      child: Text(
                        "NEXT",
                        style: TextStyle(
                            color: Color(0xFF0074E4),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              )
            : InkWell(
                onTap: model.setOnboardingStepFinish,
                child: Container(
                  height: Platform.isIOS ? 70 : 60,
                  color: Colors.blue,
                  alignment: Alignment.center,
                  child: Text(
                    "GET STARTED NOW",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
      ),
      viewModelBuilder: () => OnboardingViewModel(),
    );
  }
}

class PageIndicator extends ViewModelWidget<OnboardingViewModel> {
  final pageIndex;
  PageIndicator({
    Key key,
    this.pageIndex
  }) : super(key: key, reactive: true);

  @override
  Widget build(BuildContext context, model) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: model.isCurrentSlide(pageIndex) ? 10.0 : 6.0,
      width: model.isCurrentSlide(pageIndex) ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: model.isCurrentSlide(pageIndex) ? Colors.grey : Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
