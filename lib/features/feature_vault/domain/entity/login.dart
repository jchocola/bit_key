import 'package:equatable/equatable.dart';

class Login extends Equatable {
  final String id;
  final String itemName;
  final String? folderName;
  final String? login;
  final String? password;
  final String? url;
  final bool? isHide; // bin
  Login({
    required this.id,
    required this.itemName,
    this.folderName,
    this.login,
    this.password,
    this.url,
    this.isHide,
  });



  @override
  List<Object?> get props => [
    id,
    itemName,
    folderName,
    login,
    password,
    url,
    isHide,
  ];

  @override
  String toString() {
    return 'Login(id: $id, itemName: $itemName, folderName: $folderName, login: $login, password: $password, url: $url, isHide: $isHide)';
  }
}
