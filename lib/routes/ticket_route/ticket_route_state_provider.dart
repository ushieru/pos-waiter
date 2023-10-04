import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:total_pos_waiter/models/category.dart';
import 'package:total_pos_waiter/providers/auth_state_provider.dart';
import 'package:total_pos_waiter/routes/ticket_route/ticket_route_state.dart';
import 'package:total_pos_waiter/services/http_services/categories_service.dart';
import 'package:total_pos_waiter/services/http_services/products_service.dart';

final ticketRouteStateProvider =
    StateNotifierProvider<TicketRouteStateProvider, TicketRouteState>(
        (ref) => TicketRouteStateProvider(ref.read(authStateProvider)));

class TicketRouteStateProvider extends StateNotifier<TicketRouteState> {
  TicketRouteStateProvider(this.authState)
      : super(TicketRouteState(categories: [], products: [], ticket: null)) {
    getCategories().then((_) {
      if (state.categories.isNotEmpty) {
        getProductsByCategory(state.categories.first);
      }
    });
  }

  final AuthState authState;
  final _categoriesService = CategoriesService();
  final _productsService = ProductsService();

  Future<void> getCategories() async {
    final categories =
        await _categoriesService.getCategories(authState.jwtToken);
    state = state.copyWith(categories: categories);
  }

  Future<void> getProductsByCategory(Category category) async {
    final products = await _productsService.getProductsByCategoryId(
        authState.jwtToken, category.id);
    state = state.copyWith(products: products);
  }
}
