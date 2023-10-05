import 'package:flutter/material.dart' hide Table;
import 'package:go_router/go_router.dart';
import 'package:total_pos_waiter/models/table.dart' as models;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:total_pos_waiter/providers/auth_state_provider.dart';
import 'package:total_pos_waiter/providers/tables_state_provider.dart';
import 'package:total_pos_waiter/routes/ticket_route/ticket_route.dart';
import 'package:total_pos_waiter/routes/ticket_route/ticket_route_state_provider.dart';

class Table extends ConsumerWidget {
  const Table({super.key, required this.table});

  final models.Table table;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tableMethods = ref.watch(tablesStateProvider.notifier);
    final ticketMethods = ref.read(ticketRouteStateProvider.notifier);
    final auth = ref.read(authStateProvider);

    if (table.ticket != null && table.ticket!.id != 0) {
      if (table.account != null &&
          auth.user != null &&
          table.account!.id != auth.user!.account.id) {
        return SizedBox(
          height: double.maxFinite,
          child: ElevatedButton(onPressed: null, child: Text(table.name)),
        );
      }
      return SizedBox(
        height: double.maxFinite,
        child: ElevatedButton(
            onPressed: () {
              ticketMethods
                  .addTicket(table.ticket!)
                  .then((_) => context.push(TicketRoute.routeName));
            },
            child: Text(table.name)),
      );
    }

    return SizedBox(
      height: double.maxFinite,
      child: FilledButton(
          onPressed: () {
            tableMethods.createTicket(table).then((table) => ticketMethods
                .addTicket(table.ticket!)
                .then((_) => context.push(TicketRoute.routeName)));
          },
          child: Text(table.name)),
    );
  }
}
