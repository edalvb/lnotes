import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../features/exercises/application/exercises_provider.dart';
import '../../../../domain/models/exercise_model.dart';
import '../../../../core/di/injection.dart';
import '../../../../domain/usecases/exercises_usecases.dart';

class ExercisesManagerScreen extends ConsumerStatefulWidget {
  final String moduleName;
  const ExercisesManagerScreen({super.key, required this.moduleName});

  @override
  ConsumerState<ExercisesManagerScreen> createState() =>
      _ExercisesManagerScreenState();
}

class _ExercisesManagerScreenState
    extends ConsumerState<ExercisesManagerScreen> {
  Future<void> _addOrEdit({ExerciseModel? item}) async {
    final controller = TextEditingController(text: item?.nombre ?? '');
    final label = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(item == null ? 'Agregar página' : 'Editar página'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Etiqueta de página',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, controller.text.trim()),
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
    if (label == null || label.isEmpty) return;
    final moduleId = await ref.read(
      moduleIdByNameProvider(widget.moduleName).future,
    );
    final usecase = getIt<UpsertExerciseUseCase>();
    await usecase(
      ExerciseModel(
        id: item?.id ?? 0,
        moduloId: moduleId,
        nombre: label,
        description: item?.description,
        config: item?.config,
      ),
    );
    ref.invalidate(exercisesByModuleNameProvider(widget.moduleName));
  }

  Future<void> _delete(ExerciseModel item) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Eliminar'),
        content: Text('¿Eliminar ${item.nombre}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    final usecase = getIt<DeleteExerciseUseCase>();
    await usecase(item.id);
    ref.invalidate(exercisesByModuleNameProvider(widget.moduleName));
  }

  @override
  Widget build(BuildContext context) {
    final listAsync = ref.watch(
      exercisesByModuleNameProvider(widget.moduleName),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Páginas: ${widget.moduleName}'),
        backgroundColor: AppTheme.surfaceContainerLow,
        foregroundColor: AppTheme.onSurface,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addOrEdit(),
        child: const Icon(Icons.add),
      ),
      body: listAsync.when(
        data: (items) => ListView.separated(
          padding: const EdgeInsets.all(16),
          itemBuilder: (c, i) {
            final e = items[i];
            return ListTile(
              title: Text(e.nombre),
              subtitle: e.description == null ? null : Text(e.description!),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () => _addOrEdit(item: e),
                    icon: const Icon(Icons.edit_outlined),
                  ),
                  IconButton(
                    onPressed: () => _delete(e),
                    icon: const Icon(Icons.delete_outline),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (c, i) => const Divider(height: 1),
          itemCount: items.length,
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => const Center(child: Text('Error')),
      ),
    );
  }
}
