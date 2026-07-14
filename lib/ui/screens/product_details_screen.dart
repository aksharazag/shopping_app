import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shopping_app/widgets/appbar_menu.dart';
import 'package:shopping_app/widgets/bottom_buttons.dart';
import 'package:shopping_app/widgets/price_tag_row.dart';
import '../controllers/product_details_controller.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductDetailsController>();
    // final productId = Get.arguments as String; // passed from ProductCard
    // controller.loadProduct(productId); // for this added onInit() in controller

    return Scaffold(
      appBar: AppBarMenu(title: "Product Details"),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final product = controller.product.value;
        if (product == null) {
          return const Center(child: Text("Product not found"));
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              //Carousel with dots
              CarouselSlider.builder(
                itemCount: product.images.length,
                options: CarouselOptions(
                  height: 300,
                  viewportFraction: 1,
                  enlargeCenterPage: false,
                  autoPlay: true,
                  onPageChanged: (index, reason) {
                    controller.changeImage(index);
                  },
                ),
                itemBuilder: (context, index, realIndex) {
                  return Image.network(
                    product.images[index],
                    width: double.infinity,
                    fit: BoxFit.contain,
                  );
                },
              ),
              const SizedBox(height: 8),
              Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: product.images.asMap().entries.map((entry) {
                  return Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: controller.currentIndex.value == entry.key
                          ? Colors.deepOrange
                          : Colors.grey,
                    ),
                  );
                }).toList(),
              )),

              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(8.0),

                child: Text(product.description,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.normal,color: Colors.grey)),
              ),
              PriceTagWidget(product: product),
              const SizedBox(height: 16),

            ],
          ),
        );
      }),
      bottomNavigationBar: const BottomButtons(),
    );
  }
}
