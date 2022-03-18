
import 'dart:convert';

import 'package:http/http.dart';

import '../models/model.dart';

class HttpService {
  // Base url
  static String BASE_URL = "6209f38292946600171c5626.mockapi.io";

  // Header
  static Map<String, String> headers =  {
    'Content-type': 'application/json; charset=UTF-8',
  };

  // Apis
  static String API_USER_LIST = "exam";
  static String API_CREATE_USER = "/exam";
  static String API_DELETE_USER = "/exam/"; //  {ID}

  // Methods
  static Future<String?> GET(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE_URL, api, params);
    Response response = await get(uri, headers: headers);
    if(response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  static Future<String?> POST(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE_URL, api);
    Response response = await post(uri, headers: headers, body: jsonEncode(params));
    if(response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Future<String?> PUT(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE_URL, api);
    Response response = await put(uri, headers: headers, body: jsonEncode(params));
    if(response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  static Future<String?> PATCH(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE_URL, api);
    Response response = await patch(uri, headers: headers, body: jsonEncode(params));
    if(response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  static Future<String?> DELETE(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE_URL, api, params);
    Response response = await delete(uri, headers: headers);
    if(response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  // Params
  static Map<String, String> paramEmpty() {
    Map<String, String> map = {};
    return map;
  }

  static Map<String, String> paramsCreate(BankingAppModel cardModel) {
    Map<String, String> map = {

      "name": cardModel.name.toString(),
      "relation": cardModel.relation.toString(),
      "phoneNum": cardModel.phoneNum.toString(),
    };
    return map;
  }

  // static Map<String, String> paramsUpdate(Todo todo) {
  //   Map<String, String> map = {
  //     'userId': todo.userId.toString(),
  //     'id': todo.id.toString(),
  //     'title': todo.title,
  //     'completed' : todo.completed.toString(),
  //   };
  //   return map;
  // }
  //
  // static Map<String, String> paramsEdit(String key, String value) {
  //   Map<String, String> map = {
  //     key: value,
  //   };
  //   return map;
  // }

  // Parsing
  static List<BankingAppModel> parseUserList(String body) {
    List<BankingAppModel> response = bankingAppModelFromJson(body);
    return response;

  }



}