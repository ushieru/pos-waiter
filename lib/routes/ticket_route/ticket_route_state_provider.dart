import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:total_pos_waiter/models/category.dart';
import 'package:total_pos_waiter/models/product.dart';
import 'package:total_pos_waiter/models/ticket.dart';
import 'package:total_pos_waiter/providers/auth_state_provider.dart';
import 'package:total_pos_waiter/providers/tables_state_provider.dart';
import 'package:total_pos_waiter/routes/ticket_route/ticket_route_state.dart';
import 'package:total_pos_waiter/services/http_services/categories_service.dart';
import 'package:total_pos_waiter/services/http_services/products_service.dart';
import 'package:total_pos_waiter/services/http_services/ticket_service.dart';

final ticketRouteStateProvider =
    StateNotifierProvider<TicketRouteStateProvider, TicketRouteState>((ref) =>
        TicketRouteStateProvider(ref.read(authStateProvider),
            ref.read(tablesStateProvider.notifier)));

class TicketRouteStateProvider extends StateNotifier<TicketRouteState> {
  TicketRouteStateProvider(this.authState, this._tableMethods)
      : super(TicketRouteState(categories: [], products: [], ticket: null)) {
    getCategories().then((_) {
      if (state.categories.isNotEmpty) {
        getProductsByCategory(state.categories.first);
      }
    });
  }

  final AuthState authState;
  final TablesStateProvider _tableMethods;
  final _categoriesService = CategoriesService();
  final _productsService = ProductsService();
  final _ticketService = TicketService();

  Future<void> addTicket(Ticket ticket) async {
    final ticketWithProducts =
        await _ticketService.getTicketByID(authState.jwtToken, ticket.id);
    state = state.copyWith(ticket: ticketWithProducts);
  }

  Future<void> addProduct(Product product) async {
    if (state.ticket == null) return;
    final ticket = await _ticketService.addProductToTicket(
        authState.jwtToken, state.ticket!.id, product.id);
    state = state.copyWith(ticket: ticket);
  }

  Future<void> deleteProduct(Product product) async {
    if (state.ticket == null) return;
    final ticket = await _ticketService.deleteProductToTicket(
        authState.jwtToken, state.ticket!.id, product.id);
    state = state.copyWith(ticket: ticket);
  }

  Future<bool> deleteTicket() async {
    if (state.ticket == null) return false;
    await _ticketService.deleteTicket(authState.jwtToken, state.ticket!.id);
    await _tableMethods.getTables();
    return true;
  }

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
