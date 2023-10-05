import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oktoast/oktoast.dart';
import 'package:total_pos_waiter/routes/loading_route.dart';
import 'package:total_pos_waiter/routes/login_route.dart';
import 'package:total_pos_waiter/routes/tables_route.dart';
import 'package:total_pos_waiter/routes/ticket_route/ticket_route.dart';

void main() => runApp(const ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OKToast(
        child: MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Point Of Sale',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.indigo, brightness: Brightness.dark),
          useMaterial3: true),
      routerConfig: _router,
    ));
  }
}

final _router = GoRouter(routes: [
  GoRoute(
      path: LoadingRoute.routeName,
      builder: (context, state) => const LoadingRoute()),
  GoRoute(
      path: LoginRoute.routeName, builder: (context, state) => LoginRoute()),
  GoRoute(
      path: TablesRoute.routeName,
      builder: (context, state) => const TablesRoute()),
  GoRoute(
      path: TicketRoute.routeName,
      builder: (context, state) => const TicketRoute()),
]);
