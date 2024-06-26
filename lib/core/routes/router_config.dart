// private navigators
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ybb_master_app/core/models/full_payment_model.dart';
import 'package:ybb_master_app/core/routes/route_constants.dart';
import 'package:ybb_master_app/main.dart';
import 'package:ybb_master_app/screens/auth/auth.dart';
import 'package:ybb_master_app/screens/base/base_nav.dart';
import 'package:ybb_master_app/screens/dashboard/dashboard.dart';
import 'package:ybb_master_app/screens/master_settings/master_program_categories.dart';
import 'package:ybb_master_app/screens/master_settings/master_programs.dart';
import 'package:ybb_master_app/screens/master_settings/master_settings.dart';
import 'package:ybb_master_app/screens/payments/payment_detail.dart';
import 'package:ybb_master_app/screens/payments/payments.dart';
import 'package:ybb_master_app/screens/program_management/add_program/add_program.dart';
import 'package:ybb_master_app/screens/program_management/edit_program/edit_program.dart';
import 'package:ybb_master_app/screens/users/participants/participants_page.dart';
import 'package:ybb_master_app/screens/users/users_page.dart';
import 'package:ybb_master_app/screens/welcome/welcome.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorUserKey = GlobalKey<NavigatorState>(debugLabel: 'users');
final _shellNavigatorDashboardKey =
    GlobalKey<NavigatorState>(debugLabel: 'dashboard');
final _shellNavigatorPaymentsKey =
    GlobalKey<NavigatorState>(debugLabel: 'payments');
final _shellNavigatorSettingsKey =
    GlobalKey<NavigatorState>(debugLabel: 'settings');
final _shellNavigatorMasterSettingsKey =
    GlobalKey<NavigatorState>(debugLabel: 'master-settings');

class AppRouteConfig {
  static final GoRouter route = GoRouter(
    initialLocation: AppRouteConstants.authRoutePath,
    // * Passing a navigatorKey causes an issue on hot reload:
    // * https://github.com/flutter/flutter/issues/113757#issuecomment-1518421380
    // * However it's still necessary otherwise the navigator pops back to
    // * root on hot reload
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        name: AppRouteConstants.authRouteName,
        path: AppRouteConstants.authRoutePath,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: Auth(),
        ),
      ),
      // welcome page
      GoRoute(
        name: AppRouteConstants.welcomeRouteName,
        path: AppRouteConstants.welcomeRoutePath,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: Welcome(),
        ),
      ),

      GoRoute(
        name: AppRouteConstants.addProgramRouteName,
        path: AppRouteConstants.addProgramRoutePath,
        pageBuilder: (context, state) => const NoTransitionPage(
          child: AddProgram(),
        ),
      ),
      // Stateful navigation based on:
      // https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            navigatorKey: _shellNavigatorDashboardKey,
            routes: [
              GoRoute(
                name: AppRouteConstants.dashboardRouteName,
                path: AppRouteConstants.dashboardRoutePath,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: Dashboard(),
                ),
                routes: [],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorUserKey,
            routes: [
              GoRoute(
                name: AppRouteConstants.usersRouteName,
                path: AppRouteConstants.usersRoutePath,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: UsersPage(),
                ),
                routes: [
                  GoRoute(
                    path: 'participants',
                    builder: (context, state) => const ParticipantsPage(),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorPaymentsKey,
            routes: [
              GoRoute(
                name: AppRouteConstants.paymentsRouteName,
                path: AppRouteConstants.paymentsRoutePath,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: Payments(),
                ),
                routes: [
                  GoRoute(
                    path: 'details',
                    pageBuilder: (context, state) => NoTransitionPage(
                      child: PaymentDetail(
                        payment: state.extra as FullPaymentModel,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorSettingsKey,
            routes: [
              GoRoute(
                name: AppRouteConstants.editProgramRouteName,
                path: AppRouteConstants.editProgramRoutePath,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: EditProgram(),
                ),
                routes: [],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorMasterSettingsKey,
            routes: [
              GoRoute(
                name: AppRouteConstants.masterSettingsRouteName,
                path: AppRouteConstants.masterSettingsRoutePath,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: MasterSettings(),
                ),
                routes: [
                  GoRoute(
                    name: AppRouteConstants.masterProgramsRouteName,
                    path: AppRouteConstants.masterProgramsRoutePath,
                    pageBuilder: (context, state) =>
                        const NoTransitionPage(child: MasterPrograms()),
                  ),
                  GoRoute(
                    name: AppRouteConstants.masterProgramCategoriesRouteName,
                    path: AppRouteConstants.masterProgramCategoriesRoutePath,
                    pageBuilder: (context, state) => const NoTransitionPage(
                        child: MasterProgramCategories()),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
