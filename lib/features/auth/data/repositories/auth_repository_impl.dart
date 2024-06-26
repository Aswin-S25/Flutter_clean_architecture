import 'dart:convert';

import 'package:clean_architecture/features/auth/data/models/user_model.dart';
import 'package:clean_architecture/features/auth/domain/entites/user.dart';
import 'package:clean_architecture/features/auth/domain/repositories/auth_repository.dart';
import 'package:http/http.dart' as http;

class AuthRepositoryImpl implements AuthRepository {
  final http.Client client;

  AuthRepositoryImpl(this.client);

  @override
  Future<User> login(String username, String password) async {
    final response = await client.post(
      Uri.parse('https://example.com/api/login'),
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to login');
    }
  }

  @override
  Future<User> register(String username, String email, String password) async {
    final response = await client.post(
        Uri.parse('https://example.om/api/register'),
        body: jsonEncode(
            {'username': username, 'email': email, 'password': password}));

    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to register');
    }
  }
}
