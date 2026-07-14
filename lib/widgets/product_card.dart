import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_app/ui/controllers/product_controller.dart';
import 'package:shopping_app/widgets/price_tag_row.dart';
import '../../domain/entities/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //Navigate to detail screen with GetX : here passing whole product
        //Get.to(()=> ProductDetailsScreen(product: product) );
        final controller = Get.find<ProductController>();
        controller.goToDetails(product.id);
      },
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: BorderSide(color: Colors.lightGreen, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(
                        product.images[0],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.image_not_supported),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 6),

              Text(
                product.productName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black87,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              PriceTagWidget(product: product),
              const SizedBox(height: 6),
            ],
          ),
        ),
      ),
    );
  }
}
