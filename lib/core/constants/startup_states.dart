abstract class StartupState {
  static const INITIAL = 0;
  static const ONBOARDING_DONE = 1;
  static const LOGIN_DONE = 2;
  static const SETUP_LOCATION_DONE = 3;
  static const SETUP_NOTIFICATION_DONE = 4;
  static const SETUP_COMPLETE_DONE = 5;
}

// enum StartupState {
//   INITIAL,
//   ONBOARDING_DONE,
//   LOGIN_DONE,
//   SETUP_LOCATION_DONE,
//   SETUP_NOTIFICATION_DONE,
//   SETUP_COMPLETE_DONE
// }

// const Map<StartupState, int> StartupStateValue = {
//   StartupState.INITIAL: 0,
//   StartupState.LOGIN_DONE: 1,
//   StartupState.ONBOARDING_DONE: 2,
//   StartupState.SETUP_LOCATION_DONE: 3,
//   StartupState.SETUP_NOTIFICATION_DONE: 4,
//   StartupState.SETUP_COMPLETE_DONE: 5,
// };
