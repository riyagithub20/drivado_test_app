import 'dart:convert';
import 'package:drivado_test_app/models/company.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CompanyProvider with ChangeNotifier {
  List<Company> _company = [];
  bool _isLoading = false;

  List<Company> get company => _company;
  bool get isLoading => _isLoading;

  Future<void> fetchCompany() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
          Uri.parse('https://673736a9aafa2ef222330e54.mockapi.io/company'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        _company = data.map((json) => Company.fromJson(json)).toList();
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
