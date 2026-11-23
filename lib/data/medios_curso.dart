import 'curso_data.dart';

/// Imagen y audio de cada palabra del curso. Todo viene del servidor de Oliver:
///
/// IMÁGENES: {_baseImagenes}<carpeta>/<nombre>.png (algunas son .jpg).
/// El nombre sale del texto en español de la palabra, sin acentos ni signos
/// ("Cuídate mucho" -> cuidate_mucho). Las que se llaman distinto están en
/// [_alias].
///
/// AUDIOS: URLs tomadas de Lista_Audios_Tanextli.pdf, en [_audios].
/// Sin audio todavía: Bondad, Emocionado, Inseguridad (Sentimientos),
/// Eres feo/a (Frases) y Garganta (Partes del cuerpo).
class MedioPalabra {
  final String? imagen;
  final String? audio;

  const MedioPalabra({this.imagen, this.audio});
}

const String _baseImagenes =
    'https://olo.tail0de9ec.ts.net/galeria-imagenes/imagenes/';

const String _baseAudios =
    'https://olo.tail0de9ec.ts.net/multimedia/AudiosTanextli/Tanextli/';

/// Carpeta de imágenes en el servidor para cada categoría de curso_data.dart.
const Map<String, String> _carpetas = {
  'Animales': 'animales',
  'Colores': 'colores',
  'Familia': 'familia',
  'Frases': 'frases',
  'Numeros': 'numeros',
  'Objetos': 'objetos',
  'PartesDelCuerpo': 'partes_del_cuerpo',
  'Sentimientos': 'sentimientos',
};

/// Imágenes que en el servidor son .jpg (todas las demás son .png).
const Set<String> _jpg = {
  'cacomixtle', 'almohada', 'cacerola', 'cama', 'estufa', 'falda',
  'fregadero', 'horno', 'huarache', 'manta', 'olla', 'ropero', 'silla',
};

