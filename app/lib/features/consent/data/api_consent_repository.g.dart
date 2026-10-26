// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_consent_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(consentRepository)
final consentRepositoryProvider = ConsentRepositoryProvider._();

final class ConsentRepositoryProvider
    extends
        $FunctionalProvider<
          ConsentRepository,
          ConsentRepository,
          ConsentRepository
        >
    with $Provider<ConsentRepository> {
  ConsentRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'consentRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$consentRepositoryHash();

  @$internal
  @override
  $ProviderElement<ConsentRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ConsentRepository create(Ref ref) {
    return consentRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ConsentRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ConsentRepository>(value),
    );
  }
}

String _$consentRepositoryHash() => r'd40cdb5953ffbf229cc67337d4500eb7c48911fc';
