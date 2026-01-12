String langCodeConverter({required String langCode}) {
  switch (langCode) {
    case "en":
      return "en-English";
    case "ru":
      return "ru-Russian-Русский";
    case "vi":
      return "vi-Vietnamese-Tiếng Việt";
    case "be":
      return "be-Belarusian-Беларуская";
    case "ar":
      return "ar-Arabic-العربية";
    case "de":
      return "de-German-Deutsch";
    case "hi":
      return "hi-Hindi-हिन्दी";
    case "it":
      return "it-Italian-Italiano";
    case "ja":
      return "ja-Japanese-日本語";
    case "kk":
      return "kk-Kazakh-Қазақ тілі";
    case "ko":
      return "ko-Korean-한국어";
    case "mn":
      return "mn-Mongolian-Монгол хэл";
    case "uk":
      return "uk-Ukrainian-Українська";
    case "uz":
      return "uz-Uzbek-O‘zbekcha";
    default:
      return "Unknown";
  }
}