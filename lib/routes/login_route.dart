import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:total_pos_waiter/providers/auth_state_provider.dart';
import 'package:total_pos_waiter/routes/tables_route.dart';
import 'package:total_pos_waiter/widgets/dialogs/config_dialog.dart';
import 'package:total_pos_waiter/widgets/panel.dart';

class LoginRoute extends ConsumerWidget {
  static const String routeName = '/login';
  LoginRoute({super.key});

  final userController = TextEditingController();
  final passwordController = TextEditingController();

  void onSubmit(BuildContext context, WidgetRef ref) {
    final login = ref.read(authStateProvider.notifier).login;
    login(userController.text, passwordController.text);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authStateProvider, (previous, next) {
      if (next.isLoged) {
        context.replace(TablesRoute.routeName);
      }
    });
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.only(right: 10, top: 5),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                IconButton(
                    onPressed: () => showConfigDialog(context),
                    icon: const Icon(Icons.settings)),
              ]),
            ),
            const Expanded(child: SizedBox()),
            Panel(
                child: Column(children: [
              Text('Total POS',
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(color: Colors.indigo)),
              const SizedBox(height: 20),
              TextFormField(
                controller: userController,
                decoration:
                    const InputDecoration(prefixIcon: Icon(Icons.person)),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: passwordController,
                onFieldSubmitted: (_) => onSubmit(context, ref),
                obscureText: true,
                decoration: const InputDecoration(prefixIcon: Icon(Icons.lock)),
              ),
              const SizedBox(height: 30),
              FilledButton(
                  onPressed: () => onSubmit(context, ref),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Text('Ingresar'),
                  ))
            ])),
            const Expanded(child: SizedBox()),
            const Text('Made with ❤️ by Ushieru'),
            const SizedBox(height: 20),
          ]),
        ));
  }
}
