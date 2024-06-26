
import 'package:clean_architecture/features/auth/domain/entites/user.dart';

abstract class AuthRepository {
  Future<User> login(String username, String password);
  Future<User> register(String username, String email, String password);
}