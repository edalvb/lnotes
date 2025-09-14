import 'package:go_router/go_router.dart';

import '../../presentation/dashboard/ui/dashboard_screen.dart';
import '../../presentation/features/repetition_counting/ui/repetition_counting_screen.dart';
import '../../presentation/features/results_viewer/ui/results_viewer_screen.dart';
import '../../presentation/features/time_measurement/ui/time_measurement_screen.dart';
import '../../presentation/features/exercises/ui/exercises_manager_screen.dart';
import '../../presentation/features/modules/ui/modules_manager_screen.dart';

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
    GoRoute(
      path: '/manage-pages/:module',
      builder: (context, state) => ExercisesManagerScreen(
        moduleName: state.pathParameters['module'] ?? 'repetition_counting',
      ),
    ),
    GoRoute(
      path: '/modules',
      builder: (context, state) => const ModulesManagerScreen(),
    ),
  ],
);
