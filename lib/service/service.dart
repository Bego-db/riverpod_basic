import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:riverpod_app/model/games_model.dart';
import 'package:riverpod_app/model/user_model.dart';

class Service {
  static Future<UserModel?> fetchGames() async {
    var url = Uri.parse("https://reqres.in/api/users?page=2");
    var response;
    try {
      response = await http.get(url);
      if (response.statusCode == 200) {
        return UserModel.fromJson(jsonDecode(response.body));
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  
  static Future<List<Games>?> fetchGames2() async {
    final response =
        await http.get(Uri.parse('https://www.freetogame.com/api/games'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
