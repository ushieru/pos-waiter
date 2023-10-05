import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:total_pos_waiter/models/settings.dart';

final settingsStateProvider =
    StateNotifierProvider<SettingsStateProvider, Settings>(
        (ref) => SettingsStateProvider());

class SettingsStateProvider extends StateNotifier<Settings> {
  SettingsStateProvider() : super(Settings()) {
    init();
  }

  Future<void> init() async {
    final preferences = await SharedPreferences.getInstance();
    final serverHost = preferences.getString('serverHost');
    if (serverHost != null) {
      Settings.serverHost = serverHost;
    }
    state = Settings();
  }

  Future<void> updateServerHost(String serverHost) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString('serverHost', serverHost);
    Settings.serverHost = serverHost;
    state = Settings();
  }
}
