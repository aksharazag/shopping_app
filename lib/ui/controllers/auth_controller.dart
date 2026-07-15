import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/register_usecase.dart';

class AuthController extends GetxController {
  RxBool isPasswordHidden = true.obs;
  RxBool isConfirmPasswordHidden = true.obs;
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


  Future<bool> login(String email, String password) async {
    try{
      isLoading.value = true;
      final user = await loginUseCase.execute(email, password);
        print("User: $user");
      currentUser.value = user;
     
        Get.offAllNamed('/home');
         return true;
    } catch (e){
      
Get.defaultDialog(
      title: "Login Failed",
      middleText: "Invalid email or password",
      textConfirm: "OK",
      confirmTextColor: Colors.white,
      buttonColor: Colors.orange,
      onConfirm: () => Get.back(),
    );

      return false;

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
