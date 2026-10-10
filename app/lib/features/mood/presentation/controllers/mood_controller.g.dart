// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mood_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MoodEntries)
final moodEntriesProvider = MoodEntriesProvider._();

final class MoodEntriesProvider
    extends $NotifierProvider<MoodEntries, List<MoodEntry>> {
  MoodEntriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'moodEntriesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$moodEntriesHash();

  @$internal
  @override
  MoodEntries create() => MoodEntries();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<MoodEntry> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<MoodEntry>>(value),
    );
  }
}

String _$moodEntriesHash() => r'578e6dde12b010e46ea597ac66674f6a31047e76';

abstract class _$MoodEntries extends $Notifier<List<MoodEntry>> {
  List<MoodEntry> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<List<MoodEntry>, List<MoodEntry>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<MoodEntry>, List<MoodEntry>>,
              List<MoodEntry>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
