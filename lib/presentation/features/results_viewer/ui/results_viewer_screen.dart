import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:excel/excel.dart';
import 'package:intl/intl.dart';
import 'package:file_saver/file_saver.dart';
import 'dart:typed_data';

import '../../../../core/shared_widgets/confirmation_dialog.dart';
import '../../../../core/theme/app_theme.dart';
import '../application/results_viewer_notifier.dart';
import '../application/results_viewer_state.dart';
import 'widgets/study_record_card.dart';

class ResultsViewerScreen extends ConsumerWidget {
  static const String route = '/results';
  const ResultsViewerScreen({super.key});

  Future<void> _exportToExcel(BuildContext context, WidgetRef ref) async {
    final state = ref.read(resultsViewerNotifierProvider);
    if (state.records.isEmpty) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(content: Text('No hay registros para exportar.')),
        );
      return;
    }
    try {
      final excel = Excel.createExcel();
      final sheet = excel['Registros'];
      // Header
      sheet.appendRow([
        TextCellValue('ID'),
        TextCellValue('Página / Label'),
        TextCellValue('Tipo'),
        TextCellValue('Valor'),
        TextCellValue('Creado'),
      ]);
      final dateFmt = DateFormat('yyyy-MM-dd HH:mm:ss');
      for (final r in state.records) {
        sheet.appendRow([
          TextCellValue(r.id),
          TextCellValue(r.pageLabel),
          TextCellValue(r.type.name),
          TextCellValue(r.value.toString()),
          TextCellValue(dateFmt.format(r.createdAt)),
        ]);
      }
      final bytes = excel.encode();
      if (bytes == null) {
        throw Exception('No se pudieron generar los bytes del Excel');
      }
      final fileName =
          'study_records_${DateFormat('yyyyMMdd_HHmmss').format(DateTime.now())}.xlsx';
      await FileSaver.instance.saveFile(
        name: fileName,
        bytes: Uint8List.fromList(bytes),
        ext: 'xlsx',
        mimeType: MimeType.microsoftExcel,
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text('Exportado: $fileName')));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text('Error al exportar: $e')));
      }
    }
  }

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
              icon: const Icon(Icons.download_outlined),
              tooltip: 'Exportar a Excel',
              onPressed: () => _exportToExcel(context, ref),
            ),
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
