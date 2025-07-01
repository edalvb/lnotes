import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../core/shared_widgets/timer_control/timer_control_widget.dart';
import '../../../../../core/theme/app_theme.dart';

class CountingInputDialog extends StatefulWidget {
  final int pageNumber;

  const CountingInputDialog({super.key, required this.pageNumber});

  @override
  State<CountingInputDialog> createState() => _CountingInputDialogState();
}

class _CountingInputDialogState extends State<CountingInputDialog> {
  final TextEditingController _countController = TextEditingController();
  bool _isTimerFinished = false;
  String _formattedTime = '00:30';

  @override
  void dispose() {
    _countController.dispose();
    super.dispose();
  }

  void _onTimerTick(String formattedTime) {
    if (mounted) {
      setState(() {
        _formattedTime = formattedTime;
      });
    }
  }

  void _onTimerStop(Duration finalDuration) {
    if (mounted) {
      setState(() {
        _isTimerFinished = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppTheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      title: Text('Practice Page ${widget.pageNumber}',
          textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(_formattedTime,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(color: AppTheme.primary, fontWeight: FontWeight.w600)),
          const SizedBox(height: 20),
          TimerControlWidget(
            mode: TimerMode.countdown,
            initialDuration: const Duration(seconds: 30),
            autoStart: true,
            onTick: _onTimerTick,
            onStop: _onTimerStop,
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _countController,
            enabled: _isTimerFinished,
            autofocus: true,
            decoration: InputDecoration(
              labelText: 'Repetitions',
              hintText: 'Enter count...',
              border: const OutlineInputBorder(),
              filled: true,
              fillColor: _isTimerFinished ? AppTheme.surface : AppTheme.surfaceContainer,
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: const EdgeInsets.only(bottom: 20, left: 24, right: 24),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        const SizedBox(width: 12),
        FilledButton(
          onPressed: _isTimerFinished && _countController.text.isNotEmpty
              ? () {
                  final count = int.tryParse(_countController.text);
                  if (count != null) {
                    Navigator.of(context).pop(count);
                  }
                }
              : null,
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24),
          ),
          child: const Text('Save'),
        ),
      ],
    );
  }
}
