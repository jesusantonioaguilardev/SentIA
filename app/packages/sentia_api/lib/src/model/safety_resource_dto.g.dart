// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'safety_resource_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SafetyResourceDtoCWProxy {
  SafetyResourceDto name(String name);

  SafetyResourceDto description(String? description);

  SafetyResourceDto phone(String? phone);

  SafetyResourceDto sms(String? sms);

  SafetyResourceDto url(String? url);

  SafetyResourceDto hours(String? hours);

  SafetyResourceDto verifiedSourceUrl(String verifiedSourceUrl);

  SafetyResourceDto verifiedAt(String verifiedAt);

  SafetyResourceDto clinicalApproval(
    SafetyResourceDtoClinicalApprovalEnum clinicalApproval,
  );

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SafetyResourceDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SafetyResourceDto(...).copyWith(id: 12, name: "My name")
  /// ````
  SafetyResourceDto call({
    String name,
    String? description,
    String? phone,
    String? sms,
    String? url,
    String? hours,
    String verifiedSourceUrl,
    String verifiedAt,
    SafetyResourceDtoClinicalApprovalEnum clinicalApproval,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSafetyResourceDto.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSafetyResourceDto.copyWith.fieldName(...)`
class _$SafetyResourceDtoCWProxyImpl implements _$SafetyResourceDtoCWProxy {
  const _$SafetyResourceDtoCWProxyImpl(this._value);

  final SafetyResourceDto _value;

  @override
  SafetyResourceDto name(String name) => this(name: name);

  @override
  SafetyResourceDto description(String? description) =>
      this(description: description);

  @override
  SafetyResourceDto phone(String? phone) => this(phone: phone);

  @override
  SafetyResourceDto sms(String? sms) => this(sms: sms);

  @override
  SafetyResourceDto url(String? url) => this(url: url);

  @override
  SafetyResourceDto hours(String? hours) => this(hours: hours);

  @override
  SafetyResourceDto verifiedSourceUrl(String verifiedSourceUrl) =>
      this(verifiedSourceUrl: verifiedSourceUrl);

  @override
  SafetyResourceDto verifiedAt(String verifiedAt) =>
      this(verifiedAt: verifiedAt);

  @override
  SafetyResourceDto clinicalApproval(
    SafetyResourceDtoClinicalApprovalEnum clinicalApproval,
  ) => this(clinicalApproval: clinicalApproval);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SafetyResourceDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SafetyResourceDto(...).copyWith(id: 12, name: "My name")
  /// ````
  SafetyResourceDto call({
    Object? name = const $CopyWithPlaceholder(),
    Object? description = const $CopyWithPlaceholder(),
    Object? phone = const $CopyWithPlaceholder(),
    Object? sms = const $CopyWithPlaceholder(),
    Object? url = const $CopyWithPlaceholder(),
    Object? hours = const $CopyWithPlaceholder(),
    Object? verifiedSourceUrl = const $CopyWithPlaceholder(),
    Object? verifiedAt = const $CopyWithPlaceholder(),
    Object? clinicalApproval = const $CopyWithPlaceholder(),
  }) {
    return SafetyResourceDto(
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      description: description == const $CopyWithPlaceholder()
          ? _value.description
          // ignore: cast_nullable_to_non_nullable
          : description as String?,
      phone: phone == const $CopyWithPlaceholder()
          ? _value.phone
          // ignore: cast_nullable_to_non_nullable
          : phone as String?,
      sms: sms == const $CopyWithPlaceholder()
          ? _value.sms
          // ignore: cast_nullable_to_non_nullable
          : sms as String?,
      url: url == const $CopyWithPlaceholder()
          ? _value.url
          // ignore: cast_nullable_to_non_nullable
          : url as String?,
      hours: hours == const $CopyWithPlaceholder()
          ? _value.hours
          // ignore: cast_nullable_to_non_nullable
          : hours as String?,
      verifiedSourceUrl: verifiedSourceUrl == const $CopyWithPlaceholder()
          ? _value.verifiedSourceUrl
          // ignore: cast_nullable_to_non_nullable
          : verifiedSourceUrl as String,
      verifiedAt: verifiedAt == const $CopyWithPlaceholder()
          ? _value.verifiedAt
          // ignore: cast_nullable_to_non_nullable
          : verifiedAt as String,
      clinicalApproval: clinicalApproval == const $CopyWithPlaceholder()
          ? _value.clinicalApproval
          // ignore: cast_nullable_to_non_nullable
          : clinicalApproval as SafetyResourceDtoClinicalApprovalEnum,
    );
  }
}

extension $SafetyResourceDtoCopyWith on SafetyResourceDto {
  /// Returns a callable class that can be used as follows: `instanceOfSafetyResourceDto.copyWith(...)` or like so:`instanceOfSafetyResourceDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SafetyResourceDtoCWProxy get copyWith =>
      _$SafetyResourceDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SafetyResourceDto _$SafetyResourceDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SafetyResourceDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'name',
          'verifiedSourceUrl',
          'verifiedAt',
          'clinicalApproval',
        ],
      );
      final val = SafetyResourceDto(
        name: $checkedConvert('name', (v) => v as String),
        description: $checkedConvert('description', (v) => v as String?),
        phone: $checkedConvert('phone', (v) => v as String?),
        sms: $checkedConvert('sms', (v) => v as String?),
        url: $checkedConvert('url', (v) => v as String?),
        hours: $checkedConvert('hours', (v) => v as String?),
        verifiedSourceUrl: $checkedConvert(
          'verifiedSourceUrl',
          (v) => v as String,
        ),
        verifiedAt: $checkedConvert('verifiedAt', (v) => v as String),
        clinicalApproval: $checkedConvert(
          'clinicalApproval',
          (v) => $enumDecode(_$SafetyResourceDtoClinicalApprovalEnumEnumMap, v),
        ),
      );
      return val;
    });

Map<String, dynamic> _$SafetyResourceDtoToJson(SafetyResourceDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': ?instance.description,
      'phone': ?instance.phone,
      'sms': ?instance.sms,
      'url': ?instance.url,
      'hours': ?instance.hours,
      'verifiedSourceUrl': instance.verifiedSourceUrl,
      'verifiedAt': instance.verifiedAt,
      'clinicalApproval':
          _$SafetyResourceDtoClinicalApprovalEnumEnumMap[instance
              .clinicalApproval]!,
    };

const _$SafetyResourceDtoClinicalApprovalEnumEnumMap = {
  SafetyResourceDtoClinicalApprovalEnum.pending: 'pending',
  SafetyResourceDtoClinicalApprovalEnum.approved: 'approved',
};
