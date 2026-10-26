// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_profile_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$UpdateProfileDtoCWProxy {
  UpdateProfileDto displayName(String? displayName);

  UpdateProfileDto timezone(String? timezone);

  UpdateProfileDto emergencyContact(EmergencyContactDto? emergencyContact);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateProfileDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateProfileDto(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateProfileDto call({
    String? displayName,
    String? timezone,
    EmergencyContactDto? emergencyContact,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfUpdateProfileDto.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfUpdateProfileDto.copyWith.fieldName(...)`
class _$UpdateProfileDtoCWProxyImpl implements _$UpdateProfileDtoCWProxy {
  const _$UpdateProfileDtoCWProxyImpl(this._value);

  final UpdateProfileDto _value;

  @override
  UpdateProfileDto displayName(String? displayName) =>
      this(displayName: displayName);

  @override
  UpdateProfileDto timezone(String? timezone) => this(timezone: timezone);

  @override
  UpdateProfileDto emergencyContact(EmergencyContactDto? emergencyContact) =>
      this(emergencyContact: emergencyContact);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `UpdateProfileDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// UpdateProfileDto(...).copyWith(id: 12, name: "My name")
  /// ````
  UpdateProfileDto call({
    Object? displayName = const $CopyWithPlaceholder(),
    Object? timezone = const $CopyWithPlaceholder(),
    Object? emergencyContact = const $CopyWithPlaceholder(),
  }) {
    return UpdateProfileDto(
      displayName: displayName == const $CopyWithPlaceholder()
          ? _value.displayName
          // ignore: cast_nullable_to_non_nullable
          : displayName as String?,
      timezone: timezone == const $CopyWithPlaceholder()
          ? _value.timezone
          // ignore: cast_nullable_to_non_nullable
          : timezone as String?,
      emergencyContact: emergencyContact == const $CopyWithPlaceholder()
          ? _value.emergencyContact
          // ignore: cast_nullable_to_non_nullable
          : emergencyContact as EmergencyContactDto?,
    );
  }
}

extension $UpdateProfileDtoCopyWith on UpdateProfileDto {
  /// Returns a callable class that can be used as follows: `instanceOfUpdateProfileDto.copyWith(...)` or like so:`instanceOfUpdateProfileDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$UpdateProfileDtoCWProxy get copyWith => _$UpdateProfileDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateProfileDto _$UpdateProfileDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('UpdateProfileDto', json, ($checkedConvert) {
      final val = UpdateProfileDto(
        displayName: $checkedConvert('displayName', (v) => v as String?),
        timezone: $checkedConvert('timezone', (v) => v as String?),
        emergencyContact: $checkedConvert(
          'emergencyContact',
          (v) => v == null
              ? null
              : EmergencyContactDto.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

Map<String, dynamic> _$UpdateProfileDtoToJson(UpdateProfileDto instance) =>
    <String, dynamic>{
      'displayName': ?instance.displayName,
      'timezone': ?instance.timezone,
      'emergencyContact': ?instance.emergencyContact?.toJson(),
    };
