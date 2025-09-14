import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../application/repetition_counting_notifier.dart';
import 'widgets/counting_input_dialog.dart';
import 'widgets/page_selection_grid.dart';

class RepetitionCountingScreen extends ConsumerWidget {
  static const String route = '/repetition-counting';
  const RepetitionCountingScreen({super.key});

  void _showCountingDialog(
    BuildContext context,
    WidgetRef ref,
    String pageLabel,
  ) async {
    final int? count = await showDialog<int>(
      context: context,
      barrierDismissible: false,
      builder: (context) => CountingInputDialog(pageLabel: pageLabel),
    );

    if (count != null && context.mounted) {
      final success = await ref
          .read(repetitionCountingNotifierProvider.notifier)
          .saveRecord(pageLabel: pageLabel, count: count);

      if (context.mounted) {
        final message = success ? 'Record saved!' : 'Failed to save record.';
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(content: Text(message)),
          );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(repetitionCountingNotifierProvider, (previous, next) {
      if (next.error != null) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(content: Text(next.error!), backgroundColor: AppTheme.error),
          );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Repetition Counting'),
        backgroundColor: AppTheme.surfaceContainerLow,
        foregroundColor: AppTheme.onSurface,
        elevation: 0,
      ),
      body: PageSelectionGrid(
        onPageSelected: (label) => _showCountingDialog(context, ref, label),
        moduleName: 'repetition_counting',
      ),
    );
  }
}
