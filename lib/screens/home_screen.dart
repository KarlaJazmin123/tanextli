import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../widgets/tani_widget.dart';
import '../services/auth_service.dart';
import '../models/usuario.dart';
import 'login_screen.dart';
import 'lesson intro.dart';
import 'profile_screen.dart';

/// Representa una tarjeta de categoría en el grid principal.
/// [key] debe coincidir con el nombre de categoría que usa Oliver en
/// /api/categorias, para poder pedir sus palabras después.
class _CategoriaItem {
  final String key;
  final String label;
  final IconData icon;
  final Color bgColor;
  final Color iconColor;

  const _CategoriaItem({
    required this.key,
    required this.label,
    required this.icon,
    required this.bgColor,
    required this.iconColor,
  });
}

const _categorias = [
  _CategoriaItem(
    key: 'Familia',
    label: 'Familia',
    icon: Icons.people_alt_rounded,
    bgColor: Color(0xFFFDECDC),
    iconColor: Color(0xFFE07A2C),
  ),
  _CategoriaItem(
    key: 'Sentimientos',
    label: 'Sentimientos',
    icon: Icons.favorite_rounded,
    bgColor: Color(0xFFFCE8EE),
    iconColor: Color(0xFFD94F79),
  ),
  _CategoriaItem(
    key: 'Colores',
    label: 'Colores',
    icon: Icons.palette_rounded,
    bgColor: Color(0xFFEEE5F8),
    iconColor: Color(0xFF9B6BC7),
  ),
  _CategoriaItem(
    key: 'Numeros',
    label: 'Números',
    icon: Icons.tag_rounded,
    bgColor: Color(0xFFFDECDC),
    iconColor: Color(0xFFE07A2C),
  ),
  _CategoriaItem(
    key: 'Frases',
    label: 'Frases',
    icon: Icons.chat_bubble_rounded,
    bgColor: Color(0xFFE8F4EC),
    iconColor: AppColors.primaryGreen,
  ),
  _CategoriaItem(
    key: 'PartesDelCuerpo',
    label: 'Partes del cuerpo',
    icon: Icons.accessibility_new_rounded,
    bgColor: Color(0xFFFCE8EE),
    iconColor: Color(0xFFD94F79),
  ),
  _CategoriaItem(
    key: 'Animales',
    label: 'Animales',
    icon: Icons.pets_rounded,
    bgColor: Color(0xFFE8F4EC),
    iconColor: AppColors.primaryGreen,
  ),
  _CategoriaItem(
    key: 'Objetos',
    label: 'Objetos',
    icon: Icons.grid_view_rounded,
    bgColor: Color(0xFFEEE5F8),
    iconColor: Color(0xFF9B6BC7),
  ),
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Usuario? _usuario;

  @override
  void initState() {
    super.initState();
    _cargarUsuario();
  }

  Future<void> _cargarUsuario() async {
    final usuario = await AuthService.getUsuario();
    if (mounted) setState(() => _usuario = usuario);
  }

  Future<void> _cerrarSesion() async {
    await AuthService.logout();
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  /// Abre la intro de la categoría y después su lista de lecciones.
  void _abrirCategoria(_CategoriaItem categoria) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LessonIntroScreen(
          categoria: categoria.label,
          categoriaKey: categoria.key,
        ),
      ),
    );
  }

  /// Desde el menú lateral: primero cierra el drawer y luego navega.
  void _abrirCategoriaDesdeMenu(_CategoriaItem categoria) {
    Navigator.pop(context); // cierra el drawer
    _abrirCategoria(categoria);
  }

  void _abrirXar() {
    // TODO: navegar a la pantalla de detección AR (ApiService.detectarObjetoAr).
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Abrir XAR')),
    );
  }

  void _abrirXarDesdeMenu() {
    Navigator.pop(context); // cierra el drawer
    _abrirXar();
  }

  void _abrirPerfil() {
    Navigator.pop(context); // cierra el drawer
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ProfileScreen()),
    );
  }

  void _proximamente(String seccion) {
    Navigator.pop(context); // cierra el drawer
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$seccion: próximamente')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final nombre = _usuario?.nombreUsuario ?? '';

    return Scaffold(
      drawer: _buildDrawer(nombre),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.lightGreenBg, AppColors.creamBackground],
                ),
              ),
            ),
            Positioned(
              top: -40,
              right: -60,
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryGreen.withOpacity(0.12),
                ),
              ),
            ),
            Positioned(
              top: 120,
              left: -50,
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryGreen.withOpacity(0.10),
                ),
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  _buildHeader(context, nombre),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                      child: Column(
                        children: [
                          _buildSaludo(nombre),
                          const SizedBox(height: 20),
                          _buildGrid(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String nombre) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
      child: Row(
        children: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: AppColors.textDark, size: 28),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          const Spacer(),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryGreen.withOpacity(0.12),
            ),
            child: const Icon(Icons.notifications_none_rounded, color: AppColors.primaryGreen),
          ),
        ],
      ),
    );
  }

  Widget _buildSaludo(String nombre) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nombre.isNotEmpty ? '¡Cualli tonalli,' : '¡Cualli tonalli!',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textDark,
                ),
              ),
              if (nombre.isNotEmpty)
                Text(
                  '$nombre!',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textDark,
                  ),
                ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text('¿Qué aprenderemos hoy?',
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                    SizedBox(width: 6),
                    Icon(Icons.chevron_right, size: 18),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        const TaniWidget(size: 100),
      ],
    );
  }

  Widget _buildGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _categorias.length + 2, // + espacio libre + XAR
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.25,
      ),
      itemBuilder: (context, index) {
        if (index < _categorias.length) {
          final categoria = _categorias[index];
          return _CategoryCard(
            label: categoria.label,
            icon: categoria.icon,
            bgColor: categoria.bgColor,
            iconColor: categoria.iconColor,
            onTap: () => _abrirCategoria(categoria),
          );
        }
        if (index == _categorias.length) {
          // Espacio libre para una futura categoría.
          return const SizedBox.shrink();
        }
        return _CategoryCard(
          label: 'XAR',
          icon: Icons.camera_alt_rounded,
          bgColor: const Color(0xFFE3EBFB),
          iconColor: const Color(0xFF3E7BD9),
          onTap: _abrirXar,
        );
      },
    );
  }

  Widget _buildDrawer(String nombre) {
    return Drawer(
      backgroundColor: const Color(0xFF1F4A3A),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.15),
                          ),
                          child: const Icon(Icons.person, color: Colors.white, size: 32),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          nombre.isNotEmpty ? nombre : 'Nombre',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.white24, height: 1),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  _drawerItem(Icons.home_rounded, 'Inicio', () => Navigator.pop(context)),
                  // Las categorías salen de la misma lista que el grid,
                  // así el menú y las tarjetas siempre coinciden.
                  for (final categoria in _categorias)
                    _drawerItem(
                      categoria.icon,
                      categoria.label,
                      () => _abrirCategoriaDesdeMenu(categoria),
                    ),
                  _drawerItem(Icons.camera_alt_rounded, 'XAR', _abrirXarDesdeMenu),
                  const Divider(color: Colors.white24, height: 24),
                  _drawerItem(Icons.person_outline_rounded, 'Perfil', _abrirPerfil),
                  _drawerItem(Icons.settings_rounded, 'Configuración',
                      () => _proximamente('Configuración')),
                  _drawerItem(Icons.logout_rounded, 'Cerrar sesión', _cerrarSesion),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(IconData icon, String label, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white, size: 22),
      title: Text(label, style: const TextStyle(color: Colors.white, fontSize: 15)),
      onTap: onTap,
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color bgColor;
  final Color iconColor;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.label,
    required this.icon,
    required this.bgColor,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -14,
              right: -14,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.25),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 30, color: iconColor),
                  const SizedBox(height: 8),
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 15, color: AppColors.textDark),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}