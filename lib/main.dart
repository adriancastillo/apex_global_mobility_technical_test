import 'dart:async';

import 'package:apex_global_mobility_test/shared/routes/router.dart';
import 'package:apex_global_mobility_test/shared/di/injectable.dart';
import 'package:apex_global_mobility_test/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await configureDependencies();
      runApp(ProviderScope(child: const ApexGlobalMobilityApp()));
    },
    (error, stack) {
      // Report error to a logging service
    },
  );
}

class ApexGlobalMobilityApp extends StatelessWidget {
  const ApexGlobalMobilityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        primarySwatch: Colors.green,
        appBarTheme: AppBarTheme(backgroundColor: Colors.grey.shade100),
      ),
      routerConfig: appRouter,
      locale: const Locale('en'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
