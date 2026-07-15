import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/register_usecase.dart';

class AuthController extends GetxController {
  final RegisterUseCase registerUseCase;
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;


  AuthController(this.registerUseCase, this.loginUseCase, this.logoutUseCase);

  var isLoading = false.obs;
  //var isLoggedIn = false.obs;
  var currentUser = Rxn<User>();

  Future<bool> register(String email, String password) async {
    try {
    isLoading.value = true;

  //create user entity
      final user = User(email: email, password: password);
      // Call use case
      await registerUseCase.execute(user);

      return true;
      //show success
      
    } catch (e) {
      print("Registration failed: ${e.toString()}");


      Get.snackbar("Error", "Registration failed ${e.toString()}");
       return false;
    } finally {
      isLoading.value = false;
    }
  }


Future<void> login(String email, String password) async {
  try {
    isLoading.value = true;

    final user = await loginUseCase.execute(email, password);
    currentUser.value = user;

    if (user == null) {
      Get.dialog(
        AlertDialog(
          title: const Text("Login Failed"),
          content: const Text(
            "Invalid email or password",
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text("OK"),
            ),
          ],
        ),
      );
      return;
    }

    Get.offAllNamed('/home');
  } catch (e) {
    Get.dialog(
      AlertDialog(
        title: const Text("Error"),
        content: Text("Login failed\n$e"),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  } finally {
    isLoading.value = false;
  }
}
  Future<void> logout() async {
    await logoutUseCase();
    Get.offAllNamed('/login'); // clears navigation stack
  }



}
