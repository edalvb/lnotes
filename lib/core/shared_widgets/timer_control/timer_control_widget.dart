import 'dart:async';

import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

enum TimerMode { countdown, stopwatch }

class TimerControlWidget extends StatefulWidget {
  final TimerMode mode;
  final Duration initialDuration;
  final bool autoStart;
  final Function(Duration) onStop;
  final Function(String) onTick;

  const TimerControlWidget({
    super.key,
    required this.mode,
    this.initialDuration = Duration.zero,
    this.autoStart = false,
    required this.onStop,
    required this.onTick,
  });

  @override
  State<TimerControlWidget> createState() => _TimerControlWidgetState();
}

class _TimerControlWidgetState extends State<TimerControlWidget> {
  Timer? _timer;
  late Duration _currentDuration;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _currentDuration = widget.initialDuration;
    widget.onTick(_formatDuration(_currentDuration));
    if (widget.autoStart) {
      _startTimer();
    }
  }

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

  void _startTimer() {
    if (_isRunning) return;

    setState(() {
      _isRunning = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        if (widget.mode == TimerMode.countdown) {
          if (_currentDuration.inSeconds > 0) {
            _currentDuration -= const Duration(seconds: 1);
          } else {
            _stopTimer(notify: true);
          }
        } else {
          _currentDuration += const Duration(seconds: 1);
        }
        widget.onTick(_formatDuration(_currentDuration));
      });
    });
  }

  void _stopTimer({bool notify = false}) {
    if (!_isRunning) return;

    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
    if (notify) {
      widget.onStop(_currentDuration);
    }
  }

  void _handlePrimaryButton() {
    if (_isRunning) {
      _stopTimer(notify: true);
    } else {
      _startTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FloatingActionButton(
          heroTag: 'timer_control_fab',
          onPressed: _handlePrimaryButton,
          backgroundColor: _isRunning ? AppTheme.tertiary : AppTheme.primary,
          child: Icon(
            _isRunning ? Icons.pause : Icons.play_arrow,
            color: _isRunning ? AppTheme.onTertiary : AppTheme.onPrimary,
            size: 36,
          ),
        ),
      ],
    );
  }
}
