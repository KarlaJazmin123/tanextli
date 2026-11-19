/// Modelo de la respuesta de POST /api/ar/detectar:
/// { objeto_detectado, palabra_nahuatl, traduccion, audio_url, categoria }
class ObjetoDetectado {
  final String objetoDetectado;
  final String palabraNahuatl;
  final String traduccion;
  final String audioUrl;
  final String categoria;

  ObjetoDetectado({
    required this.objetoDetectado,
    required this.palabraNahuatl,
    required this.traduccion,
    required this.audioUrl,
    required this.categoria,
  });

  factory ObjetoDetectado.fromJson(Map<String, dynamic> json) {
    return ObjetoDetectado(
      objetoDetectado: json['objeto_detectado'] as String,
      palabraNahuatl: json['palabra_nahuatl'] as String,
      traduccion: json['traduccion'] as String,
      audioUrl: json['audio_url'] as String,
      categoria: json['categoria'].toString(),
    );
  }

  @override
  String toString() =>
      'ObjetoDetectado(objetoDetectado: $objetoDetectado, palabraNahuatl: $palabraNahuatl)';
}