class HistoryKeys {
  /// Max esposure reporting window in days
  static const MAX_EXPOSURE_WINDOW_DAYS = 14;

  /// The value in minutes of each "bin" in the crossed path data.
  static const DEFAULT_EXPOSURE_PERIOD_MINUTES = 5;

  /// The value in minutes of how long an exposure at a location is considered concerning.
  static const CONCERN_TIME_WINDOW_MINUTES = 4 * 60; // 4 hours, in minutes

  /// The value in minutes of how frequently we should check intersection data if
  ///    there has been no change to the authorities
  static const MIN_CHECK_INTERSECT_INTERVAL = 6 * 60;

  /// The value in minutes for the background task service to register for firing
  static const INTERSECT_INTERVAL =
      60 * 12; // 12 Hours, the value is received in minutes

}
