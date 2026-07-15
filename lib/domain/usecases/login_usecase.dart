import 'package:shopping_app/data/models/user_model.dart';

import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;
  LoginUseCase(this.repository);

 Future<User> execute(String email, String password) async {
  final user = await repository.login(email, password);

  if (user != null) {
    return user;
  }

  throw Exception("Invalid email or password");
}
}