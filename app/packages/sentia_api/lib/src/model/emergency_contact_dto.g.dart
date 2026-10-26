// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emergency_contact_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$EmergencyContactDtoCWProxy {
  EmergencyContactDto name(String name);

  EmergencyContactDto phone(String phone);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `EmergencyContactDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// EmergencyContactDto(...).copyWith(id: 12, name: "My name")
  /// ````
  EmergencyContactDto call({String name, String phone});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfEmergencyContactDto.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfEmergencyContactDto.copyWith.fieldName(...)`
class _$EmergencyContactDtoCWProxyImpl implements _$EmergencyContactDtoCWProxy {
  const _$EmergencyContactDtoCWProxyImpl(this._value);

  final EmergencyContactDto _value;

  @override
  EmergencyContactDto name(String name) => this(name: name);

  @override
  EmergencyContactDto phone(String phone) => this(phone: phone);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `EmergencyContactDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// EmergencyContactDto(...).copyWith(id: 12, name: "My name")
  /// ````
  EmergencyContactDto call({
    Object? name = const $CopyWithPlaceholder(),
    Object? phone = const $CopyWithPlaceholder(),
  }) {
    return EmergencyContactDto(
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      phone: phone == const $CopyWithPlaceholder()
          ? _value.phone
          // ignore: cast_nullable_to_non_nullable
          : phone as String,
    );
  }
}

extension $EmergencyContactDtoCopyWith on EmergencyContactDto {
  /// Returns a callable class that can be used as follows: `instanceOfEmergencyContactDto.copyWith(...)` or like so:`instanceOfEmergencyContactDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$EmergencyContactDtoCWProxy get copyWith =>
      _$EmergencyContactDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmergencyContactDto _$EmergencyContactDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('EmergencyContactDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['name', 'phone']);
      final val = EmergencyContactDto(
        name: $checkedConvert('name', (v) => v as String),
        phone: $checkedConvert('phone', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$EmergencyContactDtoToJson(
  EmergencyContactDto instance,
) => <String, dynamic>{'name': instance.name, 'phone': instance.phone};
