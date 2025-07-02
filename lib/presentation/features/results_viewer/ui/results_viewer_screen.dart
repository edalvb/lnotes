import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/shared_widgets/confirmation_dialog.dart';
import '../../../../core/theme/app_theme.dart';
import '../application/results_viewer_notifier.dart';
import '../application/results_viewer_state.dart';
import 'widgets/study_record_card.dart';

class ResultsViewerScreen extends ConsumerWidget {
  static const String route = '/results';
  const ResultsViewerScreen({super.key});

  Future<void> _onDeleteAll(BuildContext context, WidgetRef ref) async {
    final confirmed = await showConfirmationDialog(
      context: context,
      title: 'Delete All Records',
      content: 'Are you sure you want to permanently delete all study records?',
    );
    if (confirmed && context.mounted) {
      ref.read(resultsViewerNotifierProvider.notifier).deleteAllRecords();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(resultsViewerNotifierProvider);

    ref.listen(resultsViewerNotifierProvider, (previous, next) {
      if (next.error != null) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(next.error!)));
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Records'),
        backgroundColor: AppTheme.surfaceContainerLow,
        foregroundColor: AppTheme.onSurface,
        elevation: 0,
        actions: [
          if (state.records.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_forever_outlined),
              tooltip: 'Delete All Records',
              onPressed: () => _onDeleteAll(context, ref),
            ),
        ],
      ),
      body: _buildBody(context, ref, state),
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref, ResultsViewerState state) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.records.isEmpty) {
      return const Center(
        child: Text(
          'No study records yet.',
          style: TextStyle(color: AppTheme.onSurfaceVariant),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      itemCount: state.records.length,
      itemBuilder: (context, index) {
        final record = state.records[index];
        return Dismissible(
          key: ValueKey(record.id),
          direction: DismissDirection.endToStart,
          background: Container(
            color: AppTheme.errorContainer,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: const Icon(Icons.delete_outline, color: AppTheme.onErrorContainer),
          ),
          confirmDismiss: (direction) => showConfirmationDialog(
            context: context,
            title: 'Delete Record',
            content: 'Are you sure you want to delete this record?',
          ),
          onDismissed: (direction) {
            ref.read(resultsViewerNotifierProvider.notifier).deleteRecord(record.id);
          },
          child: StudyRecordCard(record: record),
        );
      },
    );
  }
}
