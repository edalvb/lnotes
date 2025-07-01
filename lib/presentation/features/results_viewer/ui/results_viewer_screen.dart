import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lnotes/presentation/features/results_viewer/application/results_viewer_state.dart';

import '../../../../core/theme/app_theme.dart';
import '../application/results_viewer_notifier.dart';
import 'widgets/study_record_card.dart';

class ResultsViewerScreen extends ConsumerWidget {
  static const String route = '/results';
  const ResultsViewerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(resultsViewerNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Records'),
        backgroundColor: AppTheme.surfaceContainerLow,
        foregroundColor: AppTheme.onSurface,
        elevation: 0,
      ),
      body: _buildBody(context, state),
    );
  }

  Widget _buildBody(BuildContext context, ResultsViewerState state) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null) {
      return Center(child: Text(state.error!));
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
        return StudyRecordCard(record: record);
      },
    );
  }
}
