import 'dart:math';

import 'package:bit_key/features/feature_generate_pass/data/model/password_strength.dart';
import 'package:bit_key/features/feature_generate_pass/domain/repositories/pass_generator_repo.dart';

class PassGeneratorRepoImpl implements PassGeneratorRepo {
  final _passLower = passLower.split('');
  final _passUpper = passUpper.split('');
  final _passDigits = passDigits.split('');
  final _passSafeSymbols = passSafeSymbols.split('');
  List<String> allowedValue = [];

  // Скорости перебора (паролей/секунду)
  static const Map<String, int> attackSpeeds = {
    'offline_slow': 1000, // 1K/сек (слабый хеш)
    'offline_fast': 1000000000, // 1 млрд/сек (быстрый хеш)
    'online_bruteforce': 10, // 10/сек (с ограничениями)
    'online_dictionary': 100, // 100/сек (словарная атака)
    'gpu_cluster': 1000000000000, // 1 трлн/сек (GPU кластер)
  };

  @override
  String generatePassword({
    required int length,
    bool passLower = true,
    bool passUpper = true,
    bool passDigits = true,
    bool passSafeSymbols = true,
    int maxDigit = 0,
    int maxSpecial = 0,
  }) {
    String generatedStr = '';
    allowedValue = [];


    if (passLower) {
      allowedValue.addAll(_passLower);
    }

    if (passUpper) {
      allowedValue.addAll(_passUpper);
    }
    if (passDigits) {
      allowedValue.addAll(_passDigits);
    }

    if (passSafeSymbols) {
      allowedValue.addAll(_passSafeSymbols);
    }

    for (int i = 0; i < length; i++) {


      // TODO : LOGIC TO MAX NUMBER / MAX SPECIAL
      final randomChar = allowedValue[Random().nextInt(allowedValue.length)];

      generatedStr += randomChar;
    }

    return generatedStr;
  }

  @override
  PasswordStrength estimateTimeToCrack({
    required int passLength,
    required int alphabetSize,
  }) {
    final possibleCombinations = pow(allowedValue.length, passLength);
    final speed = attackSpeeds['offline_fast'] ?? attackSpeeds['offline_fast']!;

    final seconds = possibleCombinations / speed;
    return PasswordStrength(
      timesByAttackType: {},
      timeInSeconds: seconds.toDouble(),
      strength: _getStrengthLevel(seconds),
      //suggestions: _getSuggestions(password, seconds),
    );
  }

  // Определить уровень сложности
  static String _getStrengthLevel(double seconds) {
    if (seconds < 60) return 'Очень слабый';
    if (seconds < 3600) return 'Слабый'; // 1 час
    if (seconds < 31536000) return 'Средний'; // 1 год
    if (seconds < 3153600000) return 'Сильный'; // 100 лет
    return 'Очень сильный';
  }
}
