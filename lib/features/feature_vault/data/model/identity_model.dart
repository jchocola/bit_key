import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

import 'package:bit_key/features/feature_vault/domain/entity/identity.dart';

part 'identity_model.g.dart';
@HiveType(typeId: 1)
class IdentityModel {
  //item details
   @HiveField(0)
  final String id;
   @HiveField(1)
  final String itemName;
   @HiveField(2)
  final String? folderName;
   @HiveField(3)
  final bool? isHide; // bin

  //personal details
   @HiveField(4)
  final String? firstName;
   @HiveField(5)
  final String? middleName;
   @HiveField(6)
  final String? lastName;
   @HiveField(7)
  final String? userName;
   @HiveField(8)
  final String? company;

  //identification
   @HiveField(9)
  final String? nationalInsuranceNumber;
   @HiveField(10)
  final String? passportName;
   @HiveField(11)
  final String? licenseNumber;

  // contact info
   @HiveField(12)
  final String? email;
   @HiveField(13)
  final String? phone;

  //address
   @HiveField(14)
  final String? address1;
   @HiveField(15)
  final String? address2;
   @HiveField(16)
  final String? address3;
   @HiveField(17)
  final String? cityTown;
   @HiveField(18)
  final String? country;
   @HiveField(19)
  final String? postcode;
  IdentityModel({
    required this.id,
    required this.itemName,
    this.folderName,
    this.isHide,
    this.firstName,
    this.middleName,
    this.lastName,
    this.userName,
    this.company,
    this.nationalInsuranceNumber,
    this.passportName,
    this.licenseNumber,
    this.email,
    this.phone,
    this.address1,
    this.address2,
    this.address3,
    this.cityTown,
    this.country,
    this.postcode,
  });

  Identity toEntity() => Identity(
    id: id,
    itemName: itemName,
    folderName: folderName,
    isHide: isHide,
    firstName: firstName,
    middleName: middleName,
    lastName: lastName,
    userName: userName,
    company: company,
    nationalInsuranceNumber: nationalInsuranceNumber,
    passportName: passportName,
    licenseNumber: licenseNumber,
    email: email,
    phone: phone,
    address1: address1,
    address2: address2,
    address3: address3,
    cityTown: cityTown,
    country: country,
    postcode: postcode,
  );

  factory IdentityModel.fromEntity(Identity identity) =>
      IdentityModel(id: identity.id, itemName: identity.itemName,
      folderName: identity.folderName,
      isHide: identity.isHide,
      firstName: identity.firstName,
      middleName: identity.middleName,
      lastName: identity.lastName,
      userName: identity.userName,
      company: identity.company,
      nationalInsuranceNumber: identity.nationalInsuranceNumber,
      passportName: identity.passportName,
      licenseNumber: identity.licenseNumber,
      email: identity.email,
      phone: identity.phone,
      address1: identity.address1,
      address2: identity.address2,
      address3: identity.address3,
      cityTown: identity.cityTown,
      country: identity.country,
      postcode: identity.postcode,
      );

  IdentityModel copyWith({
    String? id,
    String? itemName,
    String? folderName,
    bool? isHide,
    String? firstName,
    String? middleName,
    String? lastName,
    String? userName,
    String? company,
    String? nationalInsuranceNumber,
    String? passportName,
    String? licenseNumber,
    String? email,
    String? phone,
    String? address1,
    String? address2,
    String? address3,
    String? cityTown,
    String? country,
    String? postcode,
  }) {
    return IdentityModel(
      id: id ?? this.id,
      itemName: itemName ?? this.itemName,
      folderName: folderName  ?? this.folderName,
      isHide: isHide ?? this.isHide,
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      userName: userName ?? this.userName,
      company: company ?? this.company,
      nationalInsuranceNumber: nationalInsuranceNumber ?? this.nationalInsuranceNumber,
      passportName: passportName ?? this.passportName,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address1: address1 ?? this.address1,
      address2: address2 ?? this.address2,
      address3: address3 ?? this.address3,
      cityTown: cityTown ?? this.cityTown,
      country: country ?? this.country,
      postcode: postcode?? this.postcode,
    );
  }
}
