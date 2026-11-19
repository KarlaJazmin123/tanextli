import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../data/curso_data.dart';
import '../data/medios_curso.dart';
import '../utils/colors.dart';
import '../widgets/tani_widget.dart';

enum _Fase { intro, palabra, fin }

enum _Intento { esperando, grabando, bien, reintentar }

/// Pantalla de una lección (una subcategoría de curso_data.dart):
///   1. Intro: lista de palabras + botón "Comenzar".
///   2. Por cada palabra: imagen, escuchar el audio, mantener presionado el
///      micrófono para repetir, y Tani da retroalimentación.
///   3. Fin: Tani felicita y se cierra con Navigator.pop(context, true).
///
/// Devuelve true si el niño terminó la lección (null/false si salió antes).
class LeccionScreen extends StatefulWidget {
  /// Clave de la categoría en curso_data.dart (ej. "Familia").
  final String categoriaKey;

  /// Posición de la lección dentro de la categoría (0 = Lección 1).
  final int indice;

  const LeccionScreen({
    super.key,
    required this.categoriaKey,
    required this.indice,
  });

  @override
  State<LeccionScreen> createState() => _LeccionScreenState();
}

class _LeccionScreenState extends State<LeccionScreen> {
  static const _mensajeInicial = '¡Escucha con atención y luego repite conmigo!';

  static const _mensajesBien = [
    '¡Lo hiciste muy bien!',
    '¡Excelente! Lo dijiste muy bien',
    '¡Muy bien, sigue así!',
    '¡Qué bien suena! Eres increíble',
  ];

  static const _mensajesReintentar = [
    'Inténtalo de nuevo, tú puedes',
    'Casi lo logras, ¡una vez más!',
    'Escucha otra vez y repite conmigo',
  ];

  /// Tiempo mínimo manteniendo presionado el micrófono para contar el intento.
  static const _duracionMinima = Duration(milliseconds: 900);

  final _player = AudioPlayer();
  final _random = Random();

  _Fase _fase = _Fase.intro;
  int _i = 0; // palabra actual
  _Intento _intento = _Intento.esperando;
  String _mensajeTani = _mensajeInicial;
  DateTime? _inicioGrabacion;
  bool _reproduciendo = false;

  SubcategoriaCurso get _sub =>
      cursoPorCategoria[widget.categoriaKey]![widget.indice];
  PalabraCurso get _palabra => _sub.palabras[_i];
  bool get _esUltima => _i == _sub.palabras.length - 1;

  @override
  void initState() {
    super.initState();
    _player.onPlayerComplete.listen((_) {
      if (mounted) setState(() => _reproduciendo = false);
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------- Flujo

  void _comenzar() {
    setState(() {
      _fase = _Fase.palabra;
      _i = 0;
      _intento = _Intento.esperando;
      _mensajeTani = _mensajeInicial;
    });
  }

  void _siguiente() {
    _player.stop();
    if (_esUltima) {
      setState(() => _fase = _Fase.fin);
      return;
    }
    setState(() {
      _i++;
      _intento = _Intento.esperando;
      _mensajeTani = _mensajeInicial;
      _reproduciendo = false;
    });
  }

  void _terminar() {
    // TODO: cuando existan la Actividad 1 y la Actividad 2, mandar al niño
    // a ellas antes de cerrar la lección.
    Navigator.pop(context, true);
  }

  // ---------------------------------------------------------------- Audio

  void _avisar(String texto) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(texto)));
  }

  Future<void> _reproducir() async {
    final audio = medioDe(widget.categoriaKey, _palabra)?.audio;
    if (audio == null) {
      _avisar('El audio de esta palabra todavía no está disponible.');
      return;
    }
    try {
      await _player.stop();
      setState(() => _reproduciendo = true);
      await _player.play(
        audio.startsWith('http') ? UrlSource(audio) : AssetSource(audio),
      );
    } catch (_) {
      if (mounted) setState(() => _reproduciendo = false);
      _avisar('No se pudo reproducir el audio.');
    }
  }

  // ----------------------------------------------------------- Micrófono

  void _iniciarGrabacion() {
    _player.stop();
    setState(() {
      _reproduciendo = false;
      _intento = _Intento.grabando;
      _inicioGrabacion = DateTime.now();
    });
  }

  void _terminarGrabacion() {
    if (_intento != _Intento.grabando) return;
    final duracion = DateTime.now().difference(_inicioGrabacion!);
    final bien = _evaluar(duracion);
    final mensajes = bien ? _mensajesBien : _mensajesReintentar;
    setState(() {
      _intento = bien ? _Intento.bien : _Intento.reintentar;
      _mensajeTani = mensajes[_random.nextInt(mensajes.length)];
    });
    // TODO: si bien == true, guardar la palabra como completada en el
    // servidor con ApiService.registrarProgreso(usuarioId:, palabraId:,
    // categoriaId:) cuando Oliver entregue los IDs.
  }

  /// Por ahora solo comprueba que el niño mantuvo presionado el micrófono el
  /// tiempo mínimo. Aquí se conectará el reconocimiento de voz.
  bool _evaluar(Duration duracion) => duracion >= _duracionMinima;

