import 'package:bit_key/features/feature_vault/domain/entity/login.dart';

class LoginModel {
  final String id;
  final String itemName;
  final String? folderName;
  final String? login;
  final String? password;
  final String? url;
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
