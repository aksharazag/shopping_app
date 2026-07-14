import 'package:get/get.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../domain/usecases/product_details_usecase.dart';
import '../controllers/product_details_controller.dart';
import '../../../core/network/api_client.dart';
import '../../../core/config/app_config.dart';
import 'package:hive/hive.dart';
import '../../data/models/product_model_hive.dart';

class ProductDetailsBinding extends Bindings {
  @override
  void dependencies() {
    final box = Hive.box<ProductModelHive>('productsBox');
    final repository = ProductRepositoryImpl(
      apiClient: ApiClient(baseUrl: AppConfig.apiBaseUrl),
      productBox: box,
    );

    Get.lazyPut(() => GetProductDetailsUseCase(repository));
    Get.lazyPut(() => ProductDetailsController(Get.find<GetProductDetailsUseCase>()));
  }
}
