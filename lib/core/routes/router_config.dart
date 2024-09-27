// private navigators
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ybb_master_app/core/models/ambassador_model.dart';
import 'package:ybb_master_app/core/models/full_payment_model.dart';
import 'package:ybb_master_app/core/models/payment_method_model.dart';
import 'package:ybb_master_app/core/models/program_announcement/program_announcement_model.dart';
import 'package:ybb_master_app/core/models/program_certificate_model.dart';
import 'package:ybb_master_app/core/models/program_document_model.dart';
import 'package:ybb_master_app/core/models/program_payment_model.dart';
import 'package:ybb_master_app/core/models/program_timeline_model.dart';
import 'package:ybb_master_app/core/models/users/participant_model.dart';
import 'package:ybb_master_app/core/routes/route_constants.dart';
import 'package:ybb_master_app/screens/announcements/add_edit_announcement.dart';
import 'package:ybb_master_app/screens/announcements/announcement_detail.dart';
import 'package:ybb_master_app/screens/announcements/announcement_list.dart';
import 'package:ybb_master_app/screens/auth/auth.dart';
import 'package:ybb_master_app/screens/base/base_nav.dart';
import 'package:ybb_master_app/screens/certificates/program_certificates.dart';
import 'package:ybb_master_app/screens/dashboard/dashboard.dart';
import 'package:ybb_master_app/screens/master_settings/master_program_categories.dart';
import 'package:ybb_master_app/screens/master_settings/master_programs.dart';
import 'package:ybb_master_app/screens/master_settings/master_settings.dart';
import 'package:ybb_master_app/screens/payments/payment_detail.dart';
import 'package:ybb_master_app/screens/payments/payment_statistics.dart';
import 'package:ybb_master_app/screens/payments/payments.dart';
import 'package:ybb_master_app/screens/program_management/add_program/add_program.dart';
import 'package:ybb_master_app/screens/program_management/edit_program/edit_program.dart';
import 'package:ybb_master_app/screens/settings/program_certificates/add_edit_program_certificate.dart';
import 'package:ybb_master_app/screens/settings/program_certificates/program_certificate_detail.dart';
import 'package:ybb_master_app/screens/settings/program_certificates/program_certificate_setting.dart';
import 'package:ybb_master_app/screens/settings/landing_page/landing_page_setting.dart';
import 'package:ybb_master_app/screens/settings/payment_methods/add_edit_payment_method.dart';
import 'package:ybb_master_app/screens/settings/payment_methods/payment_method_setting.dart';
import 'package:ybb_master_app/screens/settings/payment_methods/payment_method_setting_detail.dart';
import 'package:ybb_master_app/screens/settings/payments/add_edit_payment.dart';
import 'package:ybb_master_app/screens/settings/payments/payment_setting.dart';
import 'package:ybb_master_app/screens/settings/payments/payment_setting_detail.dart';
import 'package:ybb_master_app/screens/settings/program_documents/add_edit_program_document.dart';
import 'package:ybb_master_app/screens/settings/program_documents/program_document_detail.dart';
import 'package:ybb_master_app/screens/settings/program_documents/program_document_setting.dart';
import 'package:ybb_master_app/screens/settings/settings.dart';
import 'package:ybb_master_app/screens/settings/timeline/add_edit_program_timeline.dart';
import 'package:ybb_master_app/screens/settings/timeline/program_timeline_detail.dart';
import 'package:ybb_master_app/screens/settings/timeline/program_timeline_setting.dart';
import 'package:ybb_master_app/screens/users/ambassadors/add_ambassador.dart';
import 'package:ybb_master_app/screens/users/ambassadors/ambassador_detail.dart';
import 'package:ybb_master_app/screens/users/ambassadors/ambassador_list.dart';
import 'package:ybb_master_app/screens/users/participants/participant_details.dart';
import 'package:ybb_master_app/screens/users/participants/participant_list.dart';
import 'package:ybb_master_app/screens/users/users_page.dart';
import 'package:ybb_master_app/screens/users/widgets/participant_preview_widget.dart';
import 'package:ybb_master_app/screens/welcome/welcome.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorUserKey = GlobalKey<NavigatorState>(debugLabel: 'users');
final _shellNavigatorDashboardKey =
    GlobalKey<NavigatorState>(debugLabel: 'dashboard');
final _shellNavigatorPaymentsKey =
    GlobalKey<NavigatorState>(debugLabel: 'payments');
final _shellNavigatorAnnouncementsKey =
    GlobalKey<NavigatorState>(debugLabel: 'announcements');
