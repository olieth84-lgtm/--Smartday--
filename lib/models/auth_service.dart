import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

class AuthService {
  final String baseUrl = "https://reqres.in/api";

  // ---------------- Локальная регистрация ----------------
  static String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  static Future<bool> registerLocal(String login, String password) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('user_$login')) return false;
    final hash = hashPassword(password);
    await prefs.setString('user_$login', hash);
    return true;
  }

  static Future<bool> loginLocal(String login, String password) async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('user_$login')) return false;
    final savedHash = prefs.getString('user_$login');
    final inputHash = hashPassword(password);
    return savedHash == inputHash;
  }

  // ---------------- Серверный логин ----------------
  Future<String?> login(String email, String password) async {
    final url = Uri.parse("$baseUrl/login");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["token"];
    }
    return null;
  }
}
