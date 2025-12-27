import 'dart:convert';

import 'package:bit_key/features/feature_vault/domain/entity/card.dart';

class CardModel {
  final String id;
  final String itemName;
  final bool? isHide;
  final String? folderName;
  final String? cardHolderName;
  final String? number;
  final String? brand;
  final int? expMonth;
  final int? expYear;
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
}
