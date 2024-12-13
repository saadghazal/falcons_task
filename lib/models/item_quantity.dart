import 'package:meta/meta.dart';
import 'dart:convert';

List<ItemQuantity> itemQuantityFromJson(List<dynamic> quantities) =>
    List<ItemQuantity>.from(quantities.map((x) => ItemQuantity.fromJson(x)));

String itemQuantityToJson(List<ItemQuantity> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ItemQuantity {
  final String comapnyno;
  final String stockCode;
  final String itemOCode;
  final String qty;

  ItemQuantity({
    required this.comapnyno,
    required this.stockCode,
    required this.itemOCode,
    required this.qty,
  });

  factory ItemQuantity.fromJson(Map<String, dynamic> json) => ItemQuantity(
        comapnyno: json["COMAPNYNO"],
        stockCode: json["STOCK_CODE"],
        itemOCode: json["ItemOCode"],
        qty: json["QTY"],
      );

  Map<String, dynamic> toJson() => {
        "COMAPNYNO": comapnyno,
        "STOCK_CODE": stockCode,
        "ItemOCode": itemOCode,
        "QTY": qty,
      };
}
