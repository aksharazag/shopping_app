import '../../data/models/profile_model_hive.dart';
import '../../domain/repositories/profile_repository.dart';

class SaveProfileUseCase {
  final ProfileRepository repository;
  SaveProfileUseCase(this.repository);

  Future<void> call(ProfileModelHive profile) {
    return repository.saveProfile(profile);
  }
}

class GetProfileUseCase {
  final ProfileRepository repository;
  GetProfileUseCase(this.repository);

  Future<ProfileModelHive?> call(String email) {
    return repository.getProfile(email);
  }
}
