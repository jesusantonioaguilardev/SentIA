// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consent_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Estado del consentimiento de la persona sobre los documentos vigentes.

@ProviderFor(MyConsents)
final myConsentsProvider = MyConsentsProvider._();

/// Estado del consentimiento de la persona sobre los documentos vigentes.
final class MyConsentsProvider
    extends $AsyncNotifierProvider<MyConsents, List<ConsentStatus>> {
  /// Estado del consentimiento de la persona sobre los documentos vigentes.
  MyConsentsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myConsentsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myConsentsHash();

  @$internal
  @override
  MyConsents create() => MyConsents();
}

String _$myConsentsHash() => r'85ee80c79098f71600548498f4de127c39afeeff';

/// Estado del consentimiento de la persona sobre los documentos vigentes.

abstract class _$MyConsents extends $AsyncNotifier<List<ConsentStatus>> {
  FutureOr<List<ConsentStatus>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<ConsentStatus>>, List<ConsentStatus>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<ConsentStatus>>, List<ConsentStatus>>,
              AsyncValue<List<ConsentStatus>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
