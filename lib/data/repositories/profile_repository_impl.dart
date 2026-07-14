import 'package:hive/hive.dart';
import '../../domain/repositories/profile_repository.dart';
import '../models/profile_model_hive.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  @override
  Future<void> saveProfile(ProfileModelHive profile) async {
    final box = await Hive.openBox<ProfileModelHive>('profiles');
    await box.put(profile.email, profile);
  }

  @override
  Future<ProfileModelHive?> getProfile(String email) async {
    final box = await Hive.openBox<ProfileModelHive>('profiles');
    return box.get(email);
  }
}
