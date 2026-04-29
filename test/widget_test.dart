// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:getx_state_management/features/product/data/entities/product_entity.dart';

void main() {
  test('ProductModel maps json correctly', () {
    final model = ProductEntity.fromJson({
      'id': 1,
      'title': 'Sample',
      'description': 'Sample description',
      'price': 100,
      'thumbnail': 'https://img.com/1.png',
      'images': ['https://img.com/1.png'],
      'rating': 4.5,
    });

    final entity = model.toModel();

    expect(entity.id, 1);
    expect(entity.title, 'Sample');
    expect(entity.images.length, 1);
  });
}
