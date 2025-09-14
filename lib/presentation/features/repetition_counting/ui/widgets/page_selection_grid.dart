import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../../exercises/application/exercises_provider.dart';

class PageSelectionGrid extends ConsumerWidget {
  final void Function(String pageLabel) onPageSelected;
  final String moduleName;

  const PageSelectionGrid({super.key, required this.onPageSelected, required this.moduleName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exercisesAsync = ref.watch(exercisesByModuleNameProvider(moduleName));
    return exercisesAsync.when(
      data: (exercises) {
        return GridView.builder(
          padding: const EdgeInsets.all(16.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.2,
          ),
          itemCount: exercises.length,
          itemBuilder: (context, index) {
            final label = exercises[index].nombre;
            return _PageCard(label: label, onTap: () => onPageSelected(label));
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('Error cargando ejercicios')),
    );
  }
}

class _PageCard extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _PageCard({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: AppTheme.surfaceContainer,
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Text(
            label,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppTheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }
}
