import 'package:flutter/material.dart';

import '../core/navigation/app_router.dart';
import '../core/theme/app_theme.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Study Tracker',
      theme: AppTheme.lightTheme,
      routerConfig: appRouter,
    );
  }
}
