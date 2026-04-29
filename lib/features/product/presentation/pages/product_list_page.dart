import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:getx_state_management/app.dart';
import 'package:getx_state_management/features/auth/presentation/controllers/auth_controller.dart';
import 'package:getx_state_management/features/product/presentation/controllers/product_controller.dart';
import 'package:getx_state_management/features/product/presentation/widgets/product_list_item.dart';

class ProductListPage extends GetView<ProductController> {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            onPressed: () => Get.find<AuthController>().logout(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoadingProducts.value && controller.products.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        final error = controller.productErrorMessage.value;
        if (error != null && controller.products.isEmpty) {
          return Center(child: Text(error));
        }

        return RefreshIndicator(
          onRefresh: controller.loadInitialProducts,
          child: ListView.builder(
            controller: controller.scrollController,
            itemCount: controller.products.length + 1,
            itemBuilder: (context, index) {
              if (index == controller.products.length) {
                return Obx(() {
                  if (controller.isLoadingMore.value) {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  if (!controller.hasMore.value) {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: Text('Semua data sudah dimuat')),
                    );
                  }
                  return const SizedBox.shrink();
                });
              }

              final product = controller.products[index];
              return ProductListItem(
                product: product,
                onTap: () =>
                    Get.toNamed(AppRoutes.productDetail, arguments: product.id),
              );
            },
          ),
        );
      }),
    );
  }
}
