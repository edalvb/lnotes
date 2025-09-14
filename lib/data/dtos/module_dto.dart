import '../../domain/models/module_model.dart';

class ModuleDto {
  final int? id;
  final String? nombre;
  final String? description;

  ModuleDto({this.id, this.nombre, this.description});

  factory ModuleDto.fromMap(Map<String, dynamic> map) => ModuleDto(
    id: map['id'] as int?,
    nombre: map['nombre'] as String?,
    description: map['description'] as String?,
  );

  ModuleModel toModel() =>
      ModuleModel(id: id ?? 0, nombre: nombre ?? '', description: description);

  Map<String, dynamic> toMap() => {
    if (id != null) 'id': id,
    'nombre': nombre,
    'description': description,
  };
}
