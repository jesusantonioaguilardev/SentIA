// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_deletion_request_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AccountDeletionRequestDtoCWProxy {
  AccountDeletionRequestDto email(String email);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AccountDeletionRequestDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AccountDeletionRequestDto(...).copyWith(id: 12, name: "My name")
  /// ````
  AccountDeletionRequestDto call({String email});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAccountDeletionRequestDto.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAccountDeletionRequestDto.copyWith.fieldName(...)`
class _$AccountDeletionRequestDtoCWProxyImpl
    implements _$AccountDeletionRequestDtoCWProxy {
  const _$AccountDeletionRequestDtoCWProxyImpl(this._value);

  final AccountDeletionRequestDto _value;

  @override
  AccountDeletionRequestDto email(String email) => this(email: email);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AccountDeletionRequestDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AccountDeletionRequestDto(...).copyWith(id: 12, name: "My name")
  /// ````
  AccountDeletionRequestDto call({
    Object? email = const $CopyWithPlaceholder(),
  }) {
    return AccountDeletionRequestDto(
      email: email == const $CopyWithPlaceholder()
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String,
    );
  }
}

extension $AccountDeletionRequestDtoCopyWith on AccountDeletionRequestDto {
  /// Returns a callable class that can be used as follows: `instanceOfAccountDeletionRequestDto.copyWith(...)` or like so:`instanceOfAccountDeletionRequestDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AccountDeletionRequestDtoCWProxy get copyWith =>
      _$AccountDeletionRequestDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountDeletionRequestDto _$AccountDeletionRequestDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AccountDeletionRequestDto', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['email']);
  final val = AccountDeletionRequestDto(
    email: $checkedConvert('email', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$AccountDeletionRequestDtoToJson(
  AccountDeletionRequestDto instance,
) => <String, dynamic>{'email': instance.email};
