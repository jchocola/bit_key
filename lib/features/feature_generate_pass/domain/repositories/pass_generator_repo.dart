// Character set constants for password generation
import 'package:bit_key/features/feature_generate_pass/data/model/password_strength.dart';

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
    int maxDigit =0,
    int maxSpecial = 0
  });

  PasswordStrength estimateTimeToCrack({required int passLength , required int alphabetSize});
}
