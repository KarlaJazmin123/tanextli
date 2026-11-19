enum EstadoLeccion { completada, enProgreso, bloqueada }

class Leccion {
  final String etiqueta; // "Lección 1", "Lección final"...
  final String titulo; // "Familia", "Repaso"...
  final int? palabras; // null en el repaso
  final EstadoLeccion estado;

  const Leccion({
    required this.etiqueta,
    required this.titulo,
    this.palabras,
    this.estado = EstadoLeccion.bloqueada,
  });

  Leccion conEstado(EstadoLeccion nuevo) => Leccion(
        etiqueta: etiqueta,
        titulo: titulo,
        palabras: palabras,
        estado: nuevo,
      );
}

/// Calcula el estado de cada lección a partir de cuántas lleva completadas
/// el usuario: las anteriores quedan con palomita, la siguiente queda
/// abierta (flecha) y el resto bloqueadas (candado).
List<Leccion> aplicarProgreso(List<Leccion> base, int completadas) {
  return [
    for (var i = 0; i < base.length; i++)
      base[i].conEstado(
        i < completadas
            ? EstadoLeccion.completada
            : i == completadas
                ? EstadoLeccion.enProgreso
                : EstadoLeccion.bloqueada,
      ),
  ];
}