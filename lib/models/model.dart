// To parse this JSON data, do
//
//     final bankingAppModel = bankingAppModelFromJson(jsonString);

import 'dart:convert';

List<BankingAppModel> bankingAppModelFromJson(String str) => List<BankingAppModel>.from(json.decode(str).map((x) => BankingAppModel.fromJson(x)));

String bankingAppModelToJson(List<BankingAppModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BankingAppModel {
  BankingAppModel({
    required this.relation,
    required this.phoneNum,
    required this.name,
    required this.id,
  });

  String relation;
  String phoneNum;
  String name;
  String id;

  factory BankingAppModel.fromJson(Map<String, dynamic> json) => BankingAppModel(
    relation: json["relation"],
    phoneNum: json["phoneNum"],
    name: json["name"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "relation": relation,
    "phoneNum": phoneNum,
    "name": name,
    "id": id,
  };
}
