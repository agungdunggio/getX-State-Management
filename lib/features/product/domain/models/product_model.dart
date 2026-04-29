class ProductModel {
  const ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.thumbnail,
    required this.images,
    required this.rating,
  });

  final int id;
  final String title;
  final String description;
  final num price;
  final String thumbnail;
  final List<String> images;
  final num rating;
}
