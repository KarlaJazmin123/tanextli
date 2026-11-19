import 'package:flutter/material.dart';
import '../utils/colors.dart';
import 'category lessons.dart';

/// Pantalla previa a la categoría: explica qué trae cada lección.
/// Uso: Navigator.push(context, MaterialPageRoute(
///   builder: (_) => LessonIntroScreen(
///     categoria: 'Familia', categoriaKey: 'Familia')));
class LessonIntroScreen extends StatelessWidget {
  final String categoria; // título que se muestra
  final String categoriaKey; // clave en curso_data.dart

  const LessonIntroScreen({
    super.key,
    required this.categoria,
    required this.categoriaKey,
  });

  static const _items = <_IntroItem>[
    _IntroItem(
      icon: Icons.volume_up_rounded,
      titulo: 'Escucha',
      descripcion: 'Escucha la palabra en náhuatl',
    ),
    _IntroItem(
      icon: Icons.mic_rounded,
      titulo: 'Repite',
      descripcion: 'Repite la palabra para tu pronunciación',
    ),
    _IntroItem(
      icon: Icons.description_rounded,
      titulo: 'Actividad 1',
      descripcion: 'Opción múltiple. Elige la respuesta correcta',
    ),
    _IntroItem(
      icon: Icons.edit_rounded,
      titulo: 'Actividad 2',
      descripcion: 'Escribe la traducción para aprueba lo que aprendiste',
    ),
  ];

  void _continuar(BuildContext context) {
    // pushReplacement: al volver atrás desde las lecciones se regresa a las
    // categorías, no a esta pantalla.
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => CategoryLessonsScreen(
          categoria: categoria,
          categoriaKey: categoriaKey,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            children: [
              // Barra de título
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: const BoxDecoration(
                  color: AppColors.primaryGreen,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(18),
                  ),
                ),
                child: const Text(
                  '¿Qué hay en cada lección?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: AppColors.primaryGreen),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Cada lección tiene:',
                          style: TextStyle(
                            color: AppColors.textDark,
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 8),
                        for (int i = 0; i < _items.length; i++) ...[
                          if (i > 0)
                            Divider(
                              height: 1,
                              color: AppColors.primaryGreen.withOpacity(0.35),
                            ),
                          _items[i],
                        ],
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () => _continuar(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Continuar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IntroItem extends StatelessWidget {
  final IconData icon;
  final String titulo;
  final String descripcion;

  const _IntroItem({
    required this.icon,
    required this.titulo,
    required this.descripcion,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        children: [
          Icon(icon, size: 34, color: AppColors.primaryGreen),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: const TextStyle(
                    color: AppColors.textDark,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  descripcion,
                  style: const TextStyle(
                    color: AppColors.textDark,
                    fontSize: 12.5,
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