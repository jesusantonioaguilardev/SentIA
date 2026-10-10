/// Detector de señales de riesgo — RED DE SEGURIDAD INTERINA DEL LADO DEL
/// CLIENTE, no un reemplazo del motor de reglas del backend.
///
/// Esto existe porque hoy `AIService` sigue siendo un mock/cliente directo,
/// así que sin esto no habría ninguna respuesta especial ante una señal de
/// riesgo. En cuanto exista el backend real (Fase 3 del roadmap), la
/// detección definitiva debe vivir ahí — con más contexto, mejor precisión,
/// y sin depender de una lista de palabras que el usuario puede rodear
/// fácilmente. No borres esto al conectar el backend real: úsalo como
/// segunda capa de seguridad, no lo dejes como la única.
///
/// La lista es intencionalmente conservadora (prefiere falsos positivos a
/// falsos negativos) y solo cubre español. Revísala con un profesional de
/// salud mental antes de producción — yo no soy quién para calibrar esto
/// clínicamente.
bool containsRiskSignal(String text) {
  final normalized = text.toLowerCase();
  const signals = [
    'quiero morir',
    'no quiero vivir',
    'quiero desaparecer',
    'ya no puedo más',
    'no vale la pena vivir',
    'quitarme la vida',
    'hacerme daño',
    'lastimarme',
    'no aguanto más',
    'quiero acabar con todo',
  ];
  return signals.any(normalized.contains);
}
