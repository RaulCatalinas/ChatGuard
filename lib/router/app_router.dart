import 'package:chatguard/components/app_shell.dart';
import 'package:chatguard/screens/auth.dart' show AuthScreen;
import 'package:chatguard/screens/dashboard.dart' show DashboardScreen;
import 'package:chatguard/screens/member_detail.dart' show MemberDetailScreen;
import 'package:chatguard/screens/members.dart' show MembersScreen;
import 'package:chatguard/screens/rules.dart' show RulesScreen;
import 'package:chatguard/screens/sanctions.dart' show SanctionsScreen;
import 'package:chatguard/screens/settings.dart' show SettingsScreen;
import 'package:go_router/go_router.dart' show GoRoute, GoRouter, ShellRoute;

final appRouter = GoRouter(
  initialLocation: '/auth',
  routes: [
    GoRoute(path: '/auth', builder: (_, _) => const AuthScreen()),
    ShellRoute(
      builder: (_, _, child) => AppShell(child: child),
      routes: [
        GoRoute(path: '/dashboard', builder: (_, _) => const DashboardScreen()),
        GoRoute(path: '/rules', builder: (_, _) => const RulesScreen()),
        GoRoute(
          path: '/members',
          builder: (_, _) => const MembersScreen(),
          routes: [
            GoRoute(
              path: ':id',
              builder: (_, state) => MemberDetailScreen(
                memberId: int.tryParse(state.pathParameters['id']!),
              ),
            ),
          ],
        ),
        GoRoute(path: '/sanctions', builder: (_, _) => const SanctionsScreen()),
        GoRoute(path: '/settings', builder: (_, _) => const SettingsScreen()),
      ],
    ),
  ],
);
