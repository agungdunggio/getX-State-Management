import 'package:flutter/material.dart';

import 'package:getx_state_management/features/product/domain/models/product_model.dart';

class ProductListItem extends StatelessWidget {
  const ProductListItem({
    required this.product,
    required this.onTap,
    super.key,
  });

  final ProductModel product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: Image.network(
          product.thumbnail,
          width: 56,
          height: 56,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.image_not_supported),
        ),
        title: Text(product.title),
        subtitle: Text(
          product.description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text('\$${product.price}'),
      ),
    );
  }
}
