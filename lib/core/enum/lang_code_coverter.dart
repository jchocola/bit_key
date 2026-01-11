String langCodeConverter({required String langCode}) {
  switch (langCode) {
    case "en":
      return "en-English";
    case "ru":
      return "ru-Russian-Русский";
    case "vi":
      return "vi-Vietnamese-Tiếng Việt";
    default:
      return "Unknown";
  }
}
