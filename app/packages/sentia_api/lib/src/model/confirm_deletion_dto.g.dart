// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_deletion_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ConfirmDeletionDtoCWProxy {
  ConfirmDeletionDto token(String token);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ConfirmDeletionDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ConfirmDeletionDto(...).copyWith(id: 12, name: "My name")
  /// ````
  ConfirmDeletionDto call({String token});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfConfirmDeletionDto.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfConfirmDeletionDto.copyWith.fieldName(...)`
class _$ConfirmDeletionDtoCWProxyImpl implements _$ConfirmDeletionDtoCWProxy {
  const _$ConfirmDeletionDtoCWProxyImpl(this._value);

  final ConfirmDeletionDto _value;

  @override
  ConfirmDeletionDto token(String token) => this(token: token);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ConfirmDeletionDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ConfirmDeletionDto(...).copyWith(id: 12, name: "My name")
  /// ````
  ConfirmDeletionDto call({Object? token = const $CopyWithPlaceholder()}) {
    return ConfirmDeletionDto(
      token: token == const $CopyWithPlaceholder()
          ? _value.token
          // ignore: cast_nullable_to_non_nullable
          : token as String,
    );
  }
}

extension $ConfirmDeletionDtoCopyWith on ConfirmDeletionDto {
  /// Returns a callable class that can be used as follows: `instanceOfConfirmDeletionDto.copyWith(...)` or like so:`instanceOfConfirmDeletionDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ConfirmDeletionDtoCWProxy get copyWith =>
      _$ConfirmDeletionDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfirmDeletionDto _$ConfirmDeletionDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ConfirmDeletionDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['token']);
      final val = ConfirmDeletionDto(
        token: $checkedConvert('token', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$ConfirmDeletionDtoToJson(ConfirmDeletionDto instance) =>
    <String, dynamic>{'token': instance.token};
