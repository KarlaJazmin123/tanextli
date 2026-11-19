import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/usuario.dart';

class AuthService {
  // Servidor de Oliver, publicado con Tailscale Funnel (HTTPS público).
  // No necesita Tailscale en el celular ni el puerto 3001 en la URL.
  static const String baseUrl = 'https://olo.tail0de9ec.ts.net/api';

  static const _storage = FlutterSecureStorage();
  static const _timeout = Duration(seconds: 10);

  // Decodifica la respuesta sin romperse si el servidor no devuelve JSON.
  static Map<String, dynamic> _decode(http.Response response) {
    try {
      final data = jsonDecode(response.body);
      return data is Map<String, dynamic> ? data : {};
    } catch (_) {
      return {};
    }
  }

  // El servidor puede mandar el texto del error en 'error' o en 'mensaje'.
  static String _mensajeError(Map<String, dynamic> data, String porDefecto) =>
      (data['error'] ?? data['mensaje'] ?? porDefecto).toString();

  // 1. Registro (/api/registro)
  static Future<Map<String, dynamic>> registrar({
    required String nombreUsuario,
    required String correo,
    required String password,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/registro'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'nombre_usuario': nombreUsuario,
              'correo': correo,
              'password': password,
            }),
          )
          .timeout(_timeout);

      final data = _decode(response);

      if (response.statusCode == 201) {
        return {
          'exito': true,
          'mensaje': data['mensaje'] ?? 'Usuario registrado correctamente.',
          'usuario': data['usuario'],
        };
      }
      return {
        'exito': false,
        'error': _mensajeError(data, 'Error desconocido en el registro'),
      };
    } catch (e) {
      return {'exito': false, 'error': 'No se pudo conectar al servidor: $e'};
    }
  }

  // 2. Login (/api/login)
  static Future<Map<String, dynamic>> login({
    required String correo,
    required String password,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/login'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'correo': correo, 'password': password}),
          )
          .timeout(_timeout);

      final data = _decode(response);

      if (response.statusCode == 200) {
        await _storage.write(key: 'jwt', value: data['token']);
        await _storage.write(key: 'usuario', value: jsonEncode(data['usuario']));

        return {
          'exito': true,
          'token': data['token'],
          'usuario': data['usuario'],
        };
      }
      return {
        'exito': false,
        'error': _mensajeError(data, 'Credenciales inválidas'),
      };
    } catch (e) {
      return {'exito': false, 'error': 'No se pudo conectar al servidor: $e'};
    }
  }

  // 3. Estado del servidor (/api/estado)
  static Future<bool> verificarServidor() async {
    try {
      final response =
          await http.get(Uri.parse('$baseUrl/estado')).timeout(_timeout);
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  // 4. Sesión guardada
  static Future<String?> getToken() => _storage.read(key: 'jwt');

  static Future<Map<String, String>> authHeader() async {
    final token = await getToken();
    return {
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  static Future<Usuario?> getUsuario() async {
    final raw = await _storage.read(key: 'usuario');
    if (raw == null) return null;
    return Usuario.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  static Future<void> logout() async {
    await _storage.delete(key: 'jwt');
    await _storage.delete(key: 'usuario');
  }
}