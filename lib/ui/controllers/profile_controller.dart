
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/models/profile_model_hive.dart';
import '../../domain/usecases/profile_usecase.dart';

class ProfileController extends GetxController {
  final SaveProfileUseCase saveProfileUseCase;
  final GetProfileUseCase getProfileUseCase;

  var profile = Rxn<ProfileModelHive>();
  final picker = ImagePicker();

  ProfileController(this.saveProfileUseCase, this.getProfileUseCase);

  Future<void> loadProfile(String email) async {
    final data = await getProfileUseCase(email);
    profile.value = data;
  }

  Future<void> saveProfile(ProfileModelHive newProfile) async {
    await saveProfileUseCase(newProfile);
    profile.value = newProfile;
  }

  Future<void> pickImage(bool fromCamera) async {
    final pickedFile = await picker.pickImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
    );
    if (pickedFile != null) {
      profile.value = ProfileModelHive(
        email: profile.value?.email ?? '',
        name: profile.value?.name ?? '',
        address: profile.value?.address ?? '',
        phone: profile.value?.phone ?? '',
        pinCode: profile.value?.pinCode ?? '',
        imagePath: pickedFile.path,
      );
      update();
    }
  }
}
