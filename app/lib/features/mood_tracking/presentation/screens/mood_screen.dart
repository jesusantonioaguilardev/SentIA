import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sentia2/domain/entities/mood_entry.dart';
import 'package:sentia2/features/mood_tracking/presentation/providers/mood_provider.dart';

class MoodScreen extends ConsumerStatefulWidget {
  const MoodScreen({super.key});

  @override
  ConsumerState<MoodScreen> createState() => _MoodScreenState();
}

class _MoodScreenState extends ConsumerState<MoodScreen> {
  final TextEditingController _noteController = TextEditingController();
  MoodType? _selectedMood;

  void _saveMood() {
    if (_selectedMood != null) {
      // Nombre corregido: moodEntriesProvider
      ref.read(moodEntriesProvider.notifier).addMood(
            _selectedMood!,
            note: _noteController.text.trim().isEmpty ? null : _noteController.text.trim(),
          );
      _noteController.clear();
      setState(() => _selectedMood = null);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Estado de ánimo guardado correctamente')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final moodHistory = ref.watch(moodEntriesProvider);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: const Text('Registro Emocional'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '¿Cómo te sientes en este momento?',
              style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            
            // Cuadrícula 2x3 con iconos reales
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: MoodType.values.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 2.2,
              ),
              itemBuilder: (context, index) {
                final type = MoodType.values[index];
                final isSelected = _selectedMood == type;
                return GestureDetector(
                  onTap: () => setState(() => _selectedMood = type),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      color: isSelected ? type.backgroundColor : theme.colorScheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? type.color : Colors.transparent,
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(type.icon, color: isSelected ? type.color : theme.colorScheme.outline, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          type.label,
                          style: TextStyle(
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected ? theme.colorScheme.onSurface : theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 24),
            TextField(
              controller: _noteController,
              decoration: const InputDecoration(
                hintText: 'Añade una nota sobre tu estado...',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selectedMood != null ? _saveMood : null,
                child: const Text('Guardar Bienestar'),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              'Historial Reciente',
              style: theme.textTheme.headlineSmall?.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: moodHistory.length,
              itemBuilder: (context, index) {
                final entry = moodHistory[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: Icon(entry.mood.icon, color: entry.mood.color),
                    title: Text(entry.mood.label.toUpperCase()),
                    subtitle: Text(DateFormat('dd MMM, hh:mm a').format(entry.timestamp)),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
