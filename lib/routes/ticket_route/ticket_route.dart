import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:total_pos_waiter/providers/categories_state_provider.dart';
import 'package:total_pos_waiter/routes/tables_route.dart';
import 'package:total_pos_waiter/routes/ticket_route/ticket_route_state_provider.dart';
import 'package:total_pos_waiter/widgets/panel.dart';

class TicketRoute extends ConsumerWidget {
  static const String routeName = '/ticket';
  const TicketRoute({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final methods = ref.read(ticketRouteStateProvider.notifier);
    final state = ref.watch(ticketRouteStateProvider);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(children: [
            Panel(
                child: SizedBox(
              width: double.maxFinite,
              height: 30,
              child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: state.categories
                      .map((category) => ElevatedButton(
                          onPressed: () =>
                              methods.getProductsByCategory(category),
                          child: Text(category.name)))
                      .toList()),
            )),
            ExpandedPanel(
                child: GridView.count(
                    crossAxisCount: 2,
                    children: state.products
                        .map((product) => Card(
                            color: Colors.grey.shade900,
                            child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(product.name),
                                      Text('\$${product.price}'),
                                      const Expanded(child: SizedBox()),
                                      Align(
                                          alignment: Alignment.centerRight,
                                          child: FilledButton(
                                            onPressed: () {},
                                            child: const Text('Agregar'),
                                          ))
                                    ]))))
                        .toList())),
            Panel(
                child: Row(children: [
              Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: const Text('Cancelar'))),
              const SizedBox(width: 20),
              Expanded(
                  child: FilledButton(
                      onPressed: () {}, child: const Text('Aceptar'))),
            ])),
          ]),
        ));
  }
}
