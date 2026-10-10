import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sentia2/core/routing/routes.dart';
import 'package:sentia2/features/mood/domain/entities/mood_entry.dart';
import 'package:sentia2/features/mood/presentation/controllers/mood_controller.dart';
import 'package:sentia2/features/mood/presentation/mood_type_style.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const new({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  MoodType? _selectedMood;

  void _registerMood() {
    if (_selectedMood == null) return;

    ref.read(moodEntriesProvider.notifier).addMood(_selectedMood!);

    final label = _selectedMood?.label;
    setState(() => _selectedMood = null);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Estado "$label" registrado correctamente.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _goToChat() {
    context.go(Routes.chat);
  }

  void _openActivity(String name) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('"$name" estará disponible próximamente.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 12,
            bottom: 140,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _CustomAppBar(),
              const SizedBox(height: 24),
              Text(
                'Hola, Antonio',
                style: theme.textTheme.headlineLarge?.copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                  fontSize: 30,
                  letterSpacing: -0.015,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Tómate un respiro. Este momento es solo tuyo.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 32),

              // Mood Tracker Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.onSurface.withValues(alpha: 0.03),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '¿Cómo te sientes hoy?',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Elige la emoción que mejor te describe.',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontSize: 13,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 20),

                    _buildMoodGrid(),

                    const SizedBox(height: 12),

                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _selectedMood != null ? _registerMood : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          disabledBackgroundColor: colorScheme.primary
                              .withValues(alpha: 0.3),
                          shape: const StadiumBorder(),
                          elevation: 0,
                        ),
                        child: Text(
                          _selectedMood != null
                              ? '✓ Registrar: ${_selectedMood!.label}'
                              : 'Selecciona una emoción',
                          style: TextStyle(
                            color: _selectedMood != null
                                ? colorScheme.onPrimary
                                : colorScheme.onSurface.withValues(alpha: 0.5),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              _ChatCtaCard(onTalkPressed: _goToChat),

              const SizedBox(height: 32),
              Text(
                'Tu bienestar de hoy',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 16),
              _ActivityCard(
                icon: Icons.air,
                iconColor: colorScheme.primary,
                title: 'Respiración 4-7-8',
                subtitle: 'Guía de calma para bajar el ritmo',
                onTap: () => _openActivity('Respiración 4-7-8'),
              ),
              const SizedBox(height: 12),
              _ActivityCard(
                icon: Icons.wb_sunny_outlined,
                iconColor: colorScheme.secondary,
                title: 'Reflexión consciente',
                subtitle: 'Pausa matutina de gratitud',
                onTap: () => _openActivity('Reflexión consciente'),
              ),
              const SizedBox(height: 12),
              _ActivityCard(
                icon: Icons.edit_note,
                iconColor: colorScheme.tertiary,
                title: 'Diario emocional',
                subtitle: 'Escribe tus pensamientos sin filtros',
                onTap: () => _openActivity('Diario emocional'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMoodGrid() {
    const moods = MoodType.values;
    return Column(
      children: [
        Row(
          children: [
            _buildMoodTileExpanded(moods[0]),
            const SizedBox(width: 8),
            _buildMoodTileExpanded(moods[1]),
            const SizedBox(width: 8),
            _buildMoodTileExpanded(moods[2]),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            _buildMoodTileExpanded(moods[3]),
            const SizedBox(width: 8),
            _buildMoodTileExpanded(moods[4]),
            const SizedBox(width: 8),
            _buildMoodTileExpanded(moods[5]),
          ],
        ),
      ],
    );
  }

  Widget _buildMoodTileExpanded(MoodType type) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: _MoodTile(
          type: type,
          isSelected: _selectedMood == type,
          onTap: (t) => setState(() => _selectedMood = t),
        ),
      ),
    );
  }
}

class _MoodTile extends StatelessWidget {
  const new({
    required this.type,
    required this.isSelected,
    required this.onTap,
  });
  final MoodType type;
  final bool isSelected;
  final ValueChanged<MoodType> onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: () => onTap(type),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              color: isSelected
                  ? type.backgroundColor
                  : colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected
                    ? type.color
                    : colorScheme.onSurface.withValues(alpha: 0.08),
                width: 1.5,
              ),
            ),
            child: Icon(
              type.icon,
              color: isSelected ? type.color : colorScheme.onSurfaceVariant,
              size: 24,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            type.label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.labelSmall?.copyWith(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected
                  ? colorScheme.onSurface
                  : colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  const new();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Icons.water_drop,
              color: colorScheme.primaryContainer,
              size: 24,
            ),
            const SizedBox(width: 8),
            Text(
              'SentIA',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
          ],
        ),
        CircleAvatar(
          radius: 18,
          backgroundColor: colorScheme.secondaryContainer,
          child: Text(
            'A',
            style: TextStyle(
              color: colorScheme.onSecondaryContainer,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class _ChatCtaCard extends StatelessWidget {
  const new({required this.onTalkPressed});
  final VoidCallback onTalkPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colorScheme.secondaryContainer.withValues(
          alpha: theme.brightness == Brightness.dark ? 0.2 : 0.4,
        ),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '¿Quieres hablar con alguien?',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSecondaryContainer,
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: onTalkPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.secondary,
              foregroundColor: colorScheme.onSecondary,
              shape: const StadiumBorder(),
            ),
            child: const Text('Hablar ahora'),
          ),
        ],
      ),
    );
  }
}

class _ActivityCard extends StatelessWidget {
  const new({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: colorScheme.onSurface.withValues(alpha: 0.05),
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: iconColor.withValues(alpha: 0.1),
              child: Icon(icon, color: iconColor),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: colorScheme.onSurfaceVariant),
          ],
        ),
      ),
    );
  }
}
