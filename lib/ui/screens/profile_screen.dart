import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/profile_model_hive.dart';
import '../controllers/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
// passed from login user
  final String email = Get.arguments?['email'] ?? '';

   ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    controller.loadProfile(email);

    final nameController = TextEditingController();
    final addressController = TextEditingController();
    final phoneController = TextEditingController();
    final pinController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Obx(() {
        final profile = controller.profile.value;
        if (profile != null) {
          nameController.text = profile.name;
          addressController.text = profile.address;
          phoneController.text = profile.phone;
          pinController.text = profile.pinCode;
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              GestureDetector(
                onTap: () => _showImagePicker(context, controller),
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: profile?.imagePath != null
                      ? FileImage(File(profile!.imagePath!))
                      : null,
                  child: profile?.imagePath == null
                      ? const Icon(Icons.camera_alt, size: 40)
                      : null,
                ),
              ),
              const SizedBox(height: 20),
              _buildTextField("Name", nameController),
              _buildTextField("Address", addressController),
              _buildTextField("Phone", phoneController),
              _buildTextField("Pin Code", pinController),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final newProfile = ProfileModelHive(
                    email: email,
                    name: nameController.text,
                    address: addressController.text,
                    phone: phoneController.text,
                    pinCode: pinController.text,
                    imagePath: profile?.imagePath,
                  );
                  controller.saveProfile(newProfile);
                  Get.snackbar("Success", "Profile saved!");
                },
                child: const Text("Save"),
              ),
            ],
          ),
        );
      }),
    );
  }

  void _showImagePicker(BuildContext context, ProfileController controller) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text("Camera"),
            onTap: () {
              controller.pickImage(true);
              Get.back();
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text("Gallery"),
            onTap: () {
              controller.pickImage(false);
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

