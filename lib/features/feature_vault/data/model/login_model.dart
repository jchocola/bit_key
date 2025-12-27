import 'package:bit_key/features/feature_vault/domain/entity/login.dart';
import 'package:hive/hive.dart';
part 'login_model.g.dart';

@HiveType(typeId: 0)
class LoginModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String itemName;
  @HiveField(2)
  final String? folderName;
  @HiveField(3)
  final String? login;
  @HiveField(4)
  final String? password;
  @HiveField(5)
  final String? url;
  @HiveField(6)
  final bool? isHide; // bin
  LoginModel({
    required this.id,
    required this.itemName,
    this.folderName,
    this.login,
    this.password,
    this.url,
    this.isHide,
  });

  Login toEntity() => Login(
    id: id,
    itemName: itemName,
    folderName: folderName,
    login: login,
    password: password,
    url: url,
    isHide: isHide,
  );

  factory LoginModel.fromEntity(Login login) => LoginModel(
    id: login.id,
    itemName: login.itemName,
    folderName: login.folderName,
    login: login.login,
    password: login.password,
    url: login.url,
    isHide: login.isHide,
  );
}
