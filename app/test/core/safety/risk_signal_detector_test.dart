import 'package:flutter_test/flutter_test.dart';
import 'package:sentia2/core/safety/risk_signal_detector.dart';

// Fija el comportamiento actual de la red local (zona protegida, docs/08).
// No es la suite clínica de crisis: esa vive en el backend (Etapa 2).
void main() {
  test('detecta frases de la lista sin importar mayúsculas', () {
    expect(containsRiskSignal('Ya no puedo más con esto'), isTrue);
    expect(containsRiskSignal('A veces QUIERO DESAPARECER'), isTrue);
  });

  test('no marca mensajes sin señales', () {
    expect(containsRiskSignal('Hoy fue un buen día'), isFalse);
  });
}
