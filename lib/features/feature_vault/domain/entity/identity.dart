import 'package:equatable/equatable.dart';

class Identity extends Equatable {
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
  Identity({
    required this.id,
    required this.itemName,
    this.folderName,
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
    this.isHide
  });

  @override
  List<Object?> get props => [
    id,
    itemName,
    folderName,
    firstName,
    middleName,
    lastName,
    userName,
    company,
    nationalInsuranceNumber,
    passportName,
    licenseNumber,
    email,
    phone,
    address1,
    address2,
    address3,
    cityTown,
    country,
    postcode,
    isHide
  ];

  @override
  String toString() {
    return 'Identity(id: $id, itemName: $itemName, folderName: $folderName, isHide: $isHide, firstName: $firstName, middleName: $middleName, lastName: $lastName, userName: $userName, company: $company, nationalInsuranceNumber: $nationalInsuranceNumber, passportName: $passportName, licenseNumber: $licenseNumber, email: $email, phone: $phone, address1: $address1, address2: $address2, address3: $address3, cityTown: $cityTown, country: $country, postcode: $postcode)';
  }
}
