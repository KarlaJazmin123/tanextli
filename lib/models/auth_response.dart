import 'usuario.dart';

/// Modelo de la respuesta exitosa de /api/login y /api/registro:
/// { token, usuario: { id, nombre_usuario, correo } }
class AuthResponse {
  final String token;
  final Usuario usuario;

  AuthResponse({
    required this.token,
    required this.usuario,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['token'] as String,
      usuario: Usuario.fromJson(json['usuario'] as Map<String, dynamic>),
    );
  }
}