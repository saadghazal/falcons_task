// To parse this JSON data, do
//
//     final company = companyFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Item> itemsFromJson(List<dynamic> items) =>
    List<Item>.from(items.map((x) => Item.fromJson(x)));

String itemsToJson(List<Item> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Item {
  final String comapnyno;
  final String itemno;
  final String name;
  final String cateogryid;
  final String itemK;
  final String barcode;
  final String minprice;
  final String iteml;
  final String issuspended;
  final String fD;
  final String itemhasserial;
  final String itempicspath;
  final String taxperc;
  final String isapipic;
  final String lsprice;

  Item({
    required this.comapnyno,
    required this.itemno,
    required this.name,
    required this.cateogryid,
    required this.itemK,
    required this.barcode,
    required this.minprice,
    required this.iteml,
    required this.issuspended,
    required this.fD,
    required this.itemhasserial,
    required this.itempicspath,
    required this.taxperc,
    required this.isapipic,
    required this.lsprice,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        comapnyno: json["COMAPNYNO"],
        itemno: json["ITEMNO"],
        name: json["NAME"],
        cateogryid: json["CATEOGRYID"],
        itemK: json["ItemK"],
        barcode: json["BARCODE"],
        minprice: json["MINPRICE"],
        iteml: json["ITEML"],
        issuspended: json["ISSUSPENDED"],
        fD: json["F_D"],
        itemhasserial: json["ITEMHASSERIAL"],
        itempicspath: json["ITEMPICSPATH"],
        taxperc: json["TAXPERC"],
        isapipic: json["ISAPIPIC"],
        lsprice: json["LSPRICE"],
      );

  Map<String, dynamic> toJson() => {
        "COMAPNYNO": comapnyno,
        "ITEMNO": itemno,
        "NAME": name,
        "CATEOGRYID": cateogryid,
        "ItemK": itemK,
        "BARCODE": barcode,
        "MINPRICE": minprice,
        "ITEML": iteml,
        "ISSUSPENDED": issuspended,
        "F_D": fD,
        "ITEMHASSERIAL": itemhasserial,
        "ITEMPICSPATH": itempicspath,
        "TAXPERC": taxperc,
        "ISAPIPIC": isapipic,
        "LSPRICE": lsprice,
      };
}
