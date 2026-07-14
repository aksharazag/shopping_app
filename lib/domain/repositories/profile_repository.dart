import '../../data/models/profile_model_hive.dart';

abstract class ProfileRepository {
  Future<void> saveProfile(ProfileModelHive profile);
  Future<ProfileModelHive?> getProfile(String email);
}
