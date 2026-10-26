// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_form_controllers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LoginForm)
final loginFormProvider = LoginFormProvider._();

final class LoginFormProvider
    extends $NotifierProvider<LoginForm, AsyncValue<void>> {
  LoginFormProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'loginFormProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$loginFormHash();

  @$internal
  @override
  LoginForm create() => LoginForm();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<void> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<void>>(value),
    );
  }
}

String _$loginFormHash() => r'c79e9ee48bbb2df4d6aca2d9fe26377ff68006de';

abstract class _$LoginForm extends $Notifier<AsyncValue<void>> {
  AsyncValue<void> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, AsyncValue<void>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, AsyncValue<void>>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(SignupForm)
final signupFormProvider = SignupFormProvider._();

final class SignupFormProvider
    extends $NotifierProvider<SignupForm, AsyncValue<void>> {
  SignupFormProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'signupFormProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$signupFormHash();

  @$internal
  @override
  SignupForm create() => SignupForm();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<void> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<void>>(value),
    );
  }
}

String _$signupFormHash() => r'd908f8dba391f523448319cd02f3b12c2e39ac08';

abstract class _$SignupForm extends $Notifier<AsyncValue<void>> {
  AsyncValue<void> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, AsyncValue<void>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, AsyncValue<void>>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(ForgotPasswordForm)
final forgotPasswordFormProvider = ForgotPasswordFormProvider._();

final class ForgotPasswordFormProvider
    extends $NotifierProvider<ForgotPasswordForm, AsyncValue<void>> {
  ForgotPasswordFormProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'forgotPasswordFormProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$forgotPasswordFormHash();

  @$internal
  @override
  ForgotPasswordForm create() => ForgotPasswordForm();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<void> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<void>>(value),
    );
  }
}

String _$forgotPasswordFormHash() =>
    r'eb3ba47e23d7db51cc68c8a22fd31060b34ae98d';

abstract class _$ForgotPasswordForm extends $Notifier<AsyncValue<void>> {
  AsyncValue<void> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, AsyncValue<void>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, AsyncValue<void>>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
