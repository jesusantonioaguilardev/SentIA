// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ProfileDtoCWProxy {
  ProfileDto email(String email);

  ProfileDto birthYear(num birthYear);

  ProfileDto displayName(String? displayName);

  ProfileDto timezone(String timezone);

  ProfileDto emergencyContact(EmergencyContactDto? emergencyContact);

  ProfileDto createdAt(String createdAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ProfileDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ProfileDto(...).copyWith(id: 12, name: "My name")
  /// ````
  ProfileDto call({
    String email,
    num birthYear,
    String? displayName,
    String timezone,
    EmergencyContactDto? emergencyContact,
    String createdAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfProfileDto.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfProfileDto.copyWith.fieldName(...)`
class _$ProfileDtoCWProxyImpl implements _$ProfileDtoCWProxy {
  const _$ProfileDtoCWProxyImpl(this._value);

  final ProfileDto _value;

  @override
  ProfileDto email(String email) => this(email: email);

  @override
  ProfileDto birthYear(num birthYear) => this(birthYear: birthYear);

  @override
  ProfileDto displayName(String? displayName) => this(displayName: displayName);

  @override
  ProfileDto timezone(String timezone) => this(timezone: timezone);

  @override
  ProfileDto emergencyContact(EmergencyContactDto? emergencyContact) =>
      this(emergencyContact: emergencyContact);

  @override
  ProfileDto createdAt(String createdAt) => this(createdAt: createdAt);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ProfileDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ProfileDto(...).copyWith(id: 12, name: "My name")
  /// ````
  ProfileDto call({
    Object? email = const $CopyWithPlaceholder(),
    Object? birthYear = const $CopyWithPlaceholder(),
    Object? displayName = const $CopyWithPlaceholder(),
    Object? timezone = const $CopyWithPlaceholder(),
    Object? emergencyContact = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
  }) {
    return ProfileDto(
      email: email == const $CopyWithPlaceholder()
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String,
      birthYear: birthYear == const $CopyWithPlaceholder()
          ? _value.birthYear
          // ignore: cast_nullable_to_non_nullable
          : birthYear as num,
      displayName: displayName == const $CopyWithPlaceholder()
          ? _value.displayName
          // ignore: cast_nullable_to_non_nullable
          : displayName as String?,
      timezone: timezone == const $CopyWithPlaceholder()
          ? _value.timezone
          // ignore: cast_nullable_to_non_nullable
          : timezone as String,
      emergencyContact: emergencyContact == const $CopyWithPlaceholder()
          ? _value.emergencyContact
          // ignore: cast_nullable_to_non_nullable
          : emergencyContact as EmergencyContactDto?,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as String,
    );
  }
}

extension $ProfileDtoCopyWith on ProfileDto {
  /// Returns a callable class that can be used as follows: `instanceOfProfileDto.copyWith(...)` or like so:`instanceOfProfileDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ProfileDtoCWProxy get copyWith => _$ProfileDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileDto _$ProfileDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ProfileDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['email', 'birthYear', 'timezone', 'createdAt'],
      );
      final val = ProfileDto(
        email: $checkedConvert('email', (v) => v as String),
        birthYear: $checkedConvert('birthYear', (v) => v as num),
        displayName: $checkedConvert('displayName', (v) => v as String?),
        timezone: $checkedConvert('timezone', (v) => v as String),
        emergencyContact: $checkedConvert(
          'emergencyContact',
          (v) => v == null
              ? null
              : EmergencyContactDto.fromJson(v as Map<String, dynamic>),
        ),
        createdAt: $checkedConvert('createdAt', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$ProfileDtoToJson(ProfileDto instance) =>
    <String, dynamic>{
      'email': instance.email,
      'birthYear': instance.birthYear,
      'displayName': ?instance.displayName,
      'timezone': instance.timezone,
      'emergencyContact': ?instance.emergencyContact?.toJson(),
      'createdAt': instance.createdAt,
    };
