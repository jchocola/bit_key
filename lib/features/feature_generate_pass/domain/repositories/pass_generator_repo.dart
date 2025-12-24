// Character set constants for password generation
const String passLower = 'abcdefghijklmnopqrstuvwxyz';
const String passUpper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
const String passDigits = '0123456789';

// Safe symbols (avoid quotes and backslash) and full symbol set
const String passSafeSymbols = '!@#\$%^&*()-_=+[]{}|;:,.<>?/~`';
const String passAllSymbols = '!@#\$%^&*()-_=+[]{}|;:,.<>?/~`\'"\\';

// Common presets
const String passAlphaNumeric = passLower + passUpper + passDigits;
const String passDefaultChars = passAlphaNumeric + passSafeSymbols;

abstract class PassGeneratorRepo {
  String generatePassword({
    required int length,
    bool passLower = true,
    bool passUpper = true,
    bool passDigits = true,
    bool passSafeSymbols = true,
  });
}