final _shellNavigatorCertificatesKey =
    GlobalKey<NavigatorState>(debugLabel: 'certificates');
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
                    name: AppRouteConstants.participantListRouteName,
                    path: AppRouteConstants.participantListRoutePath,
                    pageBuilder: (context, state) =>
                        const NoTransitionPage(child: ParticipantList()),
                  ),
                  GoRoute(
                    name: AppRouteConstants.participantDetailRouteName,
                    path: AppRouteConstants.participantDetailRoutePath,
                    pageBuilder: (context, state) => NoTransitionPage(
                      child: ParticipantDetails(
                        participant: state.extra as ParticipantModel,
                      ),
                    ),
                  ),
                  GoRoute(
                    name: AppRouteConstants.ambassadorListRouteName,
                    path: AppRouteConstants.ambassadorListRoutePath,
                    pageBuilder: (context, state) =>
                        const NoTransitionPage(child: AmbassadorList()),
                  ),
                  GoRoute(
                    name: AppRouteConstants.ambassadorAddRouteName,
                    path: AppRouteConstants.ambassadorAddRoutePath,
                    pageBuilder: (context, state) =>
                        const NoTransitionPage(child: AddAmbassador()),
                  ),
                  GoRoute(
                    name: AppRouteConstants.ambassadorDetailRouteName,
                    path: AppRouteConstants.ambassadorDetailRoutePath,
                    pageBuilder: (context, state) => NoTransitionPage(
                        child: AmbassadorDetail(
                      ambassador: state.extra as AmbassadorModel,
                    )),
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
                  GoRoute(
                    path: AppRouteConstants.paymentStatisticsRoutePath,
                    name: AppRouteConstants.paymentStatisticsRouteName,
                    pageBuilder: (context, state) => const NoTransitionPage(
                      child: PaymentStatistics(),
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorAnnouncementsKey,
            routes: [
              GoRoute(
                name: AppRouteConstants.announcementListRouteName,
                path: AppRouteConstants.announcementListRoutePath,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: AnnouncementList(),
                ),
                routes: [
                  GoRoute(
                    name: AppRouteConstants.addEditAnnouncementRouteName,
                    path: AppRouteConstants.addEditAnnouncementRouteName,
                    pageBuilder: (context, state) => NoTransitionPage(
                        child: AddEditAnnouncement(
                      announcement: state.extra as ProgramAnnouncementModel?,
                    )),
                  ),
                  GoRoute(
                    name: AppRouteConstants.announcementDetailRouteName,
                    path: AppRouteConstants.announcementDetailRoutePath,
                    pageBuilder: (context, state) => NoTransitionPage(
                        child: AnnouncementDetails(
                      announcement: state.extra as ProgramAnnouncementModel,
                    )),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorCertificatesKey,
            routes: [
              GoRoute(
                name: AppRouteConstants.certificatesRouteName,
                path: AppRouteConstants.certificatesRoutePath,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: ProgramCertificates(),
                ),
                routes: [
                  // GoRoute(
                  //   path: 'details',
                  //   pageBuilder: (context, state) => NoTransitionPage(
                  //     child: PaymentDetail(
                  //       payment: state.extra as FullPaymentModel,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellNavigatorSettingsKey,
            routes: [
              GoRoute(
                name: AppRouteConstants.settingsRouteName,
                path: AppRouteConstants.settingsPathName,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: Settings(),
                ),
                routes: [
                  GoRoute(
                      name: AppRouteConstants.paymentSettingRouteName,
                      path: AppRouteConstants.paymentSettingRoutePath,
                      pageBuilder: (context, state) =>
                          const NoTransitionPage(child: PaymentSetting()),
                      routes: [
                        GoRoute(
                          name: AppRouteConstants.addEditPaymentRouteName,
                          path: AppRouteConstants.addEditPaymentRoutePath,
                          pageBuilder: (context, state) => NoTransitionPage(
                              child: state.extra == null
                                  ? const AddEditPayment()
                                  : AddEditPayment(
                                      payment:
                                          state.extra as ProgramPaymentModel,
                                    )),
                        ),
                        GoRoute(
                          name: AppRouteConstants.paymentSettingDetailRouteName,
                          path: AppRouteConstants.paymentSettingDetailRoutePath,
                          pageBuilder: (context, state) => NoTransitionPage(
                              child: PaymentSettingDetail(
                            payment: state.extra as ProgramPaymentModel,
                          )),
                        ),
                      ]),
                  GoRoute(
                    name: AppRouteConstants.landingPageRouteName,
                    path: AppRouteConstants.landingPageRoutePath,
                    pageBuilder: (context, state) =>
                        const NoTransitionPage(child: LandingPageSetting()),
                  ),
                  GoRoute(
                      name: AppRouteConstants.paymentMethodRouteName,
                      path: AppRouteConstants.paymentMethodRoutePath,
                      pageBuilder: (context, state) =>
                          const NoTransitionPage(child: PaymentMethodSetting()),
                      routes: [
                        GoRoute(
                          name: AppRouteConstants.addEditPaymentMethodRouteName,
                          path: AppRouteConstants.addEditPaymentMethodRoutePath,
                          pageBuilder: (context, state) => NoTransitionPage(
                              child: state.extra == null
                                  ? const AddEditPaymentMethod()
                                  : AddEditPaymentMethod(
                                      paymentMethod:
                                          state.extra as PaymentMethodModel,
                                    )),
                        ),
                        GoRoute(
                          name: AppRouteConstants
                              .paymentMethodSettingDetailRouteName,
                          path: AppRouteConstants
                              .paymentMethodSettingDetailRoutePath,
                          pageBuilder: (context, state) => NoTransitionPage(
                              child: PaymentMethodSettingDetail(
                            paymentMethod: state.extra as PaymentMethodModel,
                          )),
                        ),
                      ]),
                  GoRoute(
                    name: AppRouteConstants.programDocumentSettingRouteName,
                    path: AppRouteConstants.programDocumentSettingRoutePath,
                    pageBuilder: (context, state) =>
                        const NoTransitionPage(child: ProgamDocumentSetting()),
                    routes: [
                      GoRoute(
                        name: AppRouteConstants.addEditProgramDocumentRouteName,
                        path: AppRouteConstants.addEditProgramDocumentRoutePath,
                        pageBuilder: (context, state) => NoTransitionPage(
                            child: state.extra == null
                                ? const AddEditProgramDocument()
                                : AddEditProgramDocument(
                                    programDocument:
                                        state.extra as ProgramDocumentModel,
                                  )),
                      ),
                      GoRoute(
                        name: AppRouteConstants.programDocumentDetailRouteName,
                        path: AppRouteConstants.programDocumentDetailRoutePath,
                        pageBuilder: (context, state) => NoTransitionPage(
                            child: ProgramDocumentDetail(
                          programDocument: state.extra as ProgramDocumentModel,
                        )),
                      ),
                    ],
                  ),
                  GoRoute(
                      name: AppRouteConstants.programCertificateRouteName,
                      path: AppRouteConstants.programCertificateRoutePath,
                      pageBuilder: (context, state) => const NoTransitionPage(
                          child: ProgramCertificateSetting()),
                      routes: [
                        GoRoute(
                          name: AppRouteConstants
                              .addEditProgramCertificatelineRouteName,
                          path: AppRouteConstants
                              .addEditProgramCertificateRoutePath,
                          pageBuilder: (context, state) => NoTransitionPage(
                              child: state.extra == null
                                  ? const AddEditProgramCertificate()
                                  : AddEditProgramCertificate(
                                      certificate: state.extra
                                          as ProgramCertificateModel,
                                    )),
                        ),
                        GoRoute(
                          name: AppRouteConstants
                              .programCertificateDetailRouteName,
                          path: AppRouteConstants
                              .programCertificateDetailRoutePath,
                          pageBuilder: (context, state) => NoTransitionPage(
                              child: ProgramCertificateDetail(
                            certificate: state.extra as ProgramCertificateModel,
                          )),
                        ),
                      ]),
                  GoRoute(
                      name: AppRouteConstants.programTimelineSettingRouteName,
                      path: AppRouteConstants.programTimelineSettingRoutePath,
                      pageBuilder: (context, state) => const NoTransitionPage(
                          child: ProgramTimelineSetting()),
                      routes: [
                        GoRoute(
                          name:
                              AppRouteConstants.addEditProgramTimelineRouteName,
                          path:
                              AppRouteConstants.addEditProgramTimelineRoutePath,
                          pageBuilder: (context, state) => NoTransitionPage(
                              child: state.extra == null
                                  ? const AddEditProgramTimeline()
                                  : AddEditProgramTimeline(
                                      programTimeline:
                                          state.extra as ProgramTimelineModel,
                                    )),
                        ),
                        GoRoute(
                          name:
                              AppRouteConstants.programTimelineDetailRouteName,
                          path:
                              AppRouteConstants.programTimelineDetailRoutePath,
                          pageBuilder: (context, state) => NoTransitionPage(
                              child: ProgramTimelineDetail(
                            programTimeline:
                                state.extra as ProgramTimelineModel,
                          )),
                        ),
                      ]),
                ],
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
