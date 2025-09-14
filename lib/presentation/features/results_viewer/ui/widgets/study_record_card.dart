import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../../../../domain/models/study_record_model.dart';
import '../../../../../domain/models/study_type_enum.dart';

class StudyRecordCard extends StatelessWidget {
  final StudyRecordModel record;

  const StudyRecordCard({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final isRepetition = record.type == StudyType.repetitionCount;
    final icon = isRepetition ? Icons.repeat : Icons.timer_outlined;
    final valueText = isRepetition
        ? '${record.value.toInt()} reps'
        : '${record.value.toStringAsFixed(2)}s';

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: AppTheme.outlineVariant),
        borderRadius: BorderRadius.circular(12),
      ),
      color: AppTheme.surfaceContainerLow,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: AppTheme.primary, size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    record.pageLabel,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    DateFormat.yMMMd().add_jm().format(record.createdAt),
                    style: textTheme.bodySmall?.copyWith(
                      color: AppTheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Text(
              valueText,
              style: textTheme.titleMedium?.copyWith(
                color: AppTheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
