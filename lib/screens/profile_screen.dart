import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../services/auth_service.dart';
import '../models/usuario.dart';
import '../data/curso_data.dart';
import 'login_screen.dart';

/// Pantalla de perfil: datos de la cuenta, estadísticas y progreso por
/// categoría. Los datos de la cuenta vienen de la sesión guardada
/// (AuthService.getUsuario()).
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Usuario? _usuario;
  bool _cargando = true;

  // TODO: reemplazar por datos reales de /api/progreso cuando Oliver los
  // tenga. Valores de ejemplo (fracción de palabras aprendidas por categoría).
  static const Map<String, double> _progresoEjemplo = {
    'Familia': 0.4,
  };
  static const int _palabrasAprendidasEjemplo = 5;
  static const int _leccionesCompletadasEjemplo = 1;

  static const _categorias = <_CategoriaPerfil>[
    _CategoriaPerfil('Familia', 'Familia', Icons.people_alt_rounded),
    _CategoriaPerfil('Sentimientos', 'Sentimientos', Icons.favorite_rounded),
    _CategoriaPerfil('Colores', 'Colores', Icons.palette_rounded),
    _CategoriaPerfil('Numeros', 'Números', Icons.tag_rounded),
    _CategoriaPerfil('Frases', 'Frases', Icons.chat_bubble_rounded),
    _CategoriaPerfil(
        'PartesDelCuerpo', 'Partes del cuerpo', Icons.accessibility_new_rounded),
    _CategoriaPerfil('Animales', 'Animales', Icons.pets_rounded),
    _CategoriaPerfil('Objetos', 'Objetos', Icons.grid_view_rounded),
  ];

  static const _meses = [
    'enero', 'febrero', 'marzo', 'abril', 'mayo', 'junio',
    'julio', 'agosto', 'septiembre', 'octubre', 'noviembre', 'diciembre',
  ];

  @override
  void initState() {
    super.initState();
    _cargarUsuario();
  }

  Future<void> _cargarUsuario() async {
    final usuario = await AuthService.getUsuario();
    if (!mounted) return;
    setState(() {
      _usuario = usuario;
      _cargando = false;
    });
  }

  int get _totalPalabrasCurso => cursoPorCategoria.values
      .expand((subs) => subs)
      .fold<int>(0, (suma, sub) => suma + sub.totalPalabras);

  String? get _miembroDesde {
    final fecha = _usuario?.creadoEn?.toLocal();
    if (fecha == null) return null;
    return '${_meses[fecha.month - 1]} de ${fecha.year}';
  }

  Future<void> _confirmarCerrarSesion() async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Cerrar sesión'),
        content: const Text('¿Seguro que quieres cerrar tu sesión?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Cerrar sesión',
                style: TextStyle(color: AppColors.primaryGreen)),
          ),
        ],
      ),
    );
    if (confirmar != true) return;

    await AuthService.logout();
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final nombre = _usuario?.nombreUsuario ?? 'Usuario';
    final correo = _usuario?.correo ?? '';

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.lightGreenBg, AppColors.creamBackground],
          ),
        ),
        child: SafeArea(
          child: _cargando
              ? const Center(
                  child: CircularProgressIndicator(color: AppColors.primaryGreen),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back,
                              color: AppColors.primaryGreen),
                        ),
                      ),
                      _buildEncabezado(nombre, correo),
                      const SizedBox(height: 22),
                      _buildEstadisticas(),
                      const SizedBox(height: 24),
                      const Text(
                        'Mi progreso',
                        style: TextStyle(
                          color: AppColors.textDark,
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 12),
                      for (final cat in _categorias) ...[
                        _buildProgresoCategoria(cat.label, cat.icon, cat.key),
                        const SizedBox(height: 10),
                      ],
                      const SizedBox(height: 14),
                      SizedBox(
                        height: 52,
                        child: OutlinedButton.icon(
                          onPressed: _confirmarCerrarSesion,
                          icon: const Icon(Icons.logout_rounded,
                              color: AppColors.primaryGreen),
                          label: const Text(
                            'Cerrar sesión',
                            style: TextStyle(
                              color: AppColors.primaryGreen,
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: AppColors.primaryGreen),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildEncabezado(String nombre, String correo) {
    return Column(
      children: [
        Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryGreen.withOpacity(0.15),
            border: Border.all(color: AppColors.primaryGreen, width: 2.5),
          ),
          child: const Icon(Icons.person_rounded,
              size: 54, color: AppColors.primaryGreen),
        ),
        const SizedBox(height: 12),
        Text(
          nombre,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.textDark,
            fontWeight: FontWeight.w800,
            fontSize: 24,
          ),
        ),
        if (correo.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            correo,
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.textDark, fontSize: 14),
          ),
        ],
        if (_miembroDesde != null) ...[
          const SizedBox(height: 4),
          Text(
            'Aprendiendo desde $_miembroDesde',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textDark.withOpacity(0.7),
              fontSize: 12.5,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildEstadisticas() {
    return Row(
      children: [
        Expanded(
          child: _TarjetaEstadistica(
            icon: Icons.translate_rounded,
            valor: '$_palabrasAprendidasEjemplo',
            etiqueta: 'de $_totalPalabrasCurso palabras',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _TarjetaEstadistica(
            icon: Icons.check_circle_outline_rounded,
            valor: '$_leccionesCompletadasEjemplo',
            etiqueta: 'lecciones completadas',
          ),
        ),
      ],
    );
  }

  Widget _buildProgresoCategoria(String label, IconData icon, String key) {
    final progreso = _progresoEjemplo[key] ?? 0.0;
    final porcentaje = (progreso * 100).round();
    final totalPalabras = (cursoPorCategoria[key] ?? const [])
        .fold<int>(0, (suma, sub) => suma + sub.totalPalabras);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.75),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primaryGreen, width: 1.4),
      ),
      child: Row(
        children: [
          Icon(icon, size: 26, color: AppColors.primaryGreen),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        label,
                        style: const TextStyle(
                          color: AppColors.textDark,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Text(
                      '$porcentaje%',
                      style: const TextStyle(
                        color: AppColors.textDark,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progreso,
                    minHeight: 8,
                    backgroundColor: Colors.white,
                    color: AppColors.primaryGreen,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$totalPalabras palabras',
                  style: TextStyle(
                    color: AppColors.textDark.withOpacity(0.7),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoriaPerfil {
  final String key; // clave en curso_data.dart
  final String label;
  final IconData icon;

  const _CategoriaPerfil(this.key, this.label, this.icon);
}

class _TarjetaEstadistica extends StatelessWidget {
  final IconData icon;
  final String valor;
  final String etiqueta;

  const _TarjetaEstadistica({
    required this.icon,
    required this.valor,
    required this.etiqueta,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, size: 28, color: AppColors.primaryGreen),
          const SizedBox(height: 6),
          Text(
            valor,
            style: const TextStyle(
              color: AppColors.textDark,
              fontWeight: FontWeight.w800,
              fontSize: 26,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            etiqueta,
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.textDark, fontSize: 12),
          ),
        ],
      ),
    );
  }
}