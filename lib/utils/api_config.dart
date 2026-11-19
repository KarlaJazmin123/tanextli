/// Configuración central para hablar con el servidor de Oliver.
///
/// Cambia SOLO estos valores según dónde estés probando — el resto
/// de la app (AuthService, ApiService, etc.) nunca debe tener la URL
/// escrita a mano en otro lado.
class ApiConfig {
  /// Host del servidor. Oliver planea usar avahi-daemon para exponerlo
  /// como "tanextli-server.local" en vez de una IP numérica que cambia
  /// por DHCP. Si todavía no tienen eso funcionando, cámbialo temporalmente
  /// por la IP local de su laptop, ej. "192.168.1.50".
  static const String host = 'tanextli-server.local';

  /// TODO: confirmar con Oliver el puerto real del servidor.
  static const int port = 3000;

  /// TODO: confirmar con Oliver si el servidor corre en HTTP o HTTPS.
  static const String scheme = 'http';

  static String get baseUrl => '$scheme://$host:$port';

  static Uri endpoint(String path) {
    final cleanPath = path.startsWith('/') ? path : '/$path';
    return Uri.parse('$baseUrl$cleanPath');
  }
}