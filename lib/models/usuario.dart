class Usuario {
  final int id;
  final String nombreUsuario;
  final String correo;
  final DateTime? creadoEn;

  Usuario({
    required this.id,
    required this.nombreUsuario,
    required this.correo,
    this.creadoEn,
  });

  // Claves tal como las devuelve la API: id, nombre_usuario, correo, creado_en
  factory Usuario.fromJson(Map<String, dynamic> j) => Usuario(
        id: j['id'] as int,
        nombreUsuario: j['nombre_usuario'] as String,
        correo: j['correo'] as String,
        creadoEn: j['creado_en'] != null
            ? DateTime.tryParse(j['creado_en'] as String)
            : null,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre_usuario': nombreUsuario,
        'correo': correo,
        'creado_en': creadoEn?.toIso8601String(),
      };
}