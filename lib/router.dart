import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mopet/constants/keys.dart';
import 'package:mopet/features/authentication/views/login_screen.dart';
import 'package:mopet/features/authentication/views/number_auth_screen.dart';
import 'package:mopet/features/authentication/views/register_screen.dart';
import 'package:mopet/features/authentication/views/service_access_permission_screen.dart';
import 'package:mopet/features/authentication/views/terms_of_use_screen.dart';
import 'package:mopet/features/notifications/notifications_provider.dart';
import 'package:mopet/features/profile/views/settings_screen.dart';
import 'package:mopet/utils/shared_perferences_manager.dart';

String lastScreen = "/";

final routerProvider = Provider((ref) {
  final jwt = SharedPreferencesManager.prefs.getString(Keys.jwt) ?? "";
  bool isLogin = jwt.isNotEmpty;
  return GoRouter(
    // initialLocation: LoginScreen.routeUrl,
    initialLocation: isLogin ? SettingsScreen.routeUrl : LoginScreen.routeUrl,
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
            routes: [
              GoRoute(
                name: ServiceAccessPermissionScreen.routeName,
                path: ServiceAccessPermissionScreen.routeUrl,
                builder: (context, state) {
                  final data = state.extra as Map<String, dynamic>;
                  final provider = data['provider'] as String;
                  final accessToken = data['accessToken'] as String;
                  return ServiceAccessPermissionScreen(
                    provider: provider,
                    accessToekn: accessToken,
                  );
                },
              ),
              GoRoute(
                name: TermsOfUseScreen.routeName,
                path: TermsOfUseScreen.routeUrl,
                builder: (context, state) {
                  final data = state.extra as Map<String, dynamic>;
                  final provider = data['provider'] as String;
                  final accessToken = data['accessToken'] as String;
                  return TermsOfUseScreen(
                    provider: provider,
                    accessToken: accessToken,
                  );
                },
              ),
              GoRoute(
                name: NumberAuthScreen.routeName,
                path: NumberAuthScreen.routeUrl,
                builder: (context, state) {
                  final data = state.extra as Map<String, dynamic>;
                  final provider = data['provider'] as String;
                  final isMarketing = data['isMarketing'] as bool;
                  final accessToken = data['accessToken'] as String;
                  return NumberAuthScreen(
                    isAgreeMarketing: isMarketing,
                    provider: provider,
                    accessToken: accessToken,
                  );
                },
              ),
              GoRoute(
                name: RegisterScreen.routeName,
                path: RegisterScreen.routeUrl,
                builder: (context, state) {
                  final data = state.extra as Map<String, dynamic>;
                  final isMarketing = data['isMarketing'] as bool;
                  final phoneNumber = data['phoneNumber'] as String;
                  final provider = data['provider'] as String;
                  final accessToken = data['accessToken'] as String;
                  return RegisterScreen(
                    isAgreeMarketing: isMarketing,
                    phoneNumber: phoneNumber,
                    provider: provider,
                    accessToken: accessToken,
                  );
                },
              ),
            ],
          ),
          GoRoute(
            name: SettingsScreen.routeName,
            path: SettingsScreen.routeUrl,
            builder: (context, state) {
              return const SettingsScreen();
            },
          ),
        ],
      ),
    ],
  );
});
