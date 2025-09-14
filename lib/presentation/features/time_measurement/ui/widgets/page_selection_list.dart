import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/di/injection.dart';
import '../../../../../core/services/audio_player_service.dart';
import '../../../../../core/shared_widgets/timer_control/timer_control_widget.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../exercises/application/exercises_provider.dart';
import '../../application/time_measurement_notifier.dart';

class PageSelectionList extends ConsumerWidget {
  final String moduleName;
  const PageSelectionList({super.key, required this.moduleName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
  final exercisesAsync = ref.watch(exercisesByModuleNameProvider(moduleName));
    return exercisesAsync.when(
      data: (exercises) => ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          return _PageListItem(pageLabel: exercises[index].nombre);
        },
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => const Center(child: Text('Error cargando ejercicios')),
    );
  }
}

class _PageListItem extends ConsumerStatefulWidget {
  final String pageLabel;

  const _PageListItem({required this.pageLabel});

  @override
  ConsumerState<_PageListItem> createState() => _PageListItemState();
}

class _PageListItemState extends ConsumerState<_PageListItem> {
  Key _timerKey = UniqueKey();
  Duration _initialDuration = Duration.zero;
  final _audioService = getIt<AudioPlayerService>();

  void _onTimerStop(Duration duration) {
    if (!mounted) return;

    if (_initialDuration == Duration.zero) {
      _audioService.playAlarmSound();
    }

    setState(() {
      _initialDuration = duration;
    });
    ref.read(timeMeasurementNotifierProvider.notifier).saveRecord(
          pageLabel: widget.pageLabel,
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
      onStop: (duration) => _onTimerStop(duration),
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
                Text(
                  widget.pageLabel,
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
