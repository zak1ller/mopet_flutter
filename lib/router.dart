import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mopet/features/authentication/views/login_screen.dart';
import 'package:mopet/features/notifications/notifications_provider.dart';

final routerProvider = Provider((ref) {
  return GoRouter(
    initialLocation: LoginScreen.routeUrl,
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          ref.read(notificationsProvider(context));
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
    ],
  );
});
