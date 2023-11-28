import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mopet/features/views/login_screen.dart';

final routerProvider = Provider((ref) {
  return GoRouter(routes: [
    ShellRoute(
      builder: (context, state, child) {
        return child;
      },
      routes: [
        GoRoute(
          name: LoginScreen.routeName,
          path: LoginScreen.routeUrl,
          builder: (context, state) => const LoginScreen(),
        ),
      ],
    ),
  ]);
});
