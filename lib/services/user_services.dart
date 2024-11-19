import 'dart:convert';
import 'package:drivado_test_app/models/users.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  List<Users> _users = [];
  bool _isLoading = false;

  List<Users> get users => _users;
  bool get isLoading => _isLoading;

  Future<void> fetchUsers() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http
          .get(Uri.parse('https://673736a9aafa2ef222330e54.mockapi.io/users'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _users = data.map((json) => Users.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load users');
      }
    } catch (error) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
