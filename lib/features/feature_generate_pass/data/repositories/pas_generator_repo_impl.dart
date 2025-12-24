import 'package:bit_key/features/feature_generate_pass/domain/repositories/pass_generator_repo.dart';

class PasGeneratorRepoImpl implements PassGeneratorRepo {
  final _passLower = passLower.split('');
  final _passUpper = passUpper.split('');
  final _passDigits = passDigits.split('');
  final _passSafeSymbols = passSafeSymbols.split('');

  @override
  String generatePassword({
    required int length,
    bool passLower = true,
    bool passUpper = true,
    bool passDigits = true,
    bool passSafeSymbols = true,
  }) {
    for (int i = 0; i <= length; i++) {}

    return '';
  }
}
