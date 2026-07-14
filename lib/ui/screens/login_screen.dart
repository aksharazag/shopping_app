import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/utils/validators.dart';
import '../controllers/auth_controller.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/logo_widget.dart';

class LoginScreen extends StatelessWidget {

  final AuthController controller = Get.find();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
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
              SizedBox(height: 50),
              Text(" Welcome Back ",style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
              SizedBox(height: 30),
              CustomTextField(controller: emailController,
                  label: "Email",
                  validator: Validators.validateEmail, ),
              SizedBox(height: 20),
              CustomTextField(controller: passwordController,
                  label: "Password",
                  obscureText: true,
                  validator: Validators.validatePassword, ),
              SizedBox(height: 30),
              Obx(() =>
                  CustomButton(
                    text: "Login",
                    loading: controller.isLoading.value,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        controller.login(
                            emailController.text, passwordController.text);
                      }
                    },
                  )),
              SizedBox(height: 20),
              TextButton(onPressed: () => Get.toNamed('/register'),
                  child: Text("Don't have an account? Register")),
            ],
          ),
        ),
      ),
    );
  }
  }