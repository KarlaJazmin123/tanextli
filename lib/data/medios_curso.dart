import 'curso_data.dart';

/// Imagen y audio de cada palabra del curso.
///
/// IMÁGENES: ya están las 191 en assets/images/<categoria>/<palabra>.png.
/// La imagen de una palabra se encuentra a partir de su texto en español
/// (se quitan acentos y mayúsculas: "Cuídate  mucho" -> cuidate_mucho) y de
/// la clave de su categoría en curso_data.dart. Las palabras cuyo nombre de
/// archivo es distinto están en [_alias].
///
/// AUDIOS: los audios están en el servidor. Mientras no se conecten, el
/// audio queda en null y la pantalla avisa que no está disponible. Cuando
/// tengas las URLs, llena [_audios] (clave igual a la de [_imagenes]) o
/// reemplaza [_audioDe] para pedirlas al servidor.
class MedioPalabra {
  final String? imagen;
  final String? audio;

  const MedioPalabra({this.imagen, this.audio});
}

/// Palabras cuyo nombre de archivo no coincide con su texto en español.
const Map<String, String> _alias = {
  
  'que_dios_te_bendiga': 'que_dios_te_vendiga',
  'eres_feo_a': 'eres_feo',
  'cuarto_habitacion': 'habitacion',
  'canasta_bolsa': 'canasta',
  'manta_cobija': 'manta',
 

  'dedos_de_la_mano': 'dedos_mano',
  'dedos_del_pie': 'dedos_pie',
  // Números: en curso_data.dart son dígitos, en las imágenes son palabras.
  '1': 'uno',
  '2': 'dos',
  '3': 'tres',
  '4': 'cuatro',
  '5': 'cinco',
  '6': 'seis',
  '7': 'siete',
  '8': 'ocho',
  '9': 'nueve',
  '10': 'diez',
  '11': 'once',
  '12': 'doce',
  '13': 'trece',
  '14': 'catorce',
  '15': 'quince',
  '16': 'dieciseis',
  '17': 'diecisiete',
  '18': 'dieciocho',
  '19': 'diecinueve',
  '20': 'veinte',
};

/// Audios por palabra: 'Categoria|nombre' -> URL (http...) o ruta de asset.
const Map<String, String> _audios = {
  // 'Familia|padre': 'https://olo.tail0de9ec.ts.net/audios/padre.mp3',
};

