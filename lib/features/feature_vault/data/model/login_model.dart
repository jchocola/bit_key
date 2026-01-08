import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

import 'package:bit_key/features/feature_vault/domain/entity/login.dart';

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

  LoginModel copyWith({
    String? id,
    String? itemName,
    String? folderName,
    String? login,
    String? password,
    String? url,
    bool? isHide,
  }) {
    return LoginModel(
      id: id ?? this.id,
      itemName: itemName ?? this.itemName,
      folderName: folderName ?? this.folderName,
      login: login ?? this.login,
      password: password ?? this.password,
      url: url ?? this.url,
      isHide: isHide ?? this.isHide,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'itemName': itemName,
      'folderName': folderName,
      'login': login,
      'password': password,
      'url': url,
      'isHide': isHide,
    };
  }

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      id: map['id'] ?? '',
      itemName: map['itemName'] ?? '',
      folderName: map['folderName'],
      login: map['login'],
      password: map['password'],
      url: map['url'],
      isHide: map['isHide'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginModel.fromJson(String source) => LoginModel.fromMap(json.decode(source));
}
