class Product {
  final String id;
  final String productName;
  final double price;
  final String description;
  final String category;
  final String brand;
  final List<String> images;
  final int discount ;
   int? quantity;


  Product( {
    required this.id,
    required this.productName,
    required this.price,
    required this.description,
    required this.category,
    required this.brand,
    required this.images,
    required this.discount,
    this.quantity =1,


  });
}
