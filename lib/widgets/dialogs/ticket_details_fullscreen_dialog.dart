import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:total_pos_waiter/models/ticket.dart';
import 'package:total_pos_waiter/routes/ticket_route/ticket_route_state_provider.dart';

class _TicketDetailsFullScreenDialog extends ConsumerWidget {
  const _TicketDetailsFullScreenDialog();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(ticketRouteStateProvider);
    final methods = ref.read(ticketRouteStateProvider.notifier);
    return Dialog.fullscreen(
        child: SafeArea(
            child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Ticket #${state.ticket?.id}',
            style: Theme.of(context).textTheme.headlineLarge),
        const Divider(),
        Expanded(
            child: ListView(
                children: (state.ticket?.ticketProducts ?? [])
                    .map((tp) => Card(
                        color: Colors.grey.shade900,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 8),
                          child: Column(children: [
                            Row(children: [
                              Text(tp.product.name),
                              const Expanded(child: SizedBox()),
                              Text('\$${tp.product.price} c/u'),
                            ]),
                            const SizedBox(height: 10),
                            Row(children: [
                              IconButton(
                                  onPressed: () =>
                                      methods.deleteProduct(tp.product),
                                  icon: Icon(tp.quantity > 1
                                      ? Icons.remove
                                      : Icons.delete)),
                              Text(tp.quantity.toString()),
                              IconButton(
                                  onPressed: () =>
                                      methods.addProduct(tp.product),
                                  icon: const Icon(Icons.add)),
                              const Expanded(child: SizedBox()),
                              Text('\$${tp.quantity * tp.product.price}'),
                            ]),
                          ]),
                        )))
                    .toList())),
        const Divider(),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [const Text('Total'), Text('\$${state.ticket?.total}')]),
        const Divider(),
        const SizedBox(height: 10),
        Align(
            alignment: Alignment.centerRight,
            child: FilledButton(
                onPressed: () {
                  context.pop();
                },
                child: const Text('atras'))),
      ]),
    )));
  }
}

Future<bool?> showTicketDetailsFullScreenDialog(BuildContext context) =>
    showDialog<bool>(
        context: context,
        builder: (BuildContext context) =>
            const _TicketDetailsFullScreenDialog());
