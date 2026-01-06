import 'package:flutter/foundation.dart';

enum CLEAN_KEY_DURATION { hour1, hour2, hour3, hour6 }



extension CleanKeyDurationExt on CLEAN_KEY_DURATION {
  /// number of hours represented by the enum value
  int get hours {
    switch (this) {
      case CLEAN_KEY_DURATION.hour1:
        return 1;
      case CLEAN_KEY_DURATION.hour2:
        return 2;
      case CLEAN_KEY_DURATION.hour3:
        return 3;
      case CLEAN_KEY_DURATION.hour6:
        return 6;
    }
  }

   CLEAN_KEY_DURATION  fromStr({required String strValue}) {
    switch (strValue) {
      case 'hour1':
        return CLEAN_KEY_DURATION.hour1;
      case 'hour2':
        return CLEAN_KEY_DURATION.hour2;
      case 'hour3':
        return CLEAN_KEY_DURATION.hour3;
      case 'hour6':
        return CLEAN_KEY_DURATION.hour6;

      default: return CLEAN_KEY_DURATION.hour1;
    }
  }

     CLEAN_KEY_DURATION  fromInt({required int intValue}) {
    switch (intValue) {
      case 1:
        return CLEAN_KEY_DURATION.hour1;
      case 2:
        return CLEAN_KEY_DURATION.hour2;
      case 3:
        return CLEAN_KEY_DURATION.hour3;
      case 6:
        return CLEAN_KEY_DURATION.hour6;

      default: return CLEAN_KEY_DURATION.hour1;
    }
  }

   /// Duration instance for the enum value
  Duration get duration => Duration(hours: hours);

  /// Minutes for the enum value
  int get minutes => hours * 60;

  /// Seconds for the enum value
  int get seconds => hours * 3600;

  /// Human readable label (simple, non-localized)
  String get label {
    final h = hours;
    return 'Every $h hour${h == 1 ? '' : 's'}';
  }
}
