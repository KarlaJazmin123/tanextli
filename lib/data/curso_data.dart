/// Contenido del curso (palabras y subcategorías) tomado de
/// Palabras_Tanextl_v2_nahualt.xlsx. Cada subcategoría es una lección.
///
/// TODO: cuando Oliver tenga /api/categorias/:id/palabras, estos datos
/// pueden venir del servidor; la pantalla solo necesita esta misma forma.

class PalabraCurso {
  final String espanol;
  final String nahuatl;

  const PalabraCurso(this.espanol, this.nahuatl);
}

class SubcategoriaCurso {
  final String nombre;
  final List<PalabraCurso> palabras;

  const SubcategoriaCurso(this.nombre, this.palabras);

  int get totalPalabras => palabras.length;
}

/// La clave coincide con `key` de las categorías en home_screen.dart.
const Map<String, List<SubcategoriaCurso>> cursoPorCategoria = {
  "Familia": [
    SubcategoriaCurso("Familia", [
      PalabraCurso("Familia", "Cenchan"),
      PalabraCurso("Padre", "Papan"),
      PalabraCurso("Madre", "Maman"),
      PalabraCurso("Hermano", "Noikniuj"),
      PalabraCurso("Hermana", "Noikniuj"),
    ]),
    SubcategoriaCurso("Familia extendida", [
      PalabraCurso("Abuelo", "Tatatsin"),
      PalabraCurso("Abuela", "Nanatsin"),
      PalabraCurso("Tío", "Noikniuj papan"),
      PalabraCurso("Tía", "Noikniuj maman"),
      PalabraCurso("Primo", "Nomajichniuj"),
    ]),
    SubcategoriaCurso("Más familiares", [
      PalabraCurso("Prima", "Nomajichniuj"),
      PalabraCurso("suegra", "Monnantsin"),
      PalabraCurso("Nieto", "Noixuiuj"),
      PalabraCurso("suegro", "Motatsin"),
      PalabraCurso("Nieta", "Noiuiuj"),
      PalabraCurso("cuañada", "Noikniuj ni cihuat"),
      PalabraCurso("Sobrino", "Nokonemaj"),
      PalabraCurso("cuañado", "Noikniuj ni tagat"),
      PalabraCurso("Sobrina", "Nokonemaj"),
    ]),
    SubcategoriaCurso("Personas", [
      PalabraCurso("Niño", "Okichpil"),
      PalabraCurso("Mujer", "Lamat"),
      PalabraCurso("Niña", "Suapil"),
      PalabraCurso("Bebé", "Pili"),
      PalabraCurso("Señor", "Tagat"),
      PalabraCurso("Viejo", "Vevetsin"),
      PalabraCurso("Señora", "Cihuatsin"),
      PalabraCurso("Vieja", "Nanatsin"),
      PalabraCurso("Hombre", "Wuehuet"),
      PalabraCurso("Joven", "Telpoch"),
    ]),
  ],
  "Sentimientos": [
    SubcategoriaCurso("Sentimientos positivos", [
      PalabraCurso("Amor", "Tlasojtlalis"),
      PalabraCurso("Felicidad", "Yolpahpaki"),
      PalabraCurso("Bondad", "Kualiyolotl"),
      PalabraCurso("Emocionado", "Yolpaktok"),
    ]),
    SubcategoriaCurso("Valores y emociones", [
      PalabraCurso("Compasión", "Taikneli"),
      PalabraCurso("Respeto", "Mahwiztilia"),
      PalabraCurso("Gratitud", "Tlasojkamatilis"),
      PalabraCurso("Confianza", "Tlaneltokayot"),
      PalabraCurso("Cariño", "Tlazohkayot"),
    ]),
    SubcategoriaCurso("Sentimientos difíciles", [
      PalabraCurso("Tristeza", "Amo yolpahpaki"),
      PalabraCurso("Dolor", "Kokoua"),
      PalabraCurso("Miedo", "Mauik"),
      PalabraCurso("Inseguridad", "Amo yolchikaualis"),
    ]),
    SubcategoriaCurso("Emociones intensas", [
      PalabraCurso("Enojo", "Kualantli"),
      PalabraCurso("Nostalgia", "Elnamikisli"),
      PalabraCurso("Odio", "Tlajuelitalis"),
      PalabraCurso("Satisfacción", "Yolpaki"),
    ]),
  ],
  "Colores": [
    SubcategoriaCurso("Colores básicos", [
      PalabraCurso("Rojo", "Chichiltik"),
      PalabraCurso("Blanco", "Istak"),
      PalabraCurso("Verde", "Xoxoktik"),
      PalabraCurso("Negro", "Tiltik"),
      PalabraCurso("Amarillo", "Kostik"),
    ]),
    SubcategoriaCurso("Colores secundarios", [
      PalabraCurso("Naranja", "Chilkostik"),
      PalabraCurso("Morado", "Kaniojtik"),
      PalabraCurso("Rosa", "Xochipaltik"),
      PalabraCurso("Gris", "Tenextik"),
      PalabraCurso("Café", "Tilkostik"),
    ]),
  ],
  "Numeros": [
    SubcategoriaCurso("Del 1 al 5", [
      PalabraCurso("1", "Se"),
      PalabraCurso("2", "Ome"),
      PalabraCurso("3", "Eyi"),
      PalabraCurso("4", "Nahui"),
      PalabraCurso("5", "Makuil"),
    ]),
    SubcategoriaCurso("Del 6 al 10", [
      PalabraCurso("6", "Chikuase"),
      PalabraCurso("7", "Chikame"),
      PalabraCurso("8", "Chikeyi"),
      PalabraCurso("9", "Chiknahui"),
      PalabraCurso("10", "Mahtlaktli"),
    ]),
    SubcategoriaCurso("Del 11 al 15", [
      PalabraCurso("11", "Mahtlaktli ihwan se"),
      PalabraCurso("12", "Mahtlaktli ihwan ome"),
      PalabraCurso("13", "Mahtlaktli ihwan eyi"),
      PalabraCurso("14", "Mahtlaktli ihwan nahui"),
      PalabraCurso("15", "Kaxtolli"),
    ]),
    SubcategoriaCurso("Del 16 al 20", [
      PalabraCurso("16", "Kaxtolli ihwan se"),
      PalabraCurso("17", "Kaxtolli ihwan ome"),
      PalabraCurso("18", "Kaxtolli ihwan eyi"),
      PalabraCurso("19", "Kaxtolli ihwan nahui"),
      PalabraCurso("20", "Sempowalli"),
    ]),
  ],
  "Frases": [
    SubcategoriaCurso("Saludos", [
      PalabraCurso("Hola", "Piali"),
      PalabraCurso("Buenos dias", "Kwali Tanecik"),
      PalabraCurso("Buenas tardes", "Kwali Tiotaki"),
      PalabraCurso("Buenas noches", "Kwali Tapoyaui"),
      PalabraCurso("Gracias", "Tlasohkamatik"),
      PalabraCurso("¿Cómo esta tu familia?", "¿Keni yetokemo chinikniuan?"),
    ]),
    SubcategoriaCurso("Conversación", [
      PalabraCurso("¿Cómo te llamas?", "¿Keni motokay"),
      PalabraCurso("¿Cómo estas?", "¿Keni tietok?"),
      PalabraCurso("¿De dónde eres?", "¿Kani tiwala?"),
      PalabraCurso("De nada", "Amo tlen"),
      PalabraCurso("Estoy bien", "Kwali nica nietok"),
      PalabraCurso("Qué necesitas", "¿Toni tikneki?"),
    ]),
    SubcategoriaCurso("Despedidas", [
      PalabraCurso("Que tengas un buen dia", "Ma kwali tonal tikpia"),
      PalabraCurso("Qué te vaya bien", "Ma kwali tioj"),
      PalabraCurso("Cuídate  mucho", "Ixmopiali miak"),
      PalabraCurso("Que descanses", "Ma tiyo Isewi"),
      PalabraCurso("Qué dios te bendiga", "Ma Toteotsin mitz piali"),
    ]),
    SubcategoriaCurso("Expresiones", [
      PalabraCurso("Mi nombre es", "Notokay"),
      PalabraCurso("Si", "Kema"),
      PalabraCurso("Mucho Gusto", "Packi noyolo"),
      PalabraCurso("No tengo", "Amo nikpia"),
      PalabraCurso("Si tengo", "Kema nik pia"),
      PalabraCurso("Te quiero", "Nimitztlazohtla"),
      PalabraCurso("No", "Amo"),
      PalabraCurso("Tengo Hambre", "Nimayana"),
      PalabraCurso("No quiero", "Amo nikneki"),
      PalabraCurso("Si quiero", "Kema nik neki"),
      PalabraCurso("Hasta Luego", "Ma tiakan"),
      PalabraCurso("Mucho", "Miak"),
      PalabraCurso("quiero comer", "Nitakauas neki"),
      PalabraCurso("No puedo", "Amo ni wueli"),
      PalabraCurso("Si puedo", "Kema nik wueli"),
      PalabraCurso("Poco", "Litsin"),
      PalabraCurso("Cuanto cuesta", "Kanachi"),
      PalabraCurso("No me Gusta", "Amo ni kuelita"),
      PalabraCurso("Si me gusta", "Kema nik kuelita"),
      PalabraCurso("De acuerdo", "Kuali"),
      PalabraCurso("Nada", "Amo teyi"),
      PalabraCurso("Guarda silencio", "Ximotencaua"),
      PalabraCurso("Es dificil", "Owhui"),
      PalabraCurso("Es facil", "Amo owhuiyo"),
      PalabraCurso("Estas bonita", "Ti kuacualtsin"),
      PalabraCurso("Eres guapo", "Ti okichpil kuacualtsin"),
      PalabraCurso("No se", "Amo nikmati"),
      PalabraCurso("Si se", "Kema nik mati"),
      PalabraCurso("Eres Feo/a", "amo"),
      PalabraCurso("Ya llegue", "Niejokia"),
    ]),
  ],
  "Animales": [
    SubcategoriaCurso("Animales domésticos", [
      PalabraCurso("Perro", "Itzcuintli"),
      PalabraCurso("Gato", "Mixton"),
      PalabraCurso("Conejo", "Tochtli"),
    ]),
    SubcategoriaCurso("Animales de granja", [
      PalabraCurso("Gallina", "Piolamat"),
      PalabraCurso("Gallo", "Kashtil"),
      PalabraCurso("Pavo", "Wewejcho"),
      PalabraCurso("Cerdo", "Pitsot"),
      PalabraCurso("Oveja", "Ichkal"),
      PalabraCurso("Pato", "Apiok"),
    ]),
    SubcategoriaCurso("Animales silvestres", [
      PalabraCurso("Venado", "Masat"),
      PalabraCurso("Coyote", "Coyotl"),
      PalabraCurso("Zorro", "Kuekti"),
      PalabraCurso("Ardilla", "Chechelot"),
      PalabraCurso("Mapache", "Mapach"),
      PalabraCurso("Cacomixtle", "Tlacomiztli"),
      PalabraCurso("Tlacuache", "Tlacuatsin"),
    ]),
    SubcategoriaCurso("Aves y reptiles", [
      PalabraCurso("Aguila", "Tzopilot"),
      PalabraCurso("Colibrí", "Witsikitzin"),
      PalabraCurso("Buho", "Tekolot"),
      PalabraCurso("Serpiente", "Kowat"),
      PalabraCurso("Tortuga", "Ayotl"),
      PalabraCurso("Pajaro", "Tototl"),
      PalabraCurso("Lagartija", "Pehpetz"),
    ]),
  ],
  "Objetos": [
    SubcategoriaCurso("Hogar y casa", [
      PalabraCurso("Casa", "Kalit"),
      PalabraCurso("Patio", "Kalixpan"),
      PalabraCurso("Cocina", "Tlacualchihualoyan"),
      PalabraCurso("Baño", "Axixkalli"),
      PalabraCurso("Cuarto/habitación", "Kalkochi"),
    ]),
    SubcategoriaCurso("Objetos de casa", [
      PalabraCurso("Mesa", "Tlaixpan"),
      PalabraCurso("Silla", "Tokotzoualis"),
      PalabraCurso("Cama", "Tlapechtli"),
      PalabraCurso("Puerta", "Tlatsakua kalit"),
      PalabraCurso("Ventana", "Tlachialoyan"),
      PalabraCurso("Ropero", "Pia tasal"),
    ]),
    SubcategoriaCurso("Objetos diversos", [
      PalabraCurso("canasta/Bolsa", "Chikiwitl"),
      PalabraCurso("Huarache", "Wuarachi"),
      PalabraCurso("Vestido", "Kwewitl"),
      PalabraCurso("Almohada", "Tzonpechtli"),
      PalabraCurso("Manta/Cobija", "Ayat"),
      PalabraCurso("pantalon", "Kaltzon"),
      PalabraCurso("Camisa", "Koton"),
      PalabraCurso("Falda", "Kueitl"),
      PalabraCurso("Sombrero", "Ekawilotl"),
    ]),
    SubcategoriaCurso("Cocina", [
      PalabraCurso("Plato", "Caxitl"),
      PalabraCurso("Vaso", "Acaxit"),
      PalabraCurso("Caserola", "Caxilt"),
      PalabraCurso("Olla", "Komitl"),
      PalabraCurso("Cuchara", "Tlamawiloni"),
      PalabraCurso("Estufa", "Tekol tepoz"),
      PalabraCurso("Fegadero", "Pahpacho caxitl"),
      PalabraCurso("Horno", "Tlekalli"),
      PalabraCurso("Taza", "Akomit"),
    ]),
  ],
  "PartesDelCuerpo": [
    SubcategoriaCurso("Cabeza y rostro", [
      PalabraCurso("Cabeza", "Tsontekon"),
      PalabraCurso("Cabello", "Tsontli"),
      PalabraCurso("Frente", "Ixco"),
      PalabraCurso("Ojo", "Ixtololo"),
      PalabraCurso("Oreja", "Nacaztli"),
      PalabraCurso("Nariz", "Yecatzol"),
      PalabraCurso("Boca", "Camak"),
      PalabraCurso("Dientes", "Tlanwan"),
      PalabraCurso("Lengua", "Nenepil"),
    ]),
    SubcategoriaCurso("Cuerpo y extremidades", [
      PalabraCurso("Cuello", "Quechtli"),
      PalabraCurso("Garganta", "Toskak"),
      PalabraCurso("Brazo", "Acol"),
      PalabraCurso("Espalda", "Elpan"),
      PalabraCurso("Mano", "Maco"),
      PalabraCurso("Dedos de la mano", "Mahpiluan"),
      PalabraCurso("Dedos del pie", "Icxipiliuan"),
    ]),
  ],
};