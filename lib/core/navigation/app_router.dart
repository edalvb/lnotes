import 'package:go_router/go_router.dart';

import '../../presentation/dashboard/ui/dashboard_screen.dart';
import '../../presentation/features/repetition_counting/ui/repetition_counting_screen.dart';
import '../../presentation/features/results_viewer/ui/results_viewer_screen.dart';
import '../../presentation/features/time_measurement/ui/time_measurement_screen.dart';

final appRouter = GoRouter(
  initialLocation: DashboardScreen.route,
  routes: [
    GoRoute(
      path: DashboardScreen.route,
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: RepetitionCountingScreen.route,
      builder: (context, state) => const RepetitionCountingScreen(),
    ),
    GoRoute(
      path: TimeMeasurementScreen.route,
      builder: (context, state) => const TimeMeasurementScreen(),
    ),
    GoRoute(
      path: ResultsViewerScreen.route,
      builder: (context, state) => const ResultsViewerScreen(),
    ),
  ],
);
