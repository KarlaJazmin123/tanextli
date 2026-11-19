/// Modelo de progreso, basado en cada elemento del arreglo que regresa
/// GET /api/progreso:
/// [ { palabra_id, palabra_nahuatl, categoria, completado, veces_practicada, ultima_practica }, ... ]
class Progreso {
  final String palabraId;
  final String palabraNahuatl;
  final String categoria;
  final bool completado;
  final int vecesPracticada;
  final DateTime? ultimaPractica;

  Progreso({
    required this.palabraId,
    required this.palabraNahuatl,
    required this.categoria,
    required this.completado,
    required this.vecesPracticada,
    this.ultimaPractica,
  });

  factory Progreso.fromJson(Map<String, dynamic> json) {
    return Progreso(
      palabraId: json['palabra_id'].toString(),
      palabraNahuatl: json['palabra_nahuatl'] as String,
      categoria: json['categoria'].toString(),
      completado: json['completado'] as bool,
      vecesPracticada: json['veces_practicada'] as int,
      ultimaPractica: json['ultima_practica'] != null
          ? DateTime.tryParse(json['ultima_practica'].toString())
          : null,
    );
  }

  static List<Progreso> listFromJson(List<dynamic> jsonList) {
    return jsonList
        .map((item) => Progreso.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  @override
  String toString() =>
      'Progreso(palabraId: $palabraId, completado: $completado, vecesPracticada: $vecesPracticada)';
}