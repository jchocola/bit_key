import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

import 'package:bit_key/features/feature_vault/domain/entity/card.dart';

part 'card_model.g.dart';

@HiveType(typeId: 2)
class CardModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String itemName;
  @HiveField(2)
  final bool? isHide;
  @HiveField(3)
  final String? folderName;
  @HiveField(4)
  final String? cardHolderName;
  @HiveField(5)
  final String? number;
  @HiveField(6)
  final String? brand;
  @HiveField(7)
  final int? expMonth;
  @HiveField(8)
  final int? expYear;
  @HiveField(9)
  final int? secCode;
  CardModel({
    required this.id,
    required this.itemName,
    this.isHide,
    this.folderName,
    this.cardHolderName,
    this.number,
    this.brand,
    this.expMonth,
    this.expYear,
    this.secCode,
  });

  Card toEntity() => Card(
    id: id,
    itemName: itemName,
    isHide: isHide,
    folderName: folderName,
    cardHolderName: cardHolderName,
    number: number,
    brand: brand,
    expMonth: expMonth,
    expYear: expYear,
    secCode: secCode,
  );

  factory CardModel.fromEntity(Card card) => CardModel(
    id: card.id,
    itemName: card.itemName,
    isHide: card.isHide,
    folderName: card.folderName,
    cardHolderName: card.cardHolderName,
    number: card.number,
    brand: card.brand,
    expMonth: card.expMonth,
    expYear: card.expYear,
    secCode: card.secCode,
  );

  CardModel copyWith({
    String? id,
    String? itemName,
    bool? isHide,
    String? folderName,
    String? cardHolderName,
    String? number,
    String? brand,
    int? expMonth,
    int? expYear,
    int? secCode,
  }) {
    return CardModel(
      id: id ?? this.id,
      itemName: itemName ?? this.itemName,
      isHide:  isHide ?? this.isHide,
      folderName: folderName ?? this.folderName,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      number: number  ?? this.number,
      brand: brand ?? this.brand,
      expMonth: expMonth ?? this.expMonth,
      expYear: expYear ?? this.expYear,
      secCode: secCode ?? this.secCode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'itemName': itemName,
      'isHide': isHide,
      'folderName': folderName,
      'cardHolderName': cardHolderName,
      'number': number,
      'brand': brand,
      'expMonth': expMonth,
      'expYear': expYear,
      'secCode': secCode,
    };
  }

  factory CardModel.fromMap(Map<String, dynamic> map) {
    return CardModel(
      id: map['id'] ?? '',
      itemName: map['itemName'] ?? '',
      isHide: map['isHide'],
      folderName: map['folderName'],
      cardHolderName: map['cardHolderName'],
      number: map['number'],
      brand: map['brand'],
      expMonth: map['expMonth']?.toInt(),
      expYear: map['expYear']?.toInt(),
      secCode: map['secCode']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory CardModel.fromJson(String source) => CardModel.fromMap(json.decode(source));
}