  // ------------------------------------------------------------------ UI

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
          child: switch (_fase) {
            _Fase.intro => _buildIntro(),
            _Fase.palabra => _buildPalabra(),
            _Fase.fin => _buildFin(),
          },
        ),
      ),
    );
  }

  Widget _flechaAtras() {
    return Align(
      alignment: Alignment.centerLeft,
      child: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back, color: AppColors.primaryGreen),
      ),
    );
  }

  Widget _globo(String texto) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primaryGreen),
      ),
      child: Text(
        texto,
        style: const TextStyle(
          color: AppColors.textDark,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
    );
  }

  // ---- Pantalla 1: intro con la lista de palabras

  Widget _buildIntro() {
    final palabras = _sub.palabras;
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Column(
        children: [
          _flechaAtras(),
          Text(
            'Lección ${widget.indice + 1}',
            style: const TextStyle(
              color: AppColors.textDark,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _sub.nombre,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.textDark,
              fontWeight: FontWeight.w800,
              fontSize: 26,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: _globo('Hoy aprenderemos ${palabras.length} palabras')),
              const SizedBox(width: 12),
              const TaniWidget(size: 120),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.primaryGreen.withOpacity(0.5), width: 1.6),
              ),
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 20),
                children: [
                  for (final p in palabras)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        p.espanol,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: AppColors.textDark,
                          fontWeight: FontWeight.w800,
                          fontSize: 22,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: _comenzar,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGreen,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                'Comenzar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---- Pantalla 2: escucha y repite

  Widget _buildPalabra() {
    final grabando = _intento == _Intento.grabando;
    final hecho = _intento == _Intento.bien;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      child: Column(
        children: [
          _flechaAtras(),
          Text(
            'Lección ${widget.indice + 1}: ${_sub.nombre}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.textDark,
              fontWeight: FontWeight.w800,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const TaniWidget(size: 110),
              const SizedBox(width: 12),
              Expanded(child: _globo(_mensajeTani)),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.85),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                  color: AppColors.primaryGreen.withOpacity(0.5), width: 1.6),
            ),
            child: Column(
              children: [
                _imagenPalabra(),
                const SizedBox(height: 10),
                Text(
                  _palabra.nahuatl,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.textDark,
                    fontWeight: FontWeight.w800,
                    fontSize: 26,
                  ),
                ),
                Text(
                  _palabra.espanol,
                  style: const TextStyle(
                    color: AppColors.textDark,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 14),
                // Botón de escuchar
                InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: _reproducir,
                  child: Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: _reproduciendo
                          ? AppColors.primaryGreen.withOpacity(0.25)
                          : AppColors.lightGreenBg,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.primaryGreen, width: 1.6),
                    ),
                    child: const Icon(Icons.volume_up_rounded,
                        size: 34, color: AppColors.primaryGreen),
                  ),
                ),
                const SizedBox(height: 18),
                // Micrófono: mantener presionado
                GestureDetector(
                  onTapDown: (_) => _iniciarGrabacion(),
                  onTapUp: (_) => _terminarGrabacion(),
                  onTapCancel: _terminarGrabacion,
                  child: AnimatedScale(
                    scale: grabando ? 1.12 : 1.0,
                    duration: const Duration(milliseconds: 150),
                    child: Container(
                      width: 104,
                      height: 104,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: grabando
                            ? AppColors.primaryGreen
                            : AppColors.lightGreenBg,
                        border: Border.all(
                            color: AppColors.primaryGreen, width: 2),
                      ),
                      child: Icon(
                        Icons.mic_rounded,
                        size: 52,
                        color: grabando ? Colors.white : AppColors.primaryGreen,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  grabando ? 'Te estoy escuchando…' : 'Mantén presionado y repite',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.textDark,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: OutlinedButton.icon(
                    onPressed: _reproducir,
                    icon: const Icon(Icons.refresh_rounded,
                        color: AppColors.primaryGreen),
                    label: const Text(
                      'Repetir audio',
                      style: TextStyle(
                        color: AppColors.textDark,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                          color: AppColors.primaryGreen, width: 1.6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // El botón Siguiente aparece cuando el niño lo dijo bien
          if (hecho) ...[
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: _siguiente,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  _esUltima ? 'Terminar palabras' : 'Siguiente palabra',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _imagenPalabra() {
    final imagen = medioDe(widget.categoriaKey, _palabra)?.imagen;

    Widget respaldo() => Container(
          width: 96,
          height: 96,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.lightGreenBg,
          ),
          child: const Icon(Icons.image_outlined,
              size: 44, color: AppColors.primaryGreen),
        );

    if (imagen == null) return respaldo();

    final widgetImagen = imagen.startsWith('http')
        ? Image.network(imagen,
            width: 96, height: 96, fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => respaldo())
        : Image.asset(imagen,
            width: 96, height: 96, fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => respaldo());

    return ClipOval(child: widgetImagen);
  }

  // ---- Pantalla 3: fin de las palabras

  Widget _buildFin() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      child: Column(
        children: [
          _flechaAtras(),
          const Spacer(),
          const TaniWidget(size: 160),
          const SizedBox(height: 16),
          _globo('¡Terminaste las ${_sub.palabras.length} palabras de '
              '“${_sub.nombre}”! Lo hiciste muy bien'),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: _terminar,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryGreen,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                'Terminar lección',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}