import 'package:bit_key/features/feature_analytic/domain/analytic_repository.dart';

class AnalyticsFacadeRepoImpl implements AnalyticClientBase {
  final List<AnalyticClientBase> clients;
  AnalyticsFacadeRepoImpl({required this.clients});

  @override
  Future<void> identifyUser({required String salt}) =>
      _dispatch((c) => c.identifyUser(salt: salt));

  @override
  Future<void> resetUser() => _dispatch((c) => c.resetUser());

  @override
  Future<void> trackAppBackgrounded() =>
      _dispatch((c) => c.trackAppBackgrounded());

  @override
  Future<void> trackAppCreated() => _dispatch((e) => e.trackAppCreated());

  @override
  Future<void> trackAppDeleted()  => _dispatch((e) => e.trackAppDeleted());

  @override
  Future<void> trackAppForegrounded()  => _dispatch((e) => e.trackAppForegrounded());

  @override
  Future<void> trackAppUpdated()  => _dispatch((e) => e.trackAppUpdated());

  @override
  Future<void> trackBottomSheetView(
    String routeName, [
    Map<String, Object>? data,
  ])  => _dispatch((e) => e.trackBottomSheetView(routeName , data));

  @override
  Future<void> trackButtonPressed(
    String buttonName, [
    Map<String, Object>? data,
  ])  => _dispatch((e) => e.trackButtonPressed(buttonName,data));


  @override
  Future<void> trackDialogView(String dialogName, [Map<String, Object>? data])  => _dispatch((e) => e.trackDialogView(dialogName,data));

  @override
  Future<void> trackEvent(String eventName, [Map<String, Object>? eventData])  => _dispatch((e) => e.trackEvent(eventName,eventData));

  @override
  Future<void> trackNewAppOnboarding()  => _dispatch((e) => e.trackNewAppOnboarding());

  @override
  Future<void> trackPermissionRequest(String permission, String status)  => _dispatch((e) => e.trackPermissionRequest(permission,status));

  @override
  Future<void> trackScreenView(String routeName, String action)  => _dispatch((e) => e.trackScreenView(routeName,action));

  Future<void> _dispatch(
    Future<void> Function(AnalyticClientBase client) work,
  ) async {
    for (final client in clients) {
      await work(client);
    }
  }
}
