import 'package:hive/hive.dart';

import 'package:bit_key/features/feature_vault/domain/entity/card.dart';
import 'package:bit_key/features/feature_vault/domain/entity/identity.dart';
import 'package:bit_key/features/feature_vault/domain/entity/login.dart';
import 'package:bit_key/features/feature_vault/domain/repo/local_db_repository.dart';
import 'package:bit_key/main.dart';

class HiveDbRepoImpl implements LocalDbRepository {
  final String pathDir;
  HiveDbRepoImpl({
    required this.pathDir,
  });
  

  @override
  Future<void> deleteCard({required Card card}) {
    // TODO: implement deleteCard
    throw UnimplementedError();
  }

  @override
  Future<void> deleteIdentity({required Identity identtity}) {
    // TODO: implement deleteIdentity
    throw UnimplementedError();
  }

  @override
  Future<void> deleteLogin({required Login login}) {
    // TODO: implement deleteLogin
    throw UnimplementedError();
  }

  @override
  Future<List<Card>> getAllCard() {
    // TODO: implement getAllCard
    throw UnimplementedError();
  }

  @override
  Future<List<Identity>> getAllIdentity() {
    // TODO: implement getAllIdentity
    throw UnimplementedError();
  }

  @override
  Future<List<Login>> getAllLogin() {
    // TODO: implement getAllLogin
    throw UnimplementedError();
  }

  @override
  Future<void> init() async {
    Hive.init(pathDir);
    logger.d('Hive inited');
  }

  @override
  Future<void> saveCard({required Card card}) {
    // TODO: implement saveCard
    throw UnimplementedError();
  }

  @override
  Future<void> saveIdentity({required Identity identity}) {
    // TODO: implement saveIdentity
    throw UnimplementedError();
  }

  @override
  Future<void> saveLogin({required Login login}) {
    // TODO: implement saveLogin
    throw UnimplementedError();
  }

  @override
  Future<void> updateCard({required Card card}) {
    // TODO: implement updateCard
    throw UnimplementedError();
  }

  @override
  Future<void> updateIdentity({required Identity identity}) {
    // TODO: implement updateIdentity
    throw UnimplementedError();
  }

  @override
  Future<void> updateLogin({required Login login}) {
    // TODO: implement updateLogin
    throw UnimplementedError();
  }
}
