import 'package:bit_key/features/feature_vault/domain/entity/identity.dart';

class IdentityModel {
  //item details
  final String id;
  final String itemName;
  final String? folderName;
  final bool? isHide; // bin

  //personal details
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? userName;
  final String? company;

  //identification
  final String? nationalInsuranceNumber;
  final String? passportName;
  final String? licenseNumber;

  // contact info
  final String? email;
  final String? phone;

  //address
  final String? address1;
  final String? address2;
  final String? address3;
  final String? cityTown;
  final String? country;
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
}
