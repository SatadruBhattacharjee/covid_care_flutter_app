import 'package:covid_care_app/core/models/slider_model.dart';
import 'package:covid_care_app/widgets/onboarding/slide_page.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:covid_care_app/core/locator.dart';
import 'package:covid_care_app/core/services/storage/storage.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:covid_care_app/core/constants/storage_keys.dart';

class OnboardingViewModel extends BaseViewModel {
  final Storage _storage = locator<Storage>();
  final NavigationService _navigationService = locator<NavigationService>();
  PageController _controller;
  int _slideIndex;
  List<SliderModel> _slides;

  OnboardingViewModel() {
    _controller = PageController();
    _slideIndex = 0;
    _slides = new List<SliderModel>();

    _setupSlides();
  }

  void _setupSlides() {
    SliderModel sliderModel1 = SliderModel(
        imageAssetPath: "assets/images/illustration_1.png",
        title: "Exposure Notification",
        desc:
            "Get allerted when you might have come into contact with someone with codid-19");
    _slides.add(sliderModel1);

    SliderModel sliderModel2 = SliderModel(
        imageAssetPath: "assets/images/illustration_2.png",
        title: "Share your Status",
        desc:
            "Update your status and symptoms in the app to help track the spread of Covid-19");
    _slides.add(sliderModel2);

    SliderModel sliderModel3 = SliderModel(
        imageAssetPath: "assets/images/illustration_3.png",
        title: "Your Data is Secure",
        desc:
            "All the location data is stored locally in your device and you have the control to share and help others");
    _slides.add(sliderModel3);
  }

  PageController get pageController => _controller;

  int get slideIndex => _slideIndex;

  void handleSlideChange(int value) {
    _slideIndex = value;
    notifyListeners();
  }

  isCurrentSlide(pageIndex) {
    return _slideIndex == pageIndex;
  }

  List<Widget> getSlides() {
    return new List<Widget>.generate(_slides.length, (int index) {
      return SlidePage(
          imagePath: _slides[index].imageAssetPath,
          title: _slides[index].title,
          desc: _slides[index].desc);
    });
  }

  Future setOnboardingStepFinish() async {
    await _storage.setStoreData(
        key: StorageKeys.ONBOARDING_DONE, value: 'true', isString: true);
  }
}
