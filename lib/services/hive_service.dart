import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:retake_exam6/models/model.dart';

class HiveDB {
  static String DB_NAME = "banking_app";
  static var box = Hive.box(DB_NAME);

// #store_saved_cards

  static Future<void> storeSavedCards(List<BankingAppModel> cards) async {
    List<String> list =
    List<String>.from(cards.map((card) => jsonEncode(card.toJson())));
    await box.put("cards", list);
  }

  // #load_saved_cards

  static List<BankingAppModel> loadSavedCards() {
    List<String> response = box.get("cards", defaultValue: <String>[]);
    List<BankingAppModel> list =
    List<BankingAppModel>.from(response.map((x) => BankingAppModel.fromJson(jsonDecode(x))));
    return list;
  }

  // store_noInternet_cards

  static Future<void> storeNoInternetCards(List<BankingAppModel> cards) async {
    List<String> list =
    List<String>.from(cards.map((card) => jsonEncode(card.toJson())));
    await box.put("no connection", list);
  }

  // #load_noInternet_cards

  static List<BankingAppModel> loadNoInternetCards() {
    List<String> response = box.get("no connection", defaultValue: <String>[]);
    List<BankingAppModel> list =
    List<BankingAppModel>.from(response.map((x) => BankingAppModel.fromJson(jsonDecode(x))));
    return list;
  }
}
