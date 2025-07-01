import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  Timer? _timer;
  Duration _duration = Duration.zero;
  bool _isRunning = false;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  void _toggleTimer() {
    if (_isRunning) {
      _stopTimer();
    } else {
      _startTimer();
    }
  }

  void _startTimer() {
    if (_isRunning) return;
    setState(() => _isRunning = true);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() => _duration += const Duration(seconds: 1));
      }
    });
  }

  void _stopTimer() {
    if (!_isRunning) return;
    _timer?.cancel();
    setState(() => _isRunning = false);
    ref.read(timeMeasurementNotifierProvider.notifier).saveRecord(
          pageNumber: widget.pageNumber,
          time: _duration,
        );
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _duration = Duration.zero;
      _isRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

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
            Text(_formatDuration(_duration),
                style: textTheme.titleLarge?.copyWith(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w600,
                    color: _isRunning
                        ? AppTheme.secondary
                        : AppTheme.onSurfaceVariant)),
            const SizedBox(width: 16),
            IconButton(
                onPressed: _toggleTimer,
                icon: Icon(_isRunning
                    ? Icons.stop_circle_outlined
                    : Icons.play_circle_outline_rounded),
                iconSize: 32,
                color: _isRunning ? AppTheme.error : AppTheme.secondary),
            if (!_isRunning && _duration > Duration.zero)
              IconButton(
                  onPressed: _resetTimer,
                  icon: const Icon(Icons.refresh),
                  iconSize: 28,
                  color: AppTheme.onSurfaceVariant),
          ],
        ),
      ),
    );
  }
}
