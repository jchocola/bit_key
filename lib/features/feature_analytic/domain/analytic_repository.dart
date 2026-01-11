// ignore_for_file: constant_identifier_names

enum AnalyticEvent {

  ///
  /// AUTH PART
  ///
  AUTH_VIA_BIOMETRIC,  //✅
  AUTH_VIA_MASTER_KEY, //✅
  SETUP_MASTER_KEY, //✅
  LOCK_APP, // ✅


  ///
  /// VAULT FEATURE
  ///
  CREATE_LOGIN, // ✅
  CREATE_CARD, // ✅
  CREATE_IDENTITY,  // ✅
  CREATE_FOLDER,  // ✅

  VIEW_LOGINS_FOLDER, // ✅
  VIEW_CARDS_FOLDER, // ✅
  VIEW_IDENTITIES_FOLDER,  //✅

  MOVE_LOGIN_TO_BIN, // ✅
  MOVE_CARD_TO_BIN, // ✅
  MOVE_IDENTITY_TO_BIN, // ✅
  CLEAR_BIN, // ✅

  DELETE_LOGIN,  // ✅
  DELETE_CARD, // ✅
  DELETE_IDENTITY,// ✅

  
  EDIT_LOGIN, // ✅
  EDIT_CARD, // ✅
  EDIT_IDENTITY, // ✅


  RESTORE_LOGIN, // ✅
  RESTORE_CARD, // ✅
  RESTORE_IDENTITY, // ✅

  
  ///
  /// GENERATOR FEATURE
  ///
  GENERATE_PASSWORD,  //✅
  GENERATE_PROFILE, // ✅
  COPY_TAPPED,  // ✅


  ///
  /// ACCOUNT SECURITY
  ///
  SET_TIME_OUT,
  SET_CLEAR_TEMPORARY_KEY,
  ALLOW_SCREENSHOT,
  PROPOSE_SCREENSHOT,
  ALLOW_SHAKE_TO_LOCK,
  PROPOSE_SHAKE_TO_LOCK,
  CLOSE_BY_SHAKE,
  CLOSE_BY_TIME_OUT,

  ///
  /// SETTINGS
  ///
  CHANGE_LANGUAGE,
  READ_APP_ABOUT_PAGE,
  READ_FAQ_PAGE,


  ///
  /// IMPORT/EXPORT DATA
  ///
  EXPORT_PURE_DATA,
  EXPORT_ENCRYPTED_DATA,
  DELETE_ALL_DATA, // ✅
  DELETE_FOLDER,  // ✅

  IMPORT_DATA_SUCCESS,
  IMPORT_DATA_FAILED,
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
