import 'package:bit_key/features/feature_generate_pass/data/repositories/generator_repo_impl.dart';
import 'package:bit_key/features/feature_generate_pass/domain/repositories/generator_repo.dart';
import 'package:bit_key/main.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> DI() async {
  getIt.registerSingleton<GeneratorRepo>(GeneratorRepoImpl());

  logger.i('DI inited');
}
