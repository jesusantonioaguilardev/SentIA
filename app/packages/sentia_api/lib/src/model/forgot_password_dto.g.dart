// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_password_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ForgotPasswordDtoCWProxy {
  ForgotPasswordDto email(String email);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ForgotPasswordDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ForgotPasswordDto(...).copyWith(id: 12, name: "My name")
  /// ````
  ForgotPasswordDto call({String email});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfForgotPasswordDto.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfForgotPasswordDto.copyWith.fieldName(...)`
class _$ForgotPasswordDtoCWProxyImpl implements _$ForgotPasswordDtoCWProxy {
  const _$ForgotPasswordDtoCWProxyImpl(this._value);

  final ForgotPasswordDto _value;

  @override
  ForgotPasswordDto email(String email) => this(email: email);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ForgotPasswordDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ForgotPasswordDto(...).copyWith(id: 12, name: "My name")
  /// ````
  ForgotPasswordDto call({Object? email = const $CopyWithPlaceholder()}) {
    return ForgotPasswordDto(
      email: email == const $CopyWithPlaceholder()
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String,
    );
  }
}

extension $ForgotPasswordDtoCopyWith on ForgotPasswordDto {
  /// Returns a callable class that can be used as follows: `instanceOfForgotPasswordDto.copyWith(...)` or like so:`instanceOfForgotPasswordDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ForgotPasswordDtoCWProxy get copyWith =>
      _$ForgotPasswordDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgotPasswordDto _$ForgotPasswordDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ForgotPasswordDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['email']);
      final val = ForgotPasswordDto(
        email: $checkedConvert('email', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$ForgotPasswordDtoToJson(ForgotPasswordDto instance) =>
    <String, dynamic>{'email': instance.email};
