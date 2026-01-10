import 'package:bit_key/features/feature_setting/presentation/pages/language_page/domain/repo/language_setting_repo.dart';
import 'package:bit_key/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageSettingRepoImpl implements LanguageSettingRepo {
  final SharedPreferences sharedPreferences;

  LanguageSettingRepoImpl({required this.sharedPreferences});

  // keys
  final String LANG_CODE_KEY = 'LANG_CODE';

  @override
  Future<String> getCurrentLangCode() async {
    try {
      logger.d('Get current Lang Code');
      return sharedPreferences.getString(LANG_CODE_KEY) ?? 'en';
    } catch (e) {
      logger.e(e);
      return 'en';
    }
  }

  @override
  Future<void> setLangCode({required String langCode}) async {
    try {
     logger.d('Change lang code $langCode'); 
      await sharedPreferences.setString(LANG_CODE_KEY, langCode);
    } catch (e) {
      logger.e(e);
    }
  }
}
