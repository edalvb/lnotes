import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_theme.dart';
import '../../features/repetition_counting/ui/repetition_counting_screen.dart';
import '../../features/results_viewer/ui/results_viewer_screen.dart';
import '../../features/time_measurement/ui/time_measurement_screen.dart';

class DashboardScreen extends StatelessWidget {
  static const String route = '/';
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Study Tracker'),
        backgroundColor: AppTheme.surfaceContainerLow,
        foregroundColor: AppTheme.onSurface,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _DashboardCard(
            icon: Icons.repeat_on_rounded,
            title: 'Repetition Counting',
            subtitle: 'Practice pages 9 to 16 with a 30s timer.',
            color: AppTheme.primaryContainer,
            onTap: () => context.push(RepetitionCountingScreen.route),
          ),
          const SizedBox(height: 16),
          _DashboardCard(
            icon: Icons.timer_outlined,
            title: 'Time Measurement',
            subtitle: 'Practice pages 17 to 25 and time yourself.',
            color: AppTheme.secondaryContainer,
            onTap: () => context.push(TimeMeasurementScreen.route),
          ),
          const SizedBox(height: 16),
          _DashboardCard(
            icon: Icons.bar_chart_rounded,
            title: 'View Results',
            subtitle: 'Check your study history and progress.',
            color: AppTheme.tertiaryContainer,
            onTap: () => context.push(ResultsViewerScreen.route),
          ),
        ],
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _DashboardCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      color: AppTheme.surfaceContainer,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: color,
                child: Icon(icon, size: 30, color: AppTheme.onPrimaryContainer),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: textTheme.titleLarge?.copyWith(
                            color: AppTheme.onSurface, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(subtitle, style: textTheme.bodyMedium?.copyWith(color: AppTheme.onSurfaceVariant)),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios_rounded, color: AppTheme.outline),
            ],
          ),
        ),
      ),
    );
  }
}
