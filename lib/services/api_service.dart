import 'dart:convert';

import '../models/user_credentials.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://fakestoreapi.com';

  Future<dynamic> processLogin(String userName, String pass) {
    final userCredentials = UserCredentials(username: userName, password: pass);

    return http
        .post(Uri.parse('$baseUrl/auth/login'), body: userCredentials.toJson())
        .then((data) {
      if (data.statusCode == 200) {
        return json.decode(data.body);
      }
    }).catchError((err) => print(err));
  }
}
