import 'package:total_pos_waiter/models/category.dart';
import 'package:total_pos_waiter/models/product.dart';
import 'package:total_pos_waiter/models/ticket.dart';

class TicketRouteState {
  TicketRouteState({
    required this.categories,
    required this.products,
    required this.ticket,
  });

  final List<Category> categories;
  final List<Product> products;
  final Ticket? ticket;

  TicketRouteState copyWith({
    List<Category>? categories,
    List<Product>? products,
    Ticket? ticket,
  }) {
    return TicketRouteState(
      categories: categories ?? this.categories,
      products: products ?? this.products,
      ticket: ticket ?? this.ticket,
    );
  }
}
