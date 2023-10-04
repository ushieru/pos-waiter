import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oktoast/oktoast.dart';
import 'package:total_pos_waiter/models/account.dart';
import 'package:total_pos_waiter/models/user.dart';
import 'package:total_pos_waiter/services/http_services/auth_service.dart';

final authStateProvider = StateNotifierProvider<AuthStateProvider, AuthState>(
    (ref) => AuthStateProvider());

class AuthStateProvider extends StateNotifier<AuthState> {
  AuthStateProvider() : super(AuthState(isLoged: false, jwtToken: ''));

  final _authService = AuthService();

  Future<void> login(String username, String password) async {
    final (response, error) = await _authService.login(username, password);
    if (error != null) {
      showToast(error.description, position: ToastPosition.top);
    }
    if (response == null) return;
    if (response.user.account.accountType != AccountType.waiter) return;
    state = AuthState(
        isLoged: true, jwtToken: response.jwtToken, user: response.user);
  }

  void logout() => state = AuthState(isLoged: false, jwtToken: '');
}

class AuthState {
  AuthState({
    required this.isLoged,
    required this.jwtToken,
    this.user,
  });

  final bool isLoged;
  final String jwtToken;
  final User? user;
}
