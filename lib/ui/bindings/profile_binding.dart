import 'package:get/get.dart';
import '../../data/repositories/profile_repository_impl.dart';
import '../../domain/usecases/profile_usecase.dart';
import '../controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    final repo = ProfileRepositoryImpl();
    Get.lazyPut(() => SaveProfileUseCase(repo));
    Get.lazyPut(() => GetProfileUseCase(repo));
    Get.put(ProfileController(Get.find(), Get.find()), permanent: true);
  }
}
