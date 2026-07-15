import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/utils/validators.dart';
import '../controllers/auth_controller.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/logo_widget.dart';

class RegisterScreen extends StatelessWidget {
  RxBool isPasswordHidden = true.obs;
  RxBool isConfirmPasswordHidden = true.obs;

  final AuthController controller = Get.find();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 60),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LogoWidget(text: "Happy Store"),
              SizedBox(height: 40),
              CustomTextField(
                controller: emailController,
                label: "Enter Email",
                validator: Validators.validateEmail,
              ),
              SizedBox(height: 20),
              Obx(
                () => CustomTextField(
                  controller: passwordController,
                  label: "Enter Password",
                  obscureText: isPasswordHidden.value,
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordHidden.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.orange,
                    ),
                    onPressed: () => isPasswordHidden.toggle(),
                  ),
                  validator: Validators.validatePassword,
                ),
              ),
              SizedBox(height: 20),
              Obx(
                () => CustomTextField(
                  controller: confirmPasswordController,
                  label: "Enter Confirm Password",
                  obscureText: isConfirmPasswordHidden.value,
                  suffixIcon: IconButton(
                    icon: Icon(
                      isConfirmPasswordHidden.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.orange,
                    ),
                    onPressed: () => isConfirmPasswordHidden.toggle(),
                  ),
                  validator: (value) => Validators.validateConfirmPassword(
                    passwordController.text,
                    value,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Obx(
                () => CustomButton(
                  text: "Sign up",
                  loading: controller.isLoading.value,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      bool success = await controller.register(
                        emailController.text,
                        passwordController.text,
                      );
                      if (success) {
                        Get.defaultDialog(
                          title: "Registration Successful",
                          middleText:
                              "Your account has been created successfully.",
                          textConfirm: "OK",
                          confirmTextColor: Colors.white,
                          buttonColor: Colors.deepOrange,
                          onConfirm: () {
                            Get.back(); // Close dialog
                            Get.offAllNamed('/login'); // Go to Login Screen
                          },
                        );
                      }
                    }
                  },
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () => Get.back(),
                child: Text("Already have an account? Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
