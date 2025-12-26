// Character set constants for password generation
import 'package:bit_key/features/feature_generate_pass/data/model/password_strength.dart';
import 'package:random_name_generator/random_name_generator.dart' show Zone;

const String passLower = 'abcdefghijklmnopqrstuvwxyz';
const String passUpper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
const String passDigits = '0123456789';

// Safe symbols (avoid quotes and backslash) and full symbol set
const String passSafeSymbols = '!@#\$%^&*()-_=+[]{}|;:,.<>?/~`';
const String passAllSymbols = '!@#\$%^&*()-_=+[]{}|;:,.<>?/~`\'"\\';

// Common presets
const String passAlphaNumeric = passLower + passUpper + passDigits;
const String passDefaultChars = passAlphaNumeric + passSafeSymbols;

abstract class GeneratorRepo {
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

  String generateName({
    required bool isMan,
    required bool firstName,
    required bool lastName,
    required bool fullName,
    required Zone zone,
  });
}
