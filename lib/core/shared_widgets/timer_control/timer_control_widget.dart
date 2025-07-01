import 'dart:async';

import 'package:flutter/material.dart';

enum TimerMode { countdown, stopwatch }

typedef TimerBuilder = Widget Function(
  BuildContext context,
  String formattedTime,
  bool isRunning,
  VoidCallback toggleTimer,
);

class TimerControlWidget extends StatefulWidget {
  final TimerMode mode;
  final Duration initialDuration;
  final bool autoStart;
  final Function(Duration)? onStop;
  final Function(Duration)? onManualStop;
  final TimerBuilder builder;

  const TimerControlWidget({
    super.key,
    required this.mode,
    this.initialDuration = Duration.zero,
    this.autoStart = false,
    this.onStop,
    this.onManualStop,
    required this.builder,
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
    if (widget.autoStart) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _startTimer();
      });
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

  void _tick(Timer timer) {
    if (!mounted) {
      timer.cancel();
      return;
    }

    setState(() {
      if (widget.mode == TimerMode.countdown) {
        if (_currentDuration.inSeconds > 0) {
          _currentDuration -= const Duration(seconds: 1);
        } else {
          _stopTimer(isAutoStop: true);
        }
      } else {
        _currentDuration += const Duration(seconds: 1);
      }
    });
  }

  void _startTimer() {
    if (_isRunning) return;
    setState(() => _isRunning = true);
    _timer = Timer.periodic(const Duration(seconds: 1), _tick);
  }

  void _stopTimer({bool isAutoStop = false}) {
    if (!_isRunning) return;
    _timer?.cancel();
    setState(() => _isRunning = false);

    if (isAutoStop) {
      widget.onStop?.call(_currentDuration);
    } else {
      widget.onManualStop?.call(_currentDuration);
    }
  }

  void _toggleTimer() {
    if (_isRunning) {
      _stopTimer();
    } else {
      _startTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      context,
      _formatDuration(_currentDuration),
      _isRunning,
      _toggleTimer,
    );
  }
}
