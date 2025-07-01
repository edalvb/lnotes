import 'package:flutter/foundation.dart';

@immutable
class TimerViewModel {
  final String formattedTime;
  final bool isRunning;

  const TimerViewModel({required this.formattedTime, required this.isRunning});
}
