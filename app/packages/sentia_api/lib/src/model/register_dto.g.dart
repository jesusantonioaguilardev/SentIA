// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RegisterDtoCWProxy {
  RegisterDto email(String email);

  RegisterDto password(String password);

  RegisterDto birthYear(num birthYear);

  RegisterDto ageConfirmed(bool ageConfirmed);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RegisterDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RegisterDto(...).copyWith(id: 12, name: "My name")
  /// ````
  RegisterDto call({
    String email,
    String password,
    num birthYear,
    bool ageConfirmed,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRegisterDto.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRegisterDto.copyWith.fieldName(...)`
class _$RegisterDtoCWProxyImpl implements _$RegisterDtoCWProxy {
  const _$RegisterDtoCWProxyImpl(this._value);

  final RegisterDto _value;

  @override
  RegisterDto email(String email) => this(email: email);

  @override
  RegisterDto password(String password) => this(password: password);

  @override
  RegisterDto birthYear(num birthYear) => this(birthYear: birthYear);

  @override
  RegisterDto ageConfirmed(bool ageConfirmed) =>
      this(ageConfirmed: ageConfirmed);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RegisterDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RegisterDto(...).copyWith(id: 12, name: "My name")
  /// ````
  RegisterDto call({
    Object? email = const $CopyWithPlaceholder(),
    Object? password = const $CopyWithPlaceholder(),
    Object? birthYear = const $CopyWithPlaceholder(),
    Object? ageConfirmed = const $CopyWithPlaceholder(),
  }) {
    return RegisterDto(
      email: email == const $CopyWithPlaceholder()
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String,
      password: password == const $CopyWithPlaceholder()
          ? _value.password
          // ignore: cast_nullable_to_non_nullable
          : password as String,
      birthYear: birthYear == const $CopyWithPlaceholder()
          ? _value.birthYear
          // ignore: cast_nullable_to_non_nullable
          : birthYear as num,
      ageConfirmed: ageConfirmed == const $CopyWithPlaceholder()
          ? _value.ageConfirmed
          // ignore: cast_nullable_to_non_nullable
          : ageConfirmed as bool,
    );
  }
}

extension $RegisterDtoCopyWith on RegisterDto {
  /// Returns a callable class that can be used as follows: `instanceOfRegisterDto.copyWith(...)` or like so:`instanceOfRegisterDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RegisterDtoCWProxy get copyWith => _$RegisterDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterDto _$RegisterDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('RegisterDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['email', 'password', 'birthYear', 'ageConfirmed'],
      );
      final val = RegisterDto(
        email: $checkedConvert('email', (v) => v as String),
        password: $checkedConvert('password', (v) => v as String),
        birthYear: $checkedConvert('birthYear', (v) => v as num),
        ageConfirmed: $checkedConvert('ageConfirmed', (v) => v as bool),
      );
      return val;
    });

Map<String, dynamic> _$RegisterDtoToJson(RegisterDto instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'birthYear': instance.birthYear,
      'ageConfirmed': instance.ageConfirmed,
    };
