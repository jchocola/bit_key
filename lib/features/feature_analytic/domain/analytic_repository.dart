// ignore_for_file: constant_identifier_names

enum AnalyticEvent {
  CREATE_LOGIN,
  CREATE_CARD,
  CREATE_IDENTITY,

  MOVE_LOGIN_TO_BIN,
  MOVE_CARD_TO_BIN,
  MOVE_IDENTITY_TO_BIN,

  EDIT_LOGIN,
  EDIT_CARD,
  EDIT_IDENTITY,

  RESTORE_LOGIN,
  RESTORE_CARD,
  RESTORE_IDENTITY,

  
  GENERATE_KEY,
  GENERATE_PROFILE,

  CHANGE_LANGUAGE,
  READ_APP_ABOUT_PAGE,

  CLOSE_BY_SHAKE,
  CLOSE_BY_TIME_OUT,

  EXPORT_PURE_DATA,
  EXPORT_ENCRYPTED_DATA,

  IMPORT_DATA
}

abstract class AnalyticClientBase {
  /// Identifies the user with the given [salt].
  Future<void> identifyUser({required String salt});

  /// Resets the user.
  Future<void> resetUser();

  /// Tracks a generic event with the given [eventName] and [eventData].
  Future<void> trackEvent(String eventName, [Map<String, Object>? eventData]);

  /// Tracks a screen view with the given [routeName] and [action].
  Future<void> trackScreenView(String routeName, String action);

  /// Tracks a bottom sheet view with the given [routeName] and [data].
  Future<void> trackBottomSheetView(
    String routeName, [
    Map<String, Object>? data,
  ]);

  /// Tracks a dialog view with the given [dialogName] and [data].
  Future<void> trackDialogView(String dialogName, [Map<String, Object>? data]);

  /// Tracks the app being foregrounded.
  Future<void> trackAppForegrounded();

  /// Tracks the app being backgrounded.
  Future<void> trackAppBackgrounded();

  /// Tracks a button press with the given [buttonName] and [data].
  Future<void> trackButtonPressed(
    String buttonName, [
    Map<String, Object>? data,
  ]);

  /// Tracks the permission being granted with status.
  Future<void> trackPermissionRequest(String permission, String status);

  /// Tracks the onboarding screen view.
  Future<void> trackNewAppOnboarding();

  /// Tracks the creation of an app.
  Future<void> trackAppCreated();

  /// Tracks the update of an app.
  Future<void> trackAppUpdated();

  /// Tracks the deletion of an app.
  Future<void> trackAppDeleted();
}
