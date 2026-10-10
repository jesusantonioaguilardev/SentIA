import 'dart:async';

import 'package:sentia2/features/chat/data/services/ai_service.dart';

class MockAIService implements AIService {
  @override
  Future<String> getResponse(String prompt) async {
    await Future<void>.delayed(const Duration(seconds: 1));

    final lowerPrompt = prompt.toLowerCase();
    if (lowerPrompt.contains('triste') || lowerPrompt.contains('mal')) {
      return 'Siento mucho que te sientas así. Estoy aquí para escucharte. '
          '¿Quieres contarme qué pasó o prefieres que hagamos un breve '
          'ejercicio de respiración?';
    } else if (lowerPrompt.contains('ansioso') ||
        lowerPrompt.contains('ansiedad')) {
      return 'La ansiedad puede ser abrumadora, pero recuerda que estás a '
          'salvo. Vamos a inhalar en 4 tiempos... mantener... y exhalar. Estoy '
          'contigo.';
    } else if (lowerPrompt.contains('hola')) {
      return '¡Hola! Soy SentIA2, tu asistente de bienestar emocional. '
          '¿Cómo te encuentras el día de hoy?';
    }

    return 'Te escucho con atención. Todo lo que compartas aquí es un espacio '
        'seguro. Cuéntame más sobre esa emoción.';
  }

  @override
  Stream<String> getResponseStream(String prompt) async* {
    final response = await getResponse(prompt);
    final words = response.split(' ');
    for (final word in words) {
      await Future<void>.delayed(const Duration(milliseconds: 150));
      yield '$word ';
    }
  }
}
