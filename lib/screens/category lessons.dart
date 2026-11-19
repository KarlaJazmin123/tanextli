import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/colors.dart';
import '../widgets/tani_widget.dart';
import '../models/leccion.dart';
import '../data/curso_data.dart';
import 'leccion_screen.dart';

/// Lista de lecciones de una categoría, con barra de progreso.
///
/// - La lección terminada muestra palomita.
/// - La siguiente lección queda abierta (flecha) y las demás siguen con
///   candado hasta terminar la anterior.
/// - El avance se guarda en el celular (shared_preferences) mientras Oliver
///   termina /api/progreso.
class CategoryLessonsScreen extends StatefulWidget {
  /// Nombre que se muestra como título (ej. "Partes del cuerpo").
  final String categoria;

  /// Clave de la categoría en curso_data.dart (ej. "PartesDelCuerpo").
  final String categoriaKey;

  const CategoryLessonsScreen({
    super.key,
    required this.categoria,
    required this.categoriaKey,
  });

  @override
  State<CategoryLessonsScreen> createState() => _CategoryLessonsScreenState();
}

class _CategoryLessonsScreenState extends State<CategoryLessonsScreen> {
  /// Cuántas lecciones lleva terminadas el usuario en esta categoría.
  int _completadas = 0;

  String get _clave => 'progreso_${widget.categoriaKey}';

  List<SubcategoriaCurso> get _subs =>
      cursoPorCategoria[widget.categoriaKey] ?? const [];

  /// Lecciones totales: una por subcategoría + el repaso final.
  int get _total => _subs.isEmpty ? 0 : _subs.length + 1;

  @override
  void initState() {
    super.initState();
    _cargarProgreso();
  }

  Future<void> _cargarProgreso() async {
    final prefs = await SharedPreferences.getInstance();
    final guardado = prefs.getInt(_clave) ?? 0;
    if (!mounted) return;
    setState(() => _completadas = guardado.clamp(0, _total));
  }

  Future<void> _guardarProgreso() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_clave, _completadas);
    // TODO: cuando Oliver tenga /api/progreso, mandar aquí el avance al
    // servidor (y leerlo en _cargarProgreso).
  }

  /// El estado se deduce de cuántas lleva completadas:
  /// antes = completada, la siguiente = en progreso, el resto = bloqueada.
  EstadoLeccion _estadoDe(int indice) {
    if (indice < _completadas) return EstadoLeccion.completada;
    if (indice == _completadas) return EstadoLeccion.enProgreso;
    return EstadoLeccion.bloqueada;
  }

  /// Una lección por subcategoría del Excel + el repaso final.
  List<Leccion> _construirLecciones() {
    final lecciones = <Leccion>[
      for (int i = 0; i < _subs.length; i++)
        Leccion(
          etiqueta: 'Lección ${i + 1}',
          titulo: _subs[i].nombre,
          palabras: _subs[i].totalPalabras,
          estado: _estadoDe(i),
        ),
    ];
    if (lecciones.isNotEmpty) {
      lecciones.add(Leccion(
        etiqueta: 'Lección final',
        titulo: 'Repaso',
        estado: _estadoDe(lecciones.length),
      ));
    }
    return lecciones;
  }

  /// Abre la pantalla de la lección. Devuelve true si el niño la terminó
  /// (LeccionScreen hace Navigator.pop(context, true) al final).
  Future<bool?> _irALeccion(int indice, Leccion leccion) {
    if (indice < _subs.length) {
      return Navigator.push<bool>(
        context,
        MaterialPageRoute(
          builder: (_) => LeccionScreen(
            categoriaKey: widget.categoriaKey,
            indice: indice,
          ),
        ),
      );
    }

    // TEMPORAL: el repaso final todavía no tiene pantalla. Este diálogo de
    // prueba permite marcarlo como terminado.
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(leccion.titulo),
        content: const Text('El repaso todavía está en construcción.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cerrar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Marcar como terminado (prueba)'),
          ),
        ],
      ),
    );
  }

  Future<void> _abrirLeccion(int indice, Leccion leccion) async {
    if (leccion.estado == EstadoLeccion.bloqueada) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content:
                Text('Completa la lección anterior para desbloquear esta.'),
          ),
        );
      return;
    }

    final termino = await _irALeccion(indice, leccion);

    // Solo avanza si terminó la lección actual, no una que ya había hecho.
    if (termino == true && indice == _completadas && mounted) {
      setState(() => _completadas++);
      await _guardarProgreso();
    }
  }

  @override
  Widget build(BuildContext context) {
    final lecciones = _construirLecciones();
    final progreso = lecciones.isEmpty ? 0.0 : _completadas / lecciones.length;
    final porcentaje = (progreso * 100).round();

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
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  alignment: Alignment.centerLeft,
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back,
                      color: AppColors.primaryGreen),
                ),
                // Título + Tani con su globo de diálogo
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.categoria,
                            style: const TextStyle(
                              color: AppColors.textDark,
                              fontWeight: FontWeight.w800,
                              fontSize: 26,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: AppColors.primaryGreen),
                            ),
                            child: const Text(
                              'Hola, bienvenido,\n¿Estás listo para empezar?',
                              style: TextStyle(
                                color: AppColors.textDark,
                                fontWeight: FontWeight.w600,
                                fontSize: 12.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Más espacio para Tani (antes size: 100)
                    const TaniWidget(size: 140),
                  ],
                ),
                const SizedBox(height: 28),
                const Text(
                  'Progreso',
                  style: TextStyle(
                    color: AppColors.textDark,
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0, end: progreso),
                          duration: const Duration(milliseconds: 500),
                          builder: (_, valor, __) => LinearProgressIndicator(
                            value: valor,
                            minHeight: 22,
                            backgroundColor: Colors.white,
                            color: AppColors.primaryGreen,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '$porcentaje%',
                      style: const TextStyle(
                        color: AppColors.textDark,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                for (int i = 0; i < lecciones.length; i++) ...[
                  _LessonCard(
                    leccion: lecciones[i],
                    onTap: () => _abrirLeccion(i, lecciones[i]),
                  ),
                  const SizedBox(height: 14),
                ],
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LessonCard extends StatelessWidget {
  final Leccion leccion;
  final VoidCallback onTap;

  const _LessonCard({required this.leccion, required this.onTap});

  IconData get _iconoEstado {
    switch (leccion.estado) {
      case EstadoLeccion.completada:
        return Icons.check_box_outlined;
      case EstadoLeccion.enProgreso:
        return Icons.arrow_circle_right_outlined;
      case EstadoLeccion.bloqueada:
        return Icons.lock_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.75),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.primaryGreen, width: 1.6),
        ),
        child: Row(
          children: [
            const Icon(Icons.people_alt_rounded,
                size: 30, color: AppColors.primaryGreen),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    leccion.etiqueta,
                    style: const TextStyle(
                      color: AppColors.textDark,
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    leccion.titulo,
                    style: const TextStyle(
                      color: AppColors.textDark,
                      fontWeight: FontWeight.w800,
                      fontSize: 17,
                    ),
                  ),
                  if (leccion.palabras != null)
                    Text(
                      '${leccion.palabras} palabras',
                      style: const TextStyle(
                        color: AppColors.textDark,
                        fontSize: 11,
                      ),
                    ),
                ],
              ),
            ),
            Icon(_iconoEstado, size: 30, color: AppColors.primaryGreen),
          ],
        ),
      ),
    );
  }
}