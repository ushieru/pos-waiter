import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:total_pos_waiter/providers/settings_state_provider.dart';
import 'package:total_pos_waiter/routes/login_route.dart';

class LoadingRoute extends ConsumerWidget {
  static const String routeName = '/';
  const LoadingRoute({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref
        .read(settingsStateProvider.notifier)
        .init()
        .then((value) => context.go(LoginRoute.routeName));
    return const Scaffold(
        body: Center(
            child: Card(
                child: Padding(
      padding: EdgeInsets.all(15),
      child: CircularProgressIndicator(),
    ))));
  }
}
