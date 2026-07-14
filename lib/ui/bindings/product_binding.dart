import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../../../core/config/app_config.dart';
import '../../../core/network/api_client.dart';
import '../../../data/repositories/product_repository_impl.dart';
import '../../data/models/product_model_hive.dart';
import '../../domain/usecases/product_usecase.dart';
import '../controllers/product_controller.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut(() => ProductUseCase(Get.find<ProductRepositoryImpl>()));
    Get.lazyPut(() => ProductController(Get.find<ProductUseCase>()));
    Get.lazyPut(() {
    final box = Hive.box<ProductModelHive>('productsBox');
    return ProductRepositoryImpl(
    apiClient: ApiClient(baseUrl: AppConfig.apiBaseUrl),
    productBox: box,
    );
    });

  }
}
