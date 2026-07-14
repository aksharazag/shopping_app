import 'package:get/get.dart';
import '../../core/config/app_config.dart';
import '../../core/network/api_client.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../controllers/auth_controller.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(
      apiClient: ApiClient(baseUrl: AppConfig.apiBaseUrl),
    ));
    //Register use case
    Get.lazyPut(() => RegisterUseCase(Get.find()));
    Get.lazyPut(() => LoginUseCase(Get.find()));
    Get.lazyPut(() => LogoutUseCase(Get.find()));
    //Register controller (global)
    Get.put<AuthController>(
      AuthController(Get.find<RegisterUseCase>(), Get.find<LoginUseCase>(),Get.find<LogoutUseCase>()),
      permanent: true,
    );
//permanent: true ensures the AuthController is never disposed during app lifetime.
   //  This makes AuthController.currentUser accessible from anywhere.

  }
}