/// Palabras cuyo nombre de archivo no coincide con su texto en español.
const Map<String, String> _alias = {
  'madre': 'mama',
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

/// Clave 'Categoria|nombre' -> URL del audio.
const Map<String, String> _audios = {
  // Animales
  'Animales|aguila': '${_baseAudios}Animales/Aves%20y%20reptiles/Aguila.m4a',
  'Animales|ardilla': '${_baseAudios}Animales/Animales%20silvestres/Ardilla.m4a',
  'Animales|buho': '${_baseAudios}Animales/Aves%20y%20reptiles/Buho.m4a',
  'Animales|cacomixtle': '${_baseAudios}Animales/Animales%20silvestres/Cacomixtle.m4a',
  'Animales|cerdo': '${_baseAudios}Animales/Animales%20de%20granja/Cerdo.m4a',
  'Animales|colibri': '${_baseAudios}Animales/Aves%20y%20reptiles/Colibr%C3%AD.m4a',
  'Animales|conejo': '${_baseAudios}Animales/Animales%20dom%C3%A9sticos/Conejo.m4a',
  'Animales|coyote': '${_baseAudios}Animales/Animales%20silvestres/Coyote.m4a',
  'Animales|gallina': '${_baseAudios}Animales/Animales%20de%20granja/Gallina.m4a',
  'Animales|gallo': '${_baseAudios}Animales/Animales%20de%20granja/Gallo.m4a',
  'Animales|gato': '${_baseAudios}Animales/Animales%20dom%C3%A9sticos/Gato.m4a',
  'Animales|lagartija': '${_baseAudios}Animales/Aves%20y%20reptiles/Lagartija.m4a',
  'Animales|mapache': '${_baseAudios}Animales/Animales%20silvestres/Mapache.m4a',
  'Animales|oveja': '${_baseAudios}Animales/Animales%20de%20granja/Oveja.m4a',
  'Animales|pajaro': '${_baseAudios}Animales/Aves%20y%20reptiles/P%C3%A1jaro.m4a',
  'Animales|pato': '${_baseAudios}Animales/Animales%20de%20granja/Pato.m4a',
  'Animales|pavo': '${_baseAudios}Animales/Animales%20de%20granja/Guajolote.m4a',
  'Animales|perro': '${_baseAudios}Animales/Animales%20dom%C3%A9sticos/Perro.m4a',
  'Animales|serpiente': '${_baseAudios}Animales/Aves%20y%20reptiles/Serpiente.m4a',
  'Animales|tlacuache': '${_baseAudios}Animales/Animales%20silvestres/Tlacuache.m4a',
  'Animales|tortuga': '${_baseAudios}Animales/Aves%20y%20reptiles/Tortuga.m4a',
  'Animales|venado': '${_baseAudios}Animales/Animales%20silvestres/Venado.m4a',
  'Animales|zorro': '${_baseAudios}Animales/Animales%20silvestres/Zorro.m4a',
  // Colores
  'Colores|amarillo': '${_baseAudios}Colores/Colores%20b%C3%A1sicos/Amarillo.m4a',
  'Colores|blanco': '${_baseAudios}Colores/Colores%20b%C3%A1sicos/Blanco.m4a',
  'Colores|cafe': '${_baseAudios}Colores/Colores%20secundarios/Caf%C3%A9.m4a',
  'Colores|gris': '${_baseAudios}Colores/Colores%20secundarios/Gris.m4a',
  'Colores|morado': '${_baseAudios}Colores/Colores%20secundarios/Morado.m4a',
  'Colores|naranja': '${_baseAudios}Colores/Colores%20secundarios/Anaranjado.m4a',
  'Colores|negro': '${_baseAudios}Colores/Colores%20b%C3%A1sicos/Negro.m4a',
  'Colores|rojo': '${_baseAudios}Colores/Colores%20b%C3%A1sicos/Rojo.m4a',
  'Colores|rosa': '${_baseAudios}Colores/Colores%20secundarios/Rosa.m4a',
  'Colores|verde': '${_baseAudios}Colores/Colores%20b%C3%A1sicos/Verde.m4a',
  // Familia
  'Familia|abuela': '${_baseAudios}Familia/Familia%20extendida/Abuela.m4a',
  'Familia|abuelo': '${_baseAudios}Familia/Familia%20extendida/Abuelo.m4a',
  'Familia|bebe': '${_baseAudios}Familia/Personas/Beb%C3%A9.m4a',
  'Familia|cunada': '${_baseAudios}Familia/M%C3%A1s%20familiares/Cu%C3%B1ada.m4a',
  'Familia|cunado': '${_baseAudios}Familia/M%C3%A1s%20familiares/Cu%C3%B1ado.m4a',
  'Familia|familia': '${_baseAudios}Familia/Familia%20Principal/Familia.m4a',
  'Familia|hermana': '${_baseAudios}Familia/Familia%20Principal/Hermana.m4a',
  'Familia|hermano': '${_baseAudios}Familia/Familia%20Principal/Hermano.m4a',
  'Familia|hombre': '${_baseAudios}Familia/Personas/Hombre.m4a',
  'Familia|joven': '${_baseAudios}Familia/Personas/Joven.m4a',
  'Familia|mama': '${_baseAudios}Familia/Familia%20Principal/Mam%C3%A1.m4a',
  'Familia|mujer': '${_baseAudios}Familia/Personas/Mujer.m4a',
  'Familia|nieta': '${_baseAudios}Familia/M%C3%A1s%20familiares/Nieta.m4a',
  'Familia|nieto': '${_baseAudios}Familia/M%C3%A1s%20familiares/Nieto.m4a',
  'Familia|nina': '${_baseAudios}Familia/Personas/Ni%C3%B1a.m4a',
  'Familia|nino': '${_baseAudios}Familia/Personas/Ni%C3%B1o.m4a',
  'Familia|padre': '${_baseAudios}Familia/Familia%20Principal/Pap%C3%A1.m4a',
  'Familia|prima': '${_baseAudios}Familia/Familia%20extendida/Prima.m4a',
  'Familia|primo': '${_baseAudios}Familia/Familia%20extendida/Primo.m4a',
  'Familia|senor': '${_baseAudios}Familia/Personas/Se%C3%B1or.m4a',
  'Familia|senora': '${_baseAudios}Familia/Personas/Se%C3%B1ora.m4a',
  'Familia|sobrina': '${_baseAudios}Familia/M%C3%A1s%20familiares/Sobrina.m4a',
  'Familia|sobrino': '${_baseAudios}Familia/M%C3%A1s%20familiares/Sobrino.m4a',
  'Familia|suegra': '${_baseAudios}Familia/M%C3%A1s%20familiares/Suegra.m4a',
  'Familia|suegro': '${_baseAudios}Familia/M%C3%A1s%20familiares/Suegro.m4a',
  'Familia|tia': '${_baseAudios}Familia/Familia%20extendida/T%C3%ADa.m4a',
  'Familia|tio': '${_baseAudios}Familia/Familia%20extendida/T%C3%ADo%20(hermano%20de%20pap%C3%A1).m4a',
  'Familia|vieja': '${_baseAudios}Familia/Personas/Vieja.m4a',
  'Familia|viejo': '${_baseAudios}Familia/Personas/Viejo.m4a',
  // Frases
  'Frases|buenas_noches': '${_baseAudios}Frases%20comunes/Saludos/Buenas%20noches.m4a',
  'Frases|buenas_tardes': '${_baseAudios}Frases%20comunes/Saludos/Buenas%20tardes.m4a',
  'Frases|buenos_dias': '${_baseAudios}Frases%20comunes/Saludos/Buenos%20d%C3%ADas.m4a',
  'Frases|como_esta_tu_familia': '${_baseAudios}Frases%20comunes/Conversaci%C3%B3n/Como%20esta%20tu%20familia.m4a',
  'Frases|como_estas': '${_baseAudios}Frases%20comunes/Conversaci%C3%B3n/C%C3%B3mo%20est%C3%A1s.m4a',
  'Frases|como_te_llamas': '${_baseAudios}Frases%20comunes/Conversaci%C3%B3n/C%C3%B3mo%20te%20llamas.m4a',
  'Frases|cuanto_cuesta': '${_baseAudios}Frases%20comunes/Expresiones/Cuanto%20cuesta.m4a',
  'Frases|cuidate_mucho': '${_baseAudios}Frases%20comunes/Despedida/Cu%C3%ADdate%20mucho.m4a',
  'Frases|de_acuerdo': '${_baseAudios}Frases%20comunes/Expresiones/De%20acuerdo.m4a',
  'Frases|de_donde_eres': '${_baseAudios}Frases%20comunes/Conversaci%C3%B3n/De%20donde%20eres.m4a',
  'Frases|de_nada': '${_baseAudios}Frases%20comunes/Conversaci%C3%B3n/De%20nada.m4a',
  'Frases|eres_guapo': '${_baseAudios}Frases%20comunes/Expresiones/Eres%20guapo.m4a',
  'Frases|es_dificil': '${_baseAudios}Frases%20comunes/Expresiones/Es%20dif%C3%ADcil.m4a',
  'Frases|es_facil': '${_baseAudios}Frases%20comunes/Expresiones/Es%20f%C3%A1cil.m4a',
  'Frases|estas_bonita': '${_baseAudios}Frases%20comunes/Expresiones/Estas%20bonita.m4a',
  'Frases|estoy_bien': '${_baseAudios}Frases%20comunes/Conversaci%C3%B3n/Estoy%20bien.m4a',
  'Frases|gracias': '${_baseAudios}Frases%20comunes/Saludos/Gracias.m4a',
  'Frases|guarda_silencio': '${_baseAudios}Frases%20comunes/Expresiones/Guarda%20silencio.m4a',
  'Frases|hasta_luego': '${_baseAudios}Frases%20comunes/Expresiones/Hasta%20luego.m4a',
  'Frases|hola': '${_baseAudios}Hola.m4a',
  'Frases|mi_nombre_es': '${_baseAudios}Frases%20comunes/Expresiones/Mi%20nombre%20es.m4a',
  'Frases|mucho': '${_baseAudios}Frases%20comunes/Expresiones/Mucho.m4a',
  'Frases|mucho_gusto': '${_baseAudios}Frases%20comunes/Expresiones/Mucho%20gusto.m4a',
  'Frases|nada': '${_baseAudios}Frases%20comunes/Expresiones/Nada.m4a',
  'Frases|no': '${_baseAudios}Frases%20comunes/Expresiones/No.m4a',
  'Frases|no_me_gusta': '${_baseAudios}Frases%20comunes/Expresiones/No%20me%20gusta.m4a',
  'Frases|no_puedo': '${_baseAudios}Frases%20comunes/Expresiones/No%20puedo.m4a',
  'Frases|no_quiero': '${_baseAudios}Frases%20comunes/Expresiones/No%20quiero.m4a',
  'Frases|no_se': '${_baseAudios}Frases%20comunes/Expresiones/No%20s%C3%A9.m4a',
  'Frases|no_tengo': '${_baseAudios}Frases%20comunes/Expresiones/No%20tengo.m4a',
  'Frases|poco': '${_baseAudios}Frases%20comunes/Expresiones/Poco.m4a',
  'Frases|que_descanses': '${_baseAudios}Frases%20comunes/Despedida/Qu%C3%A9%20descanses.m4a',
  'Frases|que_dios_te_bendiga': '${_baseAudios}Frases%20comunes/Despedida/Que%20dios%20te%20bendiga.m4a',
  'Frases|que_necesitas': '${_baseAudios}Frases%20comunes/Expresiones/Qu%C3%A9%20necesitas.m4a',
  'Frases|que_te_vaya_bien': '${_baseAudios}Frases%20comunes/Despedida/Que%20te%20vaya%20bien.m4a',
  'Frases|que_tengas_un_buen_dia': '${_baseAudios}Frases%20comunes/Despedida/Qu%C3%A9%20tengas%20un%20buen%20d%C3%ADa.m4a',
  'Frases|quiero_comer': '${_baseAudios}Frases%20comunes/Expresiones/Quiero%20comer.m4a',
  'Frases|si': '${_baseAudios}Frases%20comunes/Expresiones/Si.m4a',
  'Frases|si_me_gusta': '${_baseAudios}Frases%20comunes/Expresiones/Si%20me%20gusta.m4a',
  'Frases|si_puedo': '${_baseAudios}Frases%20comunes/Expresiones/Si%20puedo.m4a',
  'Frases|si_quiero': '${_baseAudios}Frases%20comunes/Expresiones/Si%20quiero.m4a',
  'Frases|si_se': '${_baseAudios}Frases%20comunes/Expresiones/Si%20s%C3%A9.m4a',
  'Frases|si_tengo': '${_baseAudios}Frases%20comunes/Expresiones/Si%20tengo.m4a',
  'Frases|te_quiero': '${_baseAudios}Frases%20comunes/Expresiones/Te%20quiero.m4a',
  'Frases|tengo_hambre': '${_baseAudios}Frases%20comunes/Expresiones/Tengo%20hambre.m4a',
  'Frases|ya_llegue': '${_baseAudios}Frases%20comunes/Expresiones/Ya%20llegue.m4a',
  // Numeros
  'Numeros|catorce': '${_baseAudios}N%C3%BAmeros/Del%2011-15/14.m4a',
  'Numeros|cinco': '${_baseAudios}N%C3%BAmeros/Del%201-5/5.m4a',
  'Numeros|cuatro': '${_baseAudios}N%C3%BAmeros/Del%201-5/4.m4a',
  'Numeros|diecinueve': '${_baseAudios}N%C3%BAmeros/Del%2016-20/19.m4a',
  'Numeros|dieciocho': '${_baseAudios}N%C3%BAmeros/Del%2016-20/18.m4a',
  'Numeros|dieciseis': '${_baseAudios}N%C3%BAmeros/Del%2016-20/16.m4a',
  'Numeros|diecisiete': '${_baseAudios}N%C3%BAmeros/Del%2016-20/17.m4a',
  'Numeros|diez': '${_baseAudios}N%C3%BAmeros/Del%206-10/10.m4a',
  'Numeros|doce': '${_baseAudios}N%C3%BAmeros/Del%2011-15/12.m4a',
  'Numeros|dos': '${_baseAudios}N%C3%BAmeros/Del%201-5/2.m4a',
  'Numeros|nueve': '${_baseAudios}N%C3%BAmeros/Del%206-10/9.m4a',
  'Numeros|ocho': '${_baseAudios}N%C3%BAmeros/Del%206-10/8.m4a',
  'Numeros|once': '${_baseAudios}N%C3%BAmeros/Del%2011-15/11.m4a',
  'Numeros|quince': '${_baseAudios}N%C3%BAmeros/Del%2011-15/15.m4a',
  'Numeros|seis': '${_baseAudios}N%C3%BAmeros/Del%206-10/6.m4a',
  'Numeros|siete': '${_baseAudios}N%C3%BAmeros/Del%206-10/7.m4a',
  'Numeros|trece': '${_baseAudios}N%C3%BAmeros/Del%2011-15/13.m4a',
  'Numeros|tres': '${_baseAudios}N%C3%BAmeros/Del%201-5/3.m4a',
  'Numeros|uno': '${_baseAudios}N%C3%BAmeros/Del%201-5/1.m4a',
  'Numeros|veinte': '${_baseAudios}N%C3%BAmeros/Del%2016-20/20.m4a',
  // Objetos
  'Objetos|almohada': '${_baseAudios}Objetos/Objetos%20diversos/Almohada.m4a',
  'Objetos|bano': '${_baseAudios}Objetos/Hogar/Ba%C3%B1o.m4a',
  'Objetos|cacerola': '${_baseAudios}Objetos/Cocina/Caserola.m4a',
  'Objetos|cama': '${_baseAudios}Objetos/Objetos%20de%20casa/Cama.m4a',
  'Objetos|camisa': '${_baseAudios}Objetos/Objetos%20diversos/Camiza.m4a',
  'Objetos|canasta': '${_baseAudios}Objetos/Objetos%20diversos/Canasta.m4a',
  'Objetos|casa': '${_baseAudios}Objetos/Hogar/Casa.m4a',
  'Objetos|cocina': '${_baseAudios}Objetos/Hogar/Cocina.m4a',
  'Objetos|cuchara': '${_baseAudios}Objetos/Cocina/Cuchara.m4a',
  'Objetos|estufa': '${_baseAudios}Objetos/Cocina/Estufa.m4a',
  'Objetos|falda': '${_baseAudios}Objetos/Objetos%20diversos/Falda.m4a',
  'Objetos|fregadero': '${_baseAudios}Objetos/Cocina/Fregadero.m4a',
  'Objetos|habitacion': '${_baseAudios}Objetos/Hogar/Habitaci%C3%B3n.m4a',
  'Objetos|horno': '${_baseAudios}Objetos/Cocina/Horno.m4a',
  'Objetos|huarache': '${_baseAudios}Objetos/Objetos%20diversos/Huarache.m4a',
  'Objetos|manta': '${_baseAudios}Objetos/Objetos%20diversos/Manta.m4a',
  'Objetos|mesa': '${_baseAudios}Objetos/Objetos%20de%20casa/Mesa.m4a',
  'Objetos|olla': '${_baseAudios}Objetos/Cocina/Olla.m4a',
  'Objetos|pantalon': '${_baseAudios}Objetos/Objetos%20diversos/Pantal%C3%B3n.m4a',
  'Objetos|patio': '${_baseAudios}Objetos/Hogar/Patio.m4a',
  'Objetos|plato': '${_baseAudios}Objetos/Cocina/Plato.m4a',
  'Objetos|puerta': '${_baseAudios}Objetos/Objetos%20de%20casa/Puerta.m4a',
  'Objetos|ropero': '${_baseAudios}Objetos/Objetos%20de%20casa/Ropero.m4a',
  'Objetos|silla': '${_baseAudios}Objetos/Objetos%20de%20casa/Silla.m4a',
  'Objetos|sombrero': '${_baseAudios}Objetos/Objetos%20diversos/Sombrero.m4a',
  'Objetos|taza': '${_baseAudios}Objetos/Cocina/Taza.m4a',
  'Objetos|vaso': '${_baseAudios}Objetos/Cocina/Vaso.m4a',
  'Objetos|ventana': '${_baseAudios}Objetos/Objetos%20de%20casa/Ventana.m4a',
  'Objetos|vestido': '${_baseAudios}Objetos/Objetos%20diversos/Vestido.m4a',
  // PartesDelCuerpo
  'PartesDelCuerpo|boca': '${_baseAudios}Partes%20del%20cuerpo/Rostro/Boca.m4a',
  'PartesDelCuerpo|brazo': '${_baseAudios}Partes%20del%20cuerpo/Extremidades%20del%20cuerpo/Brazo.m4a',
  'PartesDelCuerpo|cabello': '${_baseAudios}Partes%20del%20cuerpo/Rostro/Cabello.m4a',
  'PartesDelCuerpo|cabeza': '${_baseAudios}Partes%20del%20cuerpo/Rostro/Cabeza.m4a',
  'PartesDelCuerpo|cuello': '${_baseAudios}Partes%20del%20cuerpo/Extremidades%20del%20cuerpo/Cuello.m4a',
  'PartesDelCuerpo|dedos_mano': '${_baseAudios}Partes%20del%20cuerpo/Extremidades%20del%20cuerpo/Dedos%20de%20la%20mano.m4a',
  'PartesDelCuerpo|dedos_pie': '${_baseAudios}Partes%20del%20cuerpo/Extremidades%20del%20cuerpo/Dedos%20del%20pie.m4a',
  'PartesDelCuerpo|dientes': '${_baseAudios}Partes%20del%20cuerpo/Rostro/Dientes.m4a',
  'PartesDelCuerpo|espalda': '${_baseAudios}Partes%20del%20cuerpo/Extremidades%20del%20cuerpo/Espalda.m4a',
  'PartesDelCuerpo|frente': '${_baseAudios}Partes%20del%20cuerpo/Rostro/Frente.m4a',
  'PartesDelCuerpo|lengua': '${_baseAudios}Partes%20del%20cuerpo/Rostro/Lengua.m4a',
  'PartesDelCuerpo|mano': '${_baseAudios}Partes%20del%20cuerpo/Extremidades%20del%20cuerpo/Mano.m4a',
  'PartesDelCuerpo|nariz': '${_baseAudios}Partes%20del%20cuerpo/Rostro/Nariz.m4a',
  'PartesDelCuerpo|ojo': '${_baseAudios}Partes%20del%20cuerpo/Rostro/Ojo.m4a',
  'PartesDelCuerpo|oreja': '${_baseAudios}Partes%20del%20cuerpo/Rostro/Oreja.m4a',
  // Sentimientos
  'Sentimientos|amor': '${_baseAudios}Sentimientos/Sentimientos%20positivos/Amor.m4a',
  'Sentimientos|carino': '${_baseAudios}Sentimientos/Valores%20y%20emociones/Cari%C3%B1o.m4a',
  'Sentimientos|compasion': '${_baseAudios}Sentimientos/Valores%20y%20emociones/Compasi%C3%B3n.m4a',
  'Sentimientos|confianza': '${_baseAudios}Sentimientos/Valores%20y%20emociones/Confianza.m4a',
  'Sentimientos|dolor': '${_baseAudios}Sentimientos/Sentimientos%20dif%C3%ADciles/Dolor.m4a',
  'Sentimientos|enojo': '${_baseAudios}Sentimientos/Emociones%20intensas/Enojo.m4a',
  'Sentimientos|felicidad': '${_baseAudios}Sentimientos/Sentimientos%20positivos/Felicidad.m4a',
  'Sentimientos|gratitud': '${_baseAudios}Sentimientos/Valores%20y%20emociones/Gratitud.m4a',
  'Sentimientos|miedo': '${_baseAudios}Sentimientos/Sentimientos%20dif%C3%ADciles/Miedo.m4a',
  'Sentimientos|nostalgia': '${_baseAudios}Sentimientos/Emociones%20intensas/Nostalgia.m4a',
  'Sentimientos|odio': '${_baseAudios}Sentimientos/Emociones%20intensas/Odio.m4a',
  'Sentimientos|respeto': '${_baseAudios}Sentimientos/Valores%20y%20emociones/Respeto.m4a',
  'Sentimientos|satisfaccion': '${_baseAudios}Sentimientos/Emociones%20intensas/Satisfacci%C3%B3n.m4a',
  'Sentimientos|tristeza': '${_baseAudios}Sentimientos/Sentimientos%20dif%C3%ADciles/Tristeza.m4a',
};

/// "Cuídate  mucho" -> "cuidate_mucho", "Baño" -> "bano", "¿Cómo estás?" ->
/// "como_estas".
String normalizarTexto(String texto) {
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
  final carpeta = _carpetas[categoriaKey];
  if (carpeta == null) return null;

  final normal = normalizarTexto(palabra.espanol);
  final nombre = _alias[normal] ?? normal;
  final extension = _jpg.contains(nombre) ? 'jpg' : 'png';

  return MedioPalabra(
    imagen: '$_baseImagenes$carpeta/$nombre.$extension',
    audio: _audios['$categoriaKey|$nombre'],
  );
}