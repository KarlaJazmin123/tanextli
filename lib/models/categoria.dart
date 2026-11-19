/// Modelo de categoría, basado en la respuesta de GET /api/categorias:
/// [ { id, nombre }, ... ]
class Categoria {
  final String id;
  final String nombre;

  Categoria({
    required this.id,
    required this.nombre,
  });

  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
      id: json['id'].toString(),
      nombre: json['nombre'] as String,
    );
  }

  /// Útil para parsear el arreglo completo que regresa el endpoint.
  static List<Categoria> listFromJson(List<dynamic> jsonList) {
    return jsonList
        .map((item) => Categoria.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
    };
  }

  @override
  String toString() => 'Categoria(id: $id, nombre: $nombre)';
}