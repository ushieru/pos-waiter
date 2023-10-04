import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:total_pos_waiter/models/table.dart';
import 'package:total_pos_waiter/providers/auth_state_provider.dart';
import 'package:total_pos_waiter/services/http_services/table_service.dart';
import 'package:total_pos_waiter/utils/rotate_2d_matrix.dart';

final tablesStateProvider =
    StateNotifierProvider<TablesStateProvider, List<Table?>>(
        (ref) => TablesStateProvider(ref.read(authStateProvider)));

class TablesStateProvider extends StateNotifier<List<Table?>> {
  TablesStateProvider(this.authState) : super([]) {
    getTables();
    Timer.periodic(const Duration(seconds: 5), (timer) {
      // getTables();
    });
  }

  final AuthState authState;
  final _tablesService = TablesService();

  Future<void> getTables() async {
    final List<List<Table?>> list2d =
        List.generate(5, (_) => List.generate(10, (_) => null));
    final tables = await _tablesService.getTables(authState.jwtToken);
    for (final table in tables) {
      list2d[table.posX - 1][table.posY - 1] = table;
    }
    final rotateList = rotate2dMatrix(list2d);
    final linearList = List<Table?>.filled(50, null);
    for (var i = 0; i < rotateList.length; i++) {
      for (var j = 0; j < rotateList[i].length; j++) {
        linearList[(i * 5) + (j)] = rotateList[i][j];
      }
    }
    state = linearList;
  }
}
