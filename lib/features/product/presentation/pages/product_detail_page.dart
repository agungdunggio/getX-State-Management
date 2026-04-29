import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:getx_state_management/features/product/presentation/controllers/product_controller.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late final ProductController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.find<ProductController>();
    final id = Get.arguments as int?;
    if (id != null) {
      Future.microtask(() => _controller.loadProductDetail(id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Detail')),
      body: Obx(() {
        if (_controller.isLoadingDetail.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final error = _controller.detailErrorMessage.value;
        if (error != null) {
          return Center(child: Text(error));
        }

        final product = _controller.selectedProduct.value;
        if (product == null) {
          return const SizedBox.shrink();
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                product.thumbnail,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 12),
              Text(
                product.title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(product.description),
              const SizedBox(height: 8),
              Text(
                'Harga: \$${product.price} | Rating: ${product.rating}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 20),
              Text(
                'Rekomendasi',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Obx(() {
                if (_controller.isLoadingRecommendations.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                final recommendationError =
                    _controller.recommendationErrorMessage.value;
                if (recommendationError != null) {
                  return Text(recommendationError);
                }
                return SizedBox(
                  height: 200,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _controller.recommendations.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final recommended = _controller.recommendations[index];
                      return SizedBox(
                        width: 160,
                        child: Card(
                          child: InkWell(
                            onTap: () =>
                                _controller.loadProductDetail(recommended.id),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Image.network(
                                      recommended.thumbnail,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    recommended.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text('\$${recommended.price}'),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
            ],
          ),
        );
      }),
    );
  }
}
