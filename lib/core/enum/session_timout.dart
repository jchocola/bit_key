enum SESSION_TIMEOUT { min2, min5, min10, min15 }

extension SessionTimeOutExt on SESSION_TIMEOUT {
  /// number of hours represented by the enum value
  int get minutes {
    switch (this) {
      case SESSION_TIMEOUT.min2:
        return 2;
      case SESSION_TIMEOUT.min5:
        return 5;
      case SESSION_TIMEOUT.min10:
        return 10;
      case SESSION_TIMEOUT.min15:
        return 15;
    }
  }

  SESSION_TIMEOUT fromIntValue({required int value}) {
    switch (value) {
      case 2:
        return SESSION_TIMEOUT.min2;
      case 5:
        return SESSION_TIMEOUT.min5;
      case 10:
        return SESSION_TIMEOUT.min10;
      case 15:
        return SESSION_TIMEOUT.min15;

      default:
        return SESSION_TIMEOUT.min2;
    }
  }

  String get label {
    final min = minutes;
    return '$min min.';
  }
}
