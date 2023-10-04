import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:total_pos_waiter/providers/tables_state_provider.dart';
import 'package:total_pos_waiter/routes/ticket_route/ticket_route.dart';
import 'package:total_pos_waiter/widgets/panel.dart';

class TablesRoute extends ConsumerWidget {
  static const String routeName = '/tables';
  const TablesRoute({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tables = ref.watch(tablesStateProvider);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Column(children: [
          const Panel(child: Row(children: [Text('Mesas')])),
          ExpandedPanel(
              child: tables.isEmpty
                  ? const LinearProgressIndicator()
                  : Column(children: [
                      for (int i = 0; i < 10; i++)
                        Expanded(
                            child: Row(children: [
                          for (int j = 0; j < 5; j++)
                            Expanded(
                                child: tables[(i * 5) + j] == null
                                    ? Container(
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade700
                                                .withAlpha(100),
                                            border: Border.all()))
                                    : SizedBox(
                                        height: double.maxFinite,
                                        child: ElevatedButton(
                                            onPressed: () {
                                              context
                                                  .push(TicketRoute.routeName);
                                            },
                                            child: Text(
                                                tables[(i * 5) + j]!.name)),
                                      ))
                        ]))
                    ]))
        ])));
  }
}
