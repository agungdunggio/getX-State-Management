import 'package:getx_state_management/features/product/domain/models/product_model.dart';

class ProductEntity {
  const ProductEntity({
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

  factory ProductEntity.fromJson(Map<String, dynamic> json) {
    return ProductEntity(
      id: json['id'] as int,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      price: json['price'] as num? ?? 0,
      thumbnail: json['thumbnail'] as String? ?? '',
      images: (json['images'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
      rating: json['rating'] as num? ?? 0,
    );
  }

  ProductModel toModel() {
    return ProductModel(
      id: id,
      title: title,
      description: description,
      price: price,
      thumbnail: thumbnail,
      images: images,
      rating: rating,
    );
  }
}
