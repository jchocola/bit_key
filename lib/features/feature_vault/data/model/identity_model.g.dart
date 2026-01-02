// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'identity_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IdentityModelAdapter extends TypeAdapter<IdentityModel> {
  @override
  final int typeId = 1;

  @override
  IdentityModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IdentityModel(
      id: fields[0] as String,
      itemName: fields[1] as String,
      folderName: fields[2] as String?,
      isHide: fields[3] as bool?,
      firstName: fields[4] as String?,
      middleName: fields[5] as String?,
      lastName: fields[6] as String?,
      userName: fields[7] as String?,
      company: fields[8] as String?,
      nationalInsuranceNumber: fields[9] as String?,
      passportName: fields[10] as String?,
      licenseNumber: fields[11] as String?,
      email: fields[12] as String?,
      phone: fields[13] as String?,
      address1: fields[14] as String?,
      address2: fields[15] as String?,
      address3: fields[16] as String?,
      cityTown: fields[17] as String?,
      country: fields[18] as String?,
      postcode: fields[19] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, IdentityModel obj) {
    writer
      ..writeByte(20)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.itemName)
      ..writeByte(2)
      ..write(obj.folderName)
      ..writeByte(3)
      ..write(obj.isHide)
      ..writeByte(4)
      ..write(obj.firstName)
      ..writeByte(5)
      ..write(obj.middleName)
      ..writeByte(6)
      ..write(obj.lastName)
      ..writeByte(7)
      ..write(obj.userName)
      ..writeByte(8)
      ..write(obj.company)
      ..writeByte(9)
      ..write(obj.nationalInsuranceNumber)
      ..writeByte(10)
      ..write(obj.passportName)
      ..writeByte(11)
      ..write(obj.licenseNumber)
      ..writeByte(12)
      ..write(obj.email)
      ..writeByte(13)
      ..write(obj.phone)
      ..writeByte(14)
      ..write(obj.address1)
      ..writeByte(15)
      ..write(obj.address2)
      ..writeByte(16)
      ..write(obj.address3)
      ..writeByte(17)
      ..write(obj.cityTown)
      ..writeByte(18)
      ..write(obj.country)
      ..writeByte(19)
      ..write(obj.postcode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IdentityModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
