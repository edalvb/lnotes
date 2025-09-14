import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/di/injection.dart';
import '../../../../domain/models/module_model.dart';
import '../../../../domain/usecases/modules_usecases.dart';
import '../../../features/exercises/application/exercises_provider.dart';
import '../../../../domain/usecases/exercises_usecases.dart';

final modulesProvider = FutureProvider((ref) {
  final usecase = getIt<GetAllModulesUseCase>();
  return usecase();
});

class ModulesManagerScreen extends ConsumerStatefulWidget {
  const ModulesManagerScreen({super.key});

  @override
  ConsumerState<ModulesManagerScreen> createState() =>
      _ModulesManagerScreenState();
}

class _ModulesManagerScreenState extends ConsumerState<ModulesManagerScreen> {
  Future<void> _addOrEdit({ModuleModel? item}) async {
    final nameCtrl = TextEditingController(text: item?.nombre ?? '');
    final descCtrl = TextEditingController(text: item?.description ?? '');
    final result = await showDialog<Map<String, String>?>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(item == null ? 'Agregar módulo' : 'Editar módulo'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: descCtrl,
              decoration: const InputDecoration(
                labelText: 'Descripción',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, {
              'nombre': nameCtrl.text.trim(),
              'description': descCtrl.text.trim(),
            }),
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
    if (result == null) return;
    final usecase = getIt<UpsertModuleUseCase>();
    await usecase(
      ModuleModel(
        id: item?.id ?? 0,
        nombre: result['nombre'] ?? '',
        description: result['description'],
      ),
    );
    ref.invalidate(modulesProvider);
  }

  Future<void> _delete(ModuleModel item) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Eliminar módulo'),
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
    final usecase = getIt<DeleteModuleUseCase>();
    await usecase(item.id);
    ref.invalidate(modulesProvider);
  }

  Future<void> _seedExercises(ModuleModel module) async {
    final prefixCtrl = TextEditingController(text: '');
    final startCtrl = TextEditingController(text: '1');
    final endCtrl = TextEditingController(text: '10');
    var clearBefore = false;
    final params = await showDialog<SeedExercisesParams?>(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setState) => AlertDialog(
            title: Text('Sembrar ejercicios en "${module.nombre}"'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: prefixCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Prefijo (opcional, ej. Pág. )',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: startCtrl,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Inicio',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: endCtrl,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Fin',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                CheckboxListTile(
                  value: clearBefore,
                  onChanged: (v) => setState(() => clearBefore = v ?? false),
                  title: const Text('Eliminar existentes antes de sembrar'),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Cancelar'),
              ),
              FilledButton(
                onPressed: () {
                  final s = int.tryParse(startCtrl.text.trim());
                  final e = int.tryParse(endCtrl.text.trim());
                  if (s == null || e == null) {
                    Navigator.pop(ctx);
                    return;
                  }
                  Navigator.pop(
                    ctx,
                    SeedExercisesParams(
                      moduleId: module.id,
                      prefix: prefixCtrl.text,
                      start: s,
                      end: e,
                      clearBefore: clearBefore,
                    ),
                  );
                },
                child: const Text('Sembrar'),
              ),
            ],
          ),
        );
      },
    );
    if (params == null) return;

    final usecase = getIt<SeedExercisesForModuleUseCase>();
    final result = await usecase(params);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Sembrado: +${result.inserted}, omitidos: ${result.skipped}, borrados: ${result.deleted}',
        ),
      ),
    );
    ref.invalidate(exercisesByModuleProvider(module.id));
  }

  @override
  Widget build(BuildContext context) {
    final listAsync = ref.watch(modulesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Módulos'),
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
            final m = items[i];
            return ListTile(
              title: Text(m.nombre),
              subtitle: m.description == null ? null : Text(m.description!),
              leading: const Icon(Icons.view_module_outlined),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    tooltip: 'Sembrar ejercicios',
                    onPressed: () => _seedExercises(m),
                    icon: const Icon(Icons.auto_awesome_outlined),
                  ),
                  IconButton(
                    onPressed: () => context.push('/manage-pages/${m.nombre}'),
                    icon: const Icon(Icons.list_alt_outlined),
                  ),
                  IconButton(
                    onPressed: () => _addOrEdit(item: m),
                    icon: const Icon(Icons.edit_outlined),
                  ),
                  IconButton(
                    onPressed: () => _delete(m),
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
