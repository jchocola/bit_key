import 'package:equatable/equatable.dart';

class Card extends Equatable {
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
  Card({
    required this.id,
    required this.itemName,
    this.folderName,
    this.cardHolderName,
    this.number,
    this.brand,
    this.expMonth,
    this.expYear,
    this.secCode,
    this.isHide,
  });

  @override
  List<Object?> get props => [
    id,
    itemName,
    folderName,
    cardHolderName,
    number,
    brand,
    expMonth,
    expYear,
    secCode,
    isHide,
  ];

  @override
  String toString() {
    return 'Card(id: $id, itemName: $itemName, isHide: $isHide, folderName: $folderName, cardHolderName: $cardHolderName, number: $number, brand: $brand, expMonth: $expMonth, expYear: $expYear, secCode: $secCode)';
  }
}
