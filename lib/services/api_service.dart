import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../models/categoria.dart';
import '../models/palabra.dart';
import '../models/objeto_detectado.dart';
import '../models/api_exception.dart';
import '../utils/api_config.dart';
import 'auth_service.dart';

/// Junta las llamadas a categorías, palabras, audio, progreso y detección
/// AR contra el servidor de Oliver. Usa AuthService.authHeader() para el
/// header de autorización en las rutas protegidas.
class ApiService {
  /// GET /api/categorias
  Future<List<Categoria>> getCategorias() async {
    final headers = await AuthService.authHeader();
    final response = await http.get(
      ApiConfig.endpoint('/api/categorias'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body);
      return Categoria.listFromJson(json);
    }
    throw ApiException.fromResponse(response.statusCode, jsonDecode(response.body));
  }

  /// GET /api/categorias/:id/palabras
  Future<List<Palabra>> getPalabras(String categoriaId) async {
    final headers = await AuthService.authHeader();
    final response = await http.get(
      ApiConfig.endpoint('/api/categorias/$categoriaId/palabras'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body);
      return Palabra.listFromJson(json);
    }
    throw ApiException.fromResponse(response.statusCode, jsonDecode(response.body));
  }

  /// POST /api/progreso — guarda o actualiza (upsert) el progreso de UNA
  /// palabra. Si ya existe el registro, el servidor lo actualiza y suma
  /// veces_practicada automáticamente.
  Future<void> registrarProgreso({
    required int usuarioId,
    required int palabraId,
    required int categoriaId,
    bool completado = true,
  }) async {
    final headers = {
      'Content-Type': 'application/json',
      ...await AuthService.authHeader(),
    };

    final response = await http.post(
      ApiConfig.endpoint('/api/progreso'),
      headers: headers,
      body: jsonEncode({
        'usuario_id': usuarioId,
        'palabra_id': palabraId,
        'categoria_id': categoriaId,
        'completado': completado,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) return;
    throw ApiException.fromResponse(response.statusCode, jsonDecode(response.body));
  }

  /// GET /api/progreso/:usuarioId — devuelve la lista "progreso" con las
  /// palabras del usuario (español, náhuatl, URLs de audio, completado...).
  /// Se deja como Map hasta confirmar los campos exactos de cada registro.
  Future<List<Map<String, dynamic>>> getProgresoUsuario(int usuarioId) async {
    final headers = await AuthService.authHeader();
    final response = await http.get(
      ApiConfig.endpoint('/api/progreso/$usuarioId'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return List<Map<String, dynamic>>.from(data['progreso'] ?? []);
    }
    throw ApiException.fromResponse(response.statusCode, jsonDecode(response.body));
  }

  /// POST /api/ar/detectar — manda la imagen capturada por la cámara.
  Future<ObjetoDetectado> detectarObjetoAr(File imagen) async {
    final headers = await AuthService.authHeader();
    final request = http.MultipartRequest(
      'POST',
      ApiConfig.endpoint('/api/ar/detectar'),
    );
    request.headers.addAll(headers);
    request.files.add(await http.MultipartFile.fromPath('imagen', imagen.path));

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      return ObjetoDetectado.fromJson(jsonDecode(response.body));
    }
    throw ApiException.fromResponse(response.statusCode, jsonDecode(response.body));
  }
}