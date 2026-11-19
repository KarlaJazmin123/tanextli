/// Modelo de palabra, basado en la respuesta de
/// GET /api/categorias/:id/palabras:
/// [ { palabra_nahuatl, traduccion, audio_url, categoria }, ... ]
class Palabra {
  final String palabraNahuatl;
  final String traduccion;

  /// Nombre/ruta del archivo de audio tal como lo regresa el servidor.
  /// Se usa junto con GET /api/audios/:archivo para reproducirlo.
  final String audioUrl;

  final String categoria;

  Palabra({
    required this.palabraNahuatl,
    required this.traduccion,
    required this.audioUrl,
    required this.categoria,
  });

  factory Palabra.fromJson(Map<String, dynamic> json) {
    return Palabra(
      palabraNahuatl: json['palabra_nahuatl'] as String,
      traduccion: json['traduccion'] as String,
      audioUrl: json['audio_url'] as String,
      categoria: json['categoria'].toString(),
    );
  }

  static List<Palabra> listFromJson(List<dynamic> jsonList) {
    return jsonList
        .map((item) => Palabra.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  /// Arma la URL completa para pedir el audio al servidor, dado el host
  /// base configurado (ej. "http://tanextli-server.local:PUERTO").
  String audioEndpoint(String baseUrl) {
    final base = baseUrl.endsWith('/')
        ? baseUrl.substring(0, baseUrl.length - 1)
        : baseUrl;
    return '$base/api/audios/$audioUrl';
  }

  Map<String, dynamic> toJson() {
    return {
      'palabra_nahuatl': palabraNahuatl,
      'traduccion': traduccion,
      'audio_url': audioUrl,
      'categoria': categoria,
    };
  }

  @override
  String toString() =>
      'Palabra(palabraNahuatl: $palabraNahuatl, traduccion: $traduccion, categoria: $categoria)';
}