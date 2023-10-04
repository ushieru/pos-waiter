import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:total_pos_waiter/models/product.dart';
import 'package:total_pos_waiter/providers/auth_state_provider.dart';
import 'package:total_pos_waiter/services/http_services/products_service.dart';

final productsStateProvider =
    StateNotifierProvider<ProductsStateProvider, List<Product>>(
        (ref) => ProductsStateProvider(ref.read(authStateProvider)));

class ProductsStateProvider extends StateNotifier<List<Product>> {
  ProductsStateProvider(this.authState) : super([]) {
    getProducts();
    Timer.periodic(const Duration(seconds: 5), (timer) {
      getProducts();
    });
  }

  final AuthState authState;
  final _productsService = ProductsService();

  Future<void> getProducts() async {
    state = await _productsService.getProducts(authState.jwtToken);
  }
}
