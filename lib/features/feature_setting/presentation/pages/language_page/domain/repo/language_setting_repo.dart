abstract class LanguageSettingRepo {
  Future<String> getCurrentLangCode();
  Future<void> setLangCode({required String langCode});
}
