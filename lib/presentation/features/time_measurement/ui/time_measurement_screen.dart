import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../application/time_measurement_notifier.dart';
import 'widgets/page_selection_list.dart';

class TimeMeasurementScreen extends ConsumerWidget {
  static const String route = '/time-measurement';
  const TimeMeasurementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(timeMeasurementNotifierProvider, (previous, next) {
      if (previous?.isSaving == true && !next.isSaving) {
        final message = next.error == null ? 'Record saved!' : next.error!;
        final color =
            next.error == null ? AppTheme.secondaryContainer : AppTheme.errorContainer;
        final onColor = next.error == null
            ? AppTheme.onSecondaryContainer
            : AppTheme.onErrorContainer;

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(message, style: TextStyle(color: onColor)),
              backgroundColor: color,
              behavior: SnackBarBehavior.floating,
            ),
          );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Measurement'),
        backgroundColor: AppTheme.surfaceContainerLow,
        foregroundColor: AppTheme.onSurface,
        elevation: 0,
      ),
      body: const PageSelectionList(moduleName: 'time_measurement'),
    );
  }
}
