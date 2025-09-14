import 'package:flutter/foundation.dart';

@immutable
class ModuleModel {
  final int id;
  final String nombre;
  final String? description;

  const ModuleModel({required this.id, required this.nombre, this.description});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ModuleModel &&
        other.id == id &&
        other.nombre == nombre &&
        other.description == description;
  }

  @override
  int get hashCode => id.hashCode ^ nombre.hashCode ^ description.hashCode;
}
