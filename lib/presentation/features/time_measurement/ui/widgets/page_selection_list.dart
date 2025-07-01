import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/shared_widgets/timer_control/timer_control_widget.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../application/time_measurement_notifier.dart';

class PageSelectionList extends StatelessWidget {
  final List<int> pages = List.generate(9, (index) => index + 17);

  PageSelectionList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      itemCount: pages.length,
      itemBuilder: (context, index) {
        return _PageListItem(pageNumber: pages[index]);
      },
    );
  }
}

class _PageListItem extends ConsumerStatefulWidget {
  final int pageNumber;

  const _PageListItem({required this.pageNumber});

  @override
  ConsumerState<_PageListItem> createState() => _PageListItemState();
}

class _PageListItemState extends ConsumerState<_PageListItem> {
  Key _timerKey = UniqueKey();
  Duration _initialDuration = Duration.zero;

  void _onTimerStop(Duration duration) {
    if (!mounted) return;
    setState(() {
      _initialDuration = duration;
    });
    ref.read(timeMeasurementNotifierProvider.notifier).saveRecord(
          pageNumber: widget.pageNumber,
          time: duration,
        );
  }

  void _resetTimer() {
    setState(() {
      _initialDuration = Duration.zero;
      _timerKey = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return TimerControlWidget(
      key: _timerKey,
      mode: TimerMode.stopwatch,
      initialDuration: _initialDuration,
      onManualStop: _onTimerStop,
      builder: (context, formattedTime, isRunning, toggleTimer) {
        final showResetButton = !isRunning && _initialDuration > Duration.zero;

        return Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: AppTheme.outlineVariant),
            borderRadius: BorderRadius.circular(12),
          ),
          color: AppTheme.surfaceContainerLow,
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Text('Page ${widget.pageNumber}',
                    style: textTheme.titleLarge?.copyWith(
                        color: AppTheme.onSurface, fontWeight: FontWeight.bold)),
                const Spacer(),
                Text(formattedTime,
                    style: textTheme.titleLarge?.copyWith(
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w600,
                        color: isRunning ? AppTheme.secondary : AppTheme.onSurfaceVariant)),
                const SizedBox(width: 16),
                IconButton(
                  onPressed: toggleTimer,
                  icon: Icon(isRunning
                      ? Icons.stop_circle_outlined
                      : Icons.play_circle_outline_rounded),
                  iconSize: 32,
                  color: isRunning ? AppTheme.error : AppTheme.secondary,
                ),
                if (showResetButton)
                  IconButton(
                      onPressed: _resetTimer,
                      icon: const Icon(Icons.refresh),
                      iconSize: 28,
                      color: AppTheme.onSurfaceVariant),
              ],
            ),
          ),
        );
      },
    );
  }
}
