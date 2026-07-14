import 'package:shopping_app/domain/entities/product.dart';

class CalculateCartTotalUseCase {
  double getTotalPrice(List<Product> items) {
    return items.fold(
      0,
      (sum, item) => sum + (item.price * (item.quantity ?? 1)),
    );
  }

  double getTotalDiscount(List<Product> items) {
    return items.fold(0, (sum, item) {
      final quantity = item.quantity ?? 1;
      final discountAmount = (item.discount != null)
          ? (item.price * quantity * item.discount / 100)
          : 0;
      return sum + discountAmount;
    });
  }

  double afterDiscountPrice(List<Product> items) {
    final totalPrice = getTotalPrice(items);
    final totalDiscount = getTotalDiscount(items);
    return totalPrice - totalDiscount;
  }
}
