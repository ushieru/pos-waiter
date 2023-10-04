import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:total_pos_waiter/models/category.dart';
import 'package:total_pos_waiter/providers/auth_state_provider.dart';
import 'package:total_pos_waiter/services/http_services/categories_service.dart';

final categoriesStateProvider =
    StateNotifierProvider<CategoriesStateProvider, List<Category>>(
        (ref) => CategoriesStateProvider(ref.read(authStateProvider)));

class CategoriesStateProvider extends StateNotifier<List<Category>> {
  CategoriesStateProvider(this.authState) : super([]) {
    getCategories();
    Timer.periodic(const Duration(seconds: 5), (timer) {
      getCategories();
    });
  }

  final AuthState authState;
  final _categoriesService = CategoriesService();

  Future<void> getCategories() async {
    state = await _categoriesService.getCategories(authState.jwtToken);
  }
}
