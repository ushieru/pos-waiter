import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:oktoast/oktoast.dart';
import 'package:total_pos_waiter/models/settings.dart';
import 'package:total_pos_waiter/providers/settings_state_provider.dart';
import 'package:total_pos_waiter/services/http_services/utils_service.dart';

class _ConfigDialog extends ConsumerWidget {
  _ConfigDialog();

  final _serverHostController =
      TextEditingController(text: Settings.serverHost);
  final _utilsService = UtilsService();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final updateServerHost =
        ref.read(settingsStateProvider.notifier).updateServerHost;
    return SimpleDialog(
        title: const Text("Config"),
        contentPadding: const EdgeInsets.all(30),
        children: [
          TextFormField(
              controller: _serverHostController,
              decoration: const InputDecoration(labelText: 'Server Host')),
          const SizedBox(height: 15),
          FilledButton(
              onPressed: () => _utilsService
                      .testConnection(_serverHostController.text)
                      .then((isConnectionOk) {
                    if (isConnectionOk) {
                      return showToast('Conexion correcta',
                          position: ToastPosition.top,
                          backgroundColor: Colors.green.shade900);
                    }
                    return showToast('No hay Conexion',
                        position: ToastPosition.top,
                        backgroundColor: Colors.red.shade900);
                  }),
              child: const Text('Probar conexion')),
          const SizedBox(height: 25),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Expanded(
                child: OutlinedButton(
                    onPressed: () => context.pop(),
                    child: const Text('Cancelar'))),
            const SizedBox(width: 25),
            Expanded(
                child: FilledButton(
                    onPressed: () =>
                        updateServerHost(_serverHostController.text)
                            .then((_) => context.pop()),
                    child: const Text('Aceptar')))
          ])
        ]);
  }
}

Future<void> showConfigDialog(BuildContext context) => showDialog<void>(
    context: context, builder: (BuildContext context) => _ConfigDialog());
