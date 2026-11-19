/// Excepción para errores del servidor, que siempre vienen como
/// { "error": "Descripción clara del problema" } junto con un código HTTP
/// (400, 401, 404, 500, etc.) según el contrato de Oliver.
class ApiException implements Exception {
  final int statusCode;
  final String message;

  ApiException({
    required this.statusCode,
    required this.message,
  });

  factory ApiException.fromResponse(int statusCode, Map<String, dynamic> json) {
    return ApiException(
      statusCode: statusCode,
      message: (json['error'] as String?) ?? 'Error desconocido del servidor',
    );
  }

  @override
  String toString() => 'ApiException($statusCode): $message';
}