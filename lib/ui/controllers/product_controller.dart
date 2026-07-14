import 'package:get/get.dart';
import '../../../domain/entities/product.dart';
import '../../domain/usecases/product_usecase.dart';

class ProductController extends GetxController {
  final ProductUseCase productUseCase;

  ProductController(this.productUseCase);

  var products = <Product>[].obs;
  var isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    fetchProducts(); // called once when controller is created
  }
  Future<void> fetchProducts() async {
    isLoading.value = true;
    try {
      products.value = await productUseCase(); // must return List<Product>
    } catch (e) {
      print("Error fetching products: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void goToDetails(String productId) {
    Get.toNamed('/product-details', arguments: productId);
  }



}
