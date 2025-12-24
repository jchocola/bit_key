import 'package:bit_key/features/feature_generate_pass/data/repositories/pass_generator_repo_impl.dart';
import 'package:bit_key/features/feature_generate_pass/domain/repositories/pass_generator_repo.dart';
import 'package:bit_key/main.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> DI() async {
  getIt.registerSingleton<PassGeneratorRepo>(PassGeneratorRepoImpl());

  logger.i('DI inited');
}
