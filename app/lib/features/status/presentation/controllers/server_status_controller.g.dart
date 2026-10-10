// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_status_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ServerStatusController)
final serverStatusControllerProvider = ServerStatusControllerProvider._();

final class ServerStatusControllerProvider
    extends $AsyncNotifierProvider<ServerStatusController, ServerStatus> {
  ServerStatusControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'serverStatusControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$serverStatusControllerHash();

  @$internal
  @override
  ServerStatusController create() => ServerStatusController();
}

String _$serverStatusControllerHash() =>
    r'98016136d8adcdfc1fc80fbf8fc2597b23c75b35';

abstract class _$ServerStatusController extends $AsyncNotifier<ServerStatus> {
  FutureOr<ServerStatus> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ServerStatus>, ServerStatus>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ServerStatus>, ServerStatus>,
              AsyncValue<ServerStatus>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
