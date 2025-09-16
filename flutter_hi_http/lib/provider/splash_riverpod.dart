import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

// class AuthStatusNotifier extends StateNotifier<AuthStatus> {
//   AuthStatusNotifier() : super(AuthStatus.unknown);
//   void updateState(AuthStatus newState) {
//     state = newState;
//   }
// }

// final authStatusProvider =
//     StateNotifierProvider<AuthStatusNotifier, AuthStatus>((ref) {
//       return AuthStatusNotifier();
//     });

final authStatusProvider = StateProvider<AuthStatus>((ref) {
  return AuthStatus.unknown;
});
