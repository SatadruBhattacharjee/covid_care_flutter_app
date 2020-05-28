import 'package:background_fetch/background_fetch.dart';

class BackgroundTaskService {

  static void onBackgroundFetchHeadlessTask(String taskId) async {
    print('[BackgroundFetch] Headless event received  with $taskId');
    BackgroundFetch.finish(taskId);
  }

  static void _onBackgroundFetchTask(String taskId) async {
    print('[BackgroundFetch] event received with $taskId');
    BackgroundFetch.finish(taskId);
  }

  static Future configure() async {
    // Configure BackgroundFetch.
    BackgroundFetch.configure(
            BackgroundFetchConfig(
                minimumFetchInterval: 15,
                stopOnTerminate: false,
                enableHeadless: true,
                requiresBatteryNotLow: false,
                requiresCharging: false,
                requiresStorageNotLow: false,
                requiresDeviceIdle: false,
                requiredNetworkType: NetworkType.NONE),
            _onBackgroundFetchTask)
        .then((int status) {
      print('[BackgroundFetch] configure success: $status');
    }).catchError((e) {
      print('[BackgroundFetch] configure ERROR: $e');
    });
  }

  Future<int> getStatus() async {
    int status = await BackgroundFetch.status;
    return status;
  }

  void start() {
    BackgroundFetch.start().then((int status) {
      print('[BackgroundFetch] start success: $status');
    }).catchError((e) {
      print('[BackgroundFetch] start FAILURE: $e');
    });
  }

  void stop() {
    BackgroundFetch.stop().then((int status) {
      print('[BackgroundFetch] stop success: $status');
    });
  }
}
