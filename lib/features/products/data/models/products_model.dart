class ProductsModel {
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  const ProductsModel({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  String get formattedPrice => '${price.toStringAsFixed(0)} جنيه';
}