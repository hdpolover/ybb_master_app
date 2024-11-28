import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ybb_master_app/core/routes/router_config.dart';
import 'package:ybb_master_app/providers/admin_provider.dart';
import 'package:ybb_master_app/providers/ambassador_provider.dart';
import 'package:ybb_master_app/providers/dashboard_provider.dart';
import 'package:ybb_master_app/providers/faq_provider.dart';
import 'package:ybb_master_app/providers/paper_provider.dart';
import 'package:ybb_master_app/providers/participant_provider.dart';
import 'package:ybb_master_app/providers/payment_provider.dart';
import 'package:ybb_master_app/providers/program_announcement_provider.dart';
import 'package:ybb_master_app/providers/program_provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AdminProvider>(
          create: (context) => AdminProvider(),
        ),
        ChangeNotifierProvider<ProgramProvider>(
          create: (context) => ProgramProvider(),
        ),
        ChangeNotifierProvider<PaymentProvider>(
          create: (context) => PaymentProvider(),
        ),
        ChangeNotifierProvider<DashboardProvider>(
          create: (context) => DashboardProvider(),
        ),
        ChangeNotifierProvider<ParticipantProvider>(
          create: (context) => ParticipantProvider(),
        ),
        ChangeNotifierProvider<AmbassadorProvider>(
          create: (context) => AmbassadorProvider(),
        ),
        ChangeNotifierProvider<ProgramAnnouncementProvider>(
          create: (context) => ProgramAnnouncementProvider(),
        ),
        ChangeNotifierProvider<FaqProvider>(
          create: (context) => FaqProvider(),
        ),
        ChangeNotifierProvider<PaperProvider>(
          create: (context) => PaperProvider(),
        ),
      ],
      child: ResponsiveSizer(builder: (context, orientation, screenType) {
        return MaterialApp.router(
          title: 'YBB Admin App',
          routerConfig: AppRouteConfig.route,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.indigo,
            useMaterial3: true,
            appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.dark,
              ),
            ),
          ),
        );
      }),
    );
  }
}
