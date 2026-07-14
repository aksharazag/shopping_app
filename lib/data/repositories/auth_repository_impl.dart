import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/user_model.dart';
import '../../core/network/api_client.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiClient apiClient;

  AuthRepositoryImpl({required this.apiClient});

  @override
  Future<void> register(User user) async {
    final userModel = UserModel(email: user.email, password: user.password);

    await apiClient.post('/users', userModel.toJson());
  }

  @override
  Future<User?> login(String email, String password) async {
    final users = await apiClient.get('/users');

    final userJson = (users as List).firstWhere(
          (u) => u['email'] == email && u['password'] == password,
      orElse: () => null,
    );

    if (userJson != null) {
      return UserModel.fromJson(userJson);
    }

    return null;
  }

  @override
  Future<void> logout() async{

  }
}