/// Clave 'Categoria|nombre' -> ruta de la imagen en assets.
const Map<String, String> _imagenes = {
  // Animales
  'Animales|aguila': 'assets/images/animales/aguila.png',
  'Animales|ardilla': 'assets/images/animales/ardilla.png',
  'Animales|buho': 'assets/images/animales/buho.png',
  'Animales|cacomixtle': 'assets/images/animales/cacomixtle.jpg',
  'Animales|colibri': 'assets/images/animales/colibri.png',
  'Animales|conejo': 'assets/images/animales/conejo.png',
  'Animales|coyote': 'assets/images/animales/coyote.png',
  'Animales|cerdo': 'assets/images/animales/cerdo.png',
  'Animales|gallina': 'assets/images/animales/gallina.png',
  'Animales|gallo': 'assets/images/animales/gallo.png',
  'Animales|gato': 'assets/images/animales/gato.png',
  'Animales|lagartija': 'assets/images/animales/lagartija.png',
  'Animales|mapache': 'assets/images/animales/mapache.png',
  'Animales|oveja': 'assets/images/animales/oveja.png',
  'Animales|pajaro': 'assets/images/animales/pajaro.png',
  'Animales|pato': 'assets/images/animales/pato.png',
  'Animales|pavo': 'assets/images/animales/pavo.png',
  'Animales|perro': 'assets/images/animales/perro.png',
  'Animales|serpiente': 'assets/images/animales/serpiente.png',
  'Animales|tlacuache': 'assets/images/animales/tlacuache.png',
  'Animales|tortuga': 'assets/images/animales/tortuga.png',
  'Animales|venado': 'assets/images/animales/venado.png',
  'Animales|zorro': 'assets/images/animales/zorro.png',
  // Colores
  'Colores|amarillo': 'assets/images/colores/amarillo.png',
  'Colores|blanco': 'assets/images/colores/blanco.png',
  'Colores|cafe': 'assets/images/colores/cafe.png',
  'Colores|gris': 'assets/images/colores/gris.png',
  'Colores|morado': 'assets/images/colores/morado.png',
  'Colores|naranja': 'assets/images/colores/naranja.png',
  'Colores|negro': 'assets/images/colores/negro.png',
  'Colores|rojo': 'assets/images/colores/rojo.png',
  'Colores|rosa': 'assets/images/colores/rosa.png',
  'Colores|verde': 'assets/images/colores/verde.png',
  // Familia
  'Familia|abuela': 'assets/images/familia/abuela.png',
  'Familia|abuelo': 'assets/images/familia/abuelo.png',
  'Familia|bebe': 'assets/images/familia/bebe.png',
  'Familia|cunada': 'assets/images/familia/cunada.png',
  'Familia|cunado': 'assets/images/familia/cunado.png',
  'Familia|familia': 'assets/images/familia/familia.png',
  'Familia|hermana': 'assets/images/familia/hermana.png',
  'Familia|hermano': 'assets/images/familia/hermano.png',
  'Familia|hombre': 'assets/images/familia/hombre.png',
  'Familia|joven': 'assets/images/familia/joven.png',
  'Familia|mama': 'assets/images/familia/mama.png',
  'Familia|mujer': 'assets/images/familia/mujer.png',
  'Familia|nieta': 'assets/images/familia/nieta.png',
  'Familia|nieto': 'assets/images/familia/nieto.png',
  'Familia|nina': 'assets/images/familia/nina.png',
  'Familia|nino': 'assets/images/familia/nino.png',
  'Familia|padre': 'assets/images/familia/padre.png',
  'Familia|prima': 'assets/images/familia/prima.png',
  'Familia|primo': 'assets/images/familia/primo.png',
  'Familia|senor': 'assets/images/familia/senor.png',
  'Familia|senora': 'assets/images/familia/senora.png',
  'Familia|sobrina': 'assets/images/familia/sobrina.png',
  'Familia|sobrino': 'assets/images/familia/sobrino.png',
  'Familia|suegra': 'assets/images/familia/suegra.png',
  'Familia|suegro': 'assets/images/familia/suegro.png',
  'Familia|tia': 'assets/images/familia/tia.png',
  'Familia|tio': 'assets/images/familia/tio.png',
  'Familia|vieja': 'assets/images/familia/vieja.png',
  'Familia|viejo': 'assets/images/familia/viejo.png',
  // Frases
  'Frases|buenas_noches': 'assets/images/frases/buenas_noches.png',
  'Frases|buenas_tardes': 'assets/images/frases/buenas_tardes.png',
  'Frases|buenos_dias': 'assets/images/frases/buenos_dias.png',
  'Frases|como_esta_tu_familia': 'assets/images/frases/como_esta_tu_familia.png',
  'Frases|como_estas': 'assets/images/frases/como_estas.png',
  'Frases|como_te_llamas': 'assets/images/frases/como_te_llamas.png',
  'Frases|cuanto_cuesta': 'assets/images/frases/cuanto_cuesta.png',
  'Frases|cuidate_mucho': 'assets/images/frases/cuidate_mucho.png',
  'Frases|de_acuerdo': 'assets/images/frases/de_acuerdo.png',
  'Frases|de_donde_eres': 'assets/images/frases/de_donde_eres.png',
  'Frases|de_nada': 'assets/images/frases/de_nada.png',
  'Frases|eres_feo': 'assets/images/frases/eres_feo.png',
  'Frases|eres_guapo': 'assets/images/frases/eres_guapo.png',
  'Frases|es_dificil': 'assets/images/frases/es_dificil.png',
  'Frases|es_facil': 'assets/images/frases/es_facil.png',
  'Frases|estas_bonita': 'assets/images/frases/estas_bonita.png',
  'Frases|estoy_bien': 'assets/images/frases/estoy_bien.png',
  'Frases|gracias': 'assets/images/frases/gracias.png',
  'Frases|guarda_silencio': 'assets/images/frases/guarda_silencio.png',
  'Frases|hasta_luego': 'assets/images/frases/hasta_luego.png',
  'Frases|hola': 'assets/images/frases/hola.png',
  'Frases|mi_nombre_es': 'assets/images/frases/mi_nombre_es.png',
  'Frases|mucho': 'assets/images/frases/mucho.png',
  'Frases|mucho_gusto': 'assets/images/frases/mucho_gusto.png',
  'Frases|nada': 'assets/images/frases/nada.png',
  'Frases|no': 'assets/images/frases/no.png',
  'Frases|no_me_gusta': 'assets/images/frases/no_me_gusta.png',
  'Frases|no_puedo': 'assets/images/frases/no_puedo.png',
  'Frases|no_quiero': 'assets/images/frases/no_quiero.png',
  'Frases|no_se': 'assets/images/frases/no_se.png',
  'Frases|no_tengo': 'assets/images/frases/no_tengo.png',
  'Frases|poco': 'assets/images/frases/poco.png',
  'Frases|que_descanses': 'assets/images/frases/que_descanses.png',
  'Frases|que_dios_te_vendiga': 'assets/images/frases/que_dios_te_vendiga.png',
  'Frases|que_necesitas': 'assets/images/frases/que_necesitas.png',
  'Frases|que_te_vaya_bien': 'assets/images/frases/que_te_vaya_bien.png',
  'Frases|que_tengas_un_buen_dia': 'assets/images/frases/que_tengas_un_buen_dia.png',
  'Frases|quiero_comer': 'assets/images/frases/quiero_comer.png',
  'Frases|si': 'assets/images/frases/si.png',
  'Frases|si_me_gusta': 'assets/images/frases/si_me_gusta.png',
  'Frases|si_puedo': 'assets/images/frases/si_puedo.png',
  'Frases|si_quiero': 'assets/images/frases/si_quiero.png',
  'Frases|si_se': 'assets/images/frases/si_se.png',
  'Frases|si_tengo': 'assets/images/frases/si_tengo.png',
  'Frases|te_quiero': 'assets/images/frases/te_quiero.png',
  'Frases|tengo_hambre': 'assets/images/frases/tengo_hambre.png',
  'Frases|ya_llegue': 'assets/images/frases/ya_llegue.png',
  // Numeros
  'Numeros|catorce': 'assets/images/numeros/catorce.png',
  'Numeros|cinco': 'assets/images/numeros/cinco.png',
  'Numeros|cuatro': 'assets/images/numeros/cuatro.png',
  'Numeros|diecinueve': 'assets/images/numeros/diecinueve.png',
  'Numeros|dieciocho': 'assets/images/numeros/dieciocho.png',
  'Numeros|dieciseis': 'assets/images/numeros/dieciseis.png',
  'Numeros|diecisiete': 'assets/images/numeros/diecisiete.png',
  'Numeros|diez': 'assets/images/numeros/diez.png',
  'Numeros|doce': 'assets/images/numeros/doce.png',
  'Numeros|dos': 'assets/images/numeros/dos.png',
  'Numeros|nueve': 'assets/images/numeros/nueve.png',
  'Numeros|ocho': 'assets/images/numeros/ocho.png',
  'Numeros|once': 'assets/images/numeros/once.png',
  'Numeros|quince': 'assets/images/numeros/quince.png',
  'Numeros|seis': 'assets/images/numeros/seis.png',
  'Numeros|siete': 'assets/images/numeros/siete.png',
  'Numeros|trece': 'assets/images/numeros/trece.png',
  'Numeros|tres': 'assets/images/numeros/tres.png',
  'Numeros|uno': 'assets/images/numeros/uno.png',
  'Numeros|veinte': 'assets/images/numeros/veinte.png',
  // Objetos
  'Objetos|almohada': 'assets/images/objetos/almohada.jpg',
  'Objetos|bano': 'assets/images/objetos/bano.png',
  'Objetos|cacerola': 'assets/images/objetos/cacerola.jpg',
  'Objetos|cama': 'assets/images/objetos/cama.jpg',
  'Objetos|camisa': 'assets/images/objetos/camisa.png',
  'Objetos|canasta': 'assets/images/objetos/canasta.png',
  'Objetos|casa': 'assets/images/objetos/casa.png',
  'Objetos|cocina': 'assets/images/objetos/cocina.png',
  'Objetos|cuchara': 'assets/images/objetos/cuchara.png',
  'Objetos|estufa': 'assets/images/objetos/estufa.jpg',
  'Objetos|falda': 'assets/images/objetos/falda.jpg',
  'Objetos|fregadero': 'assets/images/objetos/fregadero.jpg',
  'Objetos|habitacion': 'assets/images/objetos/habitacion.png',
  'Objetos|horno': 'assets/images/objetos/horno.jpg',
  'Objetos|huarache': 'assets/images/objetos/huarache.jpg',
  'Objetos|manta': 'assets/images/objetos/manta.jpg',
  'Objetos|mesa': 'assets/images/objetos/mesa.png',
  'Objetos|olla': 'assets/images/objetos/olla.jpg',
  'Objetos|pantalon': 'assets/images/objetos/pantalon.png',
  'Objetos|patio': 'assets/images/objetos/patio.png',
  'Objetos|plato': 'assets/images/objetos/plato.png',
  'Objetos|puerta': 'assets/images/objetos/puerta.png',
  'Objetos|ropero': 'assets/images/objetos/ropero.jpg',
  'Objetos|silla': 'assets/images/objetos/silla.jpg',
  'Objetos|sombrero': 'assets/images/objetos/sombrero.png',
  'Objetos|taza': 'assets/images/objetos/taza.png',
  'Objetos|vaso': 'assets/images/objetos/vaso.png',
  'Objetos|ventana': 'assets/images/objetos/ventana.png',
  'Objetos|vestido': 'assets/images/objetos/vestido.png',
  // PartesDelCuerpo
  'PartesDelCuerpo|boca': 'assets/images/partes_del_cuerpo/boca.png',
  'PartesDelCuerpo|brazo': 'assets/images/partes_del_cuerpo/brazo.png',
  'PartesDelCuerpo|cabello': 'assets/images/partes_del_cuerpo/cabello.png',
  'PartesDelCuerpo|cabeza': 'assets/images/partes_del_cuerpo/cabeza.png',
  'PartesDelCuerpo|cuello': 'assets/images/partes_del_cuerpo/cuello.png',
  'PartesDelCuerpo|dedos_mano': 'assets/images/partes_del_cuerpo/dedos_mano.png',
  'PartesDelCuerpo|dedos_pie': 'assets/images/partes_del_cuerpo/dedos_pie.png',
  'PartesDelCuerpo|dientes': 'assets/images/partes_del_cuerpo/dientes.png',
  'PartesDelCuerpo|espalda': 'assets/images/partes_del_cuerpo/espalda.png',
  'PartesDelCuerpo|frente': 'assets/images/partes_del_cuerpo/frente.png',
  'PartesDelCuerpo|garganta': 'assets/images/partes_del_cuerpo/garganta.png',
  'PartesDelCuerpo|lengua': 'assets/images/partes_del_cuerpo/lengua.png',
  'PartesDelCuerpo|mano': 'assets/images/partes_del_cuerpo/mano.png',
  'PartesDelCuerpo|nariz': 'assets/images/partes_del_cuerpo/nariz.png',
  'PartesDelCuerpo|ojo': 'assets/images/partes_del_cuerpo/ojo.png',
  'PartesDelCuerpo|oreja': 'assets/images/partes_del_cuerpo/oreja.png',
  // Sentimientos
  'Sentimientos|amor': 'assets/images/sentimientos/amor.png',
  'Sentimientos|bondad': 'assets/images/sentimientos/bondad.png',
  'Sentimientos|carino': 'assets/images/sentimientos/carino.png',
  'Sentimientos|compasion': 'assets/images/sentimientos/compasion.png',
  'Sentimientos|confianza': 'assets/images/sentimientos/confianza.png',
  'Sentimientos|dolor': 'assets/images/sentimientos/dolor.png',
  'Sentimientos|emocionado': 'assets/images/sentimientos/emocionado.png',
  'Sentimientos|enojo': 'assets/images/sentimientos/enojo.png',
  'Sentimientos|felicidad': 'assets/images/sentimientos/felicidad.png',
  'Sentimientos|gratitud': 'assets/images/sentimientos/gratitud.png',
  'Sentimientos|inseguridad': 'assets/images/sentimientos/inseguridad.png',
  'Sentimientos|miedo': 'assets/images/sentimientos/miedo.png',
  'Sentimientos|nostalgia': 'assets/images/sentimientos/nostalgia.png',
  'Sentimientos|odio': 'assets/images/sentimientos/odio.png',
  'Sentimientos|respeto': 'assets/images/sentimientos/respeto.png',
  'Sentimientos|satisfaccion': 'assets/images/sentimientos/satisfaccion.png',
  'Sentimientos|tristeza': 'assets/images/sentimientos/tristeza.png',
};

/// "Cuídate  mucho" -> "cuidate_mucho", "Baño" -> "bano", "¿Cómo estas?" ->
/// "como_estas".
String _normalizar(String texto) {
  const origen = 'áàäâéèëêíìïîóòöôúùüûñ';
  const destino = 'aaaaeeeeiiiioooouuuun';
  var r = texto.toLowerCase().trim();
  for (var i = 0; i < origen.length; i++) {
    r = r.replaceAll(origen[i], destino[i]);
  }
  r = r.replaceAll(RegExp(r'[^a-z0-9]+'), '_');
  return r.replaceAll(RegExp(r'^_+|_+$'), '');
}

/// Imagen y audio de [palabra], que pertenece a la categoría [categoriaKey]
/// (la misma clave de cursoPorCategoria, ej. "Familia", "PartesDelCuerpo").
MedioPalabra? medioDe(String categoriaKey, PalabraCurso palabra) {
  final normal = _normalizar(palabra.espanol);
  final nombre = _alias[normal] ?? normal;
  final clave = '$categoriaKey|$nombre';
  final imagen = _imagenes[clave];
  final audio = _audios[clave];
  if (imagen == null && audio == null) return null;
  return MedioPalabra(imagen: imagen, audio: audio);
}