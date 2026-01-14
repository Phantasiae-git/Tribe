import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  static const String baseUrl = "http://10.19.213.237/api/";

  Future<http.Response> get(String path) {
    return http
        .get(Uri.parse("$baseUrl$path"))
        .timeout(const Duration(seconds: 10));
  }

  Future<http.Response> post(
    String path, {
    Map<String, dynamic>? body,
  }) {
    return http
        .post(
          Uri.parse("$baseUrl$path"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(body),
        )
        .timeout(const Duration(seconds: 10));
  }

  Future<http.Response> put(
    String path, {
    Map<String, dynamic>? body,
  }) {
    return http
        .put(
          Uri.parse("$baseUrl$path"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(body),
        )
        .timeout(const Duration(seconds: 10));
  }

  Future<http.Response> delete(String path) {
    return http
        .delete(Uri.parse("$baseUrl$path"))
        .timeout(const Duration(seconds: 10));
  }
}
