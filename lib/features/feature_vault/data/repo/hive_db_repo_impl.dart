import 'package:bit_key/core/exception/app_exception.dart';
import 'package:bit_key/features/feature_vault/data/model/card_model.dart';
import 'package:bit_key/features/feature_vault/data/model/identity_model.dart';
import 'package:bit_key/features/feature_vault/data/model/login_model.dart';
import 'package:hive/hive.dart';

import 'package:bit_key/features/feature_vault/domain/entity/card.dart';
import 'package:bit_key/features/feature_vault/domain/entity/identity.dart';
import 'package:bit_key/features/feature_vault/domain/entity/login.dart';
import 'package:bit_key/features/feature_vault/domain/repo/local_db_repository.dart';
import 'package:bit_key/main.dart';

class HiveDbRepoImpl implements LocalDbRepository {
  final String pathDir;

  ///
  /// KEYS
  ///
  static const LOGIN_BOX = 'LOGIN';
  static const CARD_BOX = 'CARD';
  static const IDENTITY_BOX = 'IDENTITY';

  late Box<dynamic> _loginsBox;
  late Box<dynamic> _cardsBox;
  late Box<dynamic> _identitiesBox;

  HiveDbRepoImpl({required this.pathDir});

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
  Future<List<Card>> getAllCard() async {
    try {
      final listValues = _cardsBox.values;
      final listModel = listValues.map((e) => e as CardModel).toList();
      return listModel.map((e) => e.toEntity()).toList();
    } catch (e) {
      logger.e(e);
      return [];
    }
  }

  @override
  Future<List<Identity>> getAllIdentity() async {
    try {
      final values = _identitiesBox.values;
      final listModel = values.map((e) => e as IdentityModel).toList();
      return listModel.map((e) => e.toEntity()).toList();
    } catch (e) {
      logger.e(e);
      return [];
    }
  }

  @override
  Future<List<Login>> getAllLogin() async {
    try {
      final values = _loginsBox.values;

      final listModel = values.map((e) => e as LoginModel).toList();
      return listModel.map((e) => e.toEntity()).toList();
    } catch (e) {
      logger.e(e);
      return [];
    }
  }

  @override
  Future<void> init() async {
    // INIT
    Hive.init(pathDir);
    // REGISTER ADAPTER
    Hive.registerAdapter(LoginModelAdapter());
    Hive.registerAdapter(CardModelAdapter());
    Hive.registerAdapter(IdentityModelAdapter());

    // OPEN BOX
    await Hive.openBox(LOGIN_BOX);
    await Hive.openBox(CARD_BOX);
    await Hive.openBox(IDENTITY_BOX);

    // BOXES
    _loginsBox = Hive.box(LOGIN_BOX);
    _cardsBox = Hive.box(CARD_BOX);
    _identitiesBox = Hive.box(IDENTITY_BOX);

    logger.d('Hive inited , box opened and registered adapters');
  }

  @override
  Future<void> saveCard({required Card card}) async {
    try {
      final cardModel = CardModel.fromEntity(card);
      await _cardsBox.add(cardModel);
      logger.d('Added new card');
    } catch (e) {
      logger.e(e);
    }
  }

  @override
  Future<void> saveIdentity({required Identity identity}) async {
    try {
      final identityModel = IdentityModel.fromEntity(identity);
      await _identitiesBox.add(identityModel);
      logger.d('Added new identity');
    } catch (e) {
      logger.e(e);
    }
  }

  @override
  Future<void> saveLogin({required Login login}) async {
    try {
      final loginModel = LoginModel.fromEntity(login);
      await _loginsBox.add(loginModel);
      logger.d('Added new login');
    } catch (e) {
      logger.e(e);
      throw AppException.failed_to_save_login;
    }
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

  @override
  Future<List<Card>> getCardsWithoutFolder() async {
    try {
      final allCard = await getAllCard();

      final filteredCards = allCard.where((e) => e.folderName == null).toList();
      return filteredCards;
    } catch (e) {
      logger.e(e);
      return [];
    }
  }

  @override
  Future<List<Identity>> getIdentiesWithoutFolder() async{
    try {
      final identities = await getAllIdentity();

      final filteredIdentities = identities.where((e) => e.folderName == null).toList();
      return filteredIdentities;
    } catch (e) {
      logger.e(e);
      return [];
    }
  }

  @override
  Future<List<Login>> getLoginsWithoutFolder() async{
     try {
      final logins = await getAllLogin();

      final filteredLogins = logins.where((e) => e.folderName == null).toList();
      return filteredLogins;
    } catch (e) {
      logger.e(e);
      return [];
    }
  }
}
