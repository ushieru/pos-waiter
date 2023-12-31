import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:total_pos_waiter/routes/ticket_route/ticket_route_state_provider.dart';
import 'package:total_pos_waiter/widgets/dialogs/ticket_details_fullscreen_dialog.dart';
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
            Panel(child: Text('Ticket #${state.ticket?.id}')),
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
                                            onPressed: () =>
                                                methods.addProduct(product),
                                            child: const Text('Agregar'),
                                          ))
                                    ]))))
                        .toList())),
            Panel(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                  const Text('Total'),
                  Text('\$${state.ticket?.total}')
                ])),
            Panel(
                child: Row(children: [
              Expanded(
                  child: state.ticket?.ticketProducts.isEmpty ?? true
                      ? ElevatedButton(
                          onPressed: () {
                            methods.deleteTicket().then((isOk) {
                              if (!isOk) return;
                              context.pop();
                            });
                          },
                          child: const Text('Cancelar'))
                      : ElevatedButton(
                          onPressed: () =>
                              showTicketDetailsFullScreenDialog(context),
                          child: const Text('Detalles'))),
              const SizedBox(width: 20),
              Expanded(
                  child: FilledButton(
                      onPressed: () => context.pop(),
                      child: const Text('Aceptar'))),
            ])),
          ]),
        ));
  }
}
