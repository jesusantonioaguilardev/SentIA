// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_account_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$DeleteAccountDtoCWProxy {
  DeleteAccountDto password(String password);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DeleteAccountDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DeleteAccountDto(...).copyWith(id: 12, name: "My name")
  /// ````
  DeleteAccountDto call({String password});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfDeleteAccountDto.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfDeleteAccountDto.copyWith.fieldName(...)`
class _$DeleteAccountDtoCWProxyImpl implements _$DeleteAccountDtoCWProxy {
  const _$DeleteAccountDtoCWProxyImpl(this._value);

  final DeleteAccountDto _value;

  @override
  DeleteAccountDto password(String password) => this(password: password);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `DeleteAccountDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// DeleteAccountDto(...).copyWith(id: 12, name: "My name")
  /// ````
  DeleteAccountDto call({Object? password = const $CopyWithPlaceholder()}) {
    return DeleteAccountDto(
      password: password == const $CopyWithPlaceholder()
          ? _value.password
          // ignore: cast_nullable_to_non_nullable
          : password as String,
    );
  }
}

extension $DeleteAccountDtoCopyWith on DeleteAccountDto {
  /// Returns a callable class that can be used as follows: `instanceOfDeleteAccountDto.copyWith(...)` or like so:`instanceOfDeleteAccountDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$DeleteAccountDtoCWProxy get copyWith => _$DeleteAccountDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteAccountDto _$DeleteAccountDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('DeleteAccountDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['password']);
      final val = DeleteAccountDto(
        password: $checkedConvert('password', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$DeleteAccountDtoToJson(DeleteAccountDto instance) =>
    <String, dynamic>{'password': instance.password};
