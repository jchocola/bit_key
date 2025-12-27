// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CardModelAdapter extends TypeAdapter<CardModel> {
  @override
  final int typeId = 2;

  @override
  CardModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CardModel(
      id: fields[0] as String,
      itemName: fields[1] as String,
      isHide: fields[2] as bool?,
      folderName: fields[3] as String?,
      cardHolderName: fields[4] as String?,
      number: fields[5] as String?,
      brand: fields[6] as String?,
      expMonth: fields[7] as int?,
      expYear: fields[8] as int?,
      secCode: fields[9] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, CardModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.itemName)
      ..writeByte(2)
      ..write(obj.isHide)
      ..writeByte(3)
      ..write(obj.folderName)
      ..writeByte(4)
      ..write(obj.cardHolderName)
      ..writeByte(5)
      ..write(obj.number)
      ..writeByte(6)
      ..write(obj.brand)
      ..writeByte(7)
      ..write(obj.expMonth)
      ..writeByte(8)
      ..write(obj.expYear)
      ..writeByte(9)
      ..write(obj.secCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
