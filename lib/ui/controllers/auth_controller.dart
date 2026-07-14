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
    try{
      isLoading.value = true;
      final user = await loginUseCase.execute(email, password);
      currentUser.value = user;
      if (user == null) {
        Get.snackbar(
          "Error",
          "Invalid email or password",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.8),
          colorText: Colors.white,
        );
        return; // stop here
      }
      Get.offAllNamed('/home');
     // print(currentUser.value?.email);

    }catch (e){
      Get.snackbar(
        "Error $e",
        "Login failed",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );

    } finally {
      isLoading.value = false;
    }
  }
  // void logout() {
  //   currentUser.value = null;
  //   Get.offAllNamed('/login');
  // }
  Future<void> logout() async {
    await logoutUseCase();
    Get.offAllNamed('/login'); // clears navigation stack
  }



}
