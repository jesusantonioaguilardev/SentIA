// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record_consent_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RecordConsentDtoCWProxy {
  RecordConsentDto documentId(String documentId);

  RecordConsentDto granted(bool granted);

  RecordConsentDto appVersion(String? appVersion);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RecordConsentDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RecordConsentDto(...).copyWith(id: 12, name: "My name")
  /// ````
  RecordConsentDto call({String documentId, bool granted, String? appVersion});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRecordConsentDto.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRecordConsentDto.copyWith.fieldName(...)`
class _$RecordConsentDtoCWProxyImpl implements _$RecordConsentDtoCWProxy {
  const _$RecordConsentDtoCWProxyImpl(this._value);

  final RecordConsentDto _value;

  @override
  RecordConsentDto documentId(String documentId) =>
      this(documentId: documentId);

  @override
  RecordConsentDto granted(bool granted) => this(granted: granted);

  @override
  RecordConsentDto appVersion(String? appVersion) =>
      this(appVersion: appVersion);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RecordConsentDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RecordConsentDto(...).copyWith(id: 12, name: "My name")
  /// ````
  RecordConsentDto call({
    Object? documentId = const $CopyWithPlaceholder(),
    Object? granted = const $CopyWithPlaceholder(),
    Object? appVersion = const $CopyWithPlaceholder(),
  }) {
    return RecordConsentDto(
      documentId: documentId == const $CopyWithPlaceholder()
          ? _value.documentId
          // ignore: cast_nullable_to_non_nullable
          : documentId as String,
      granted: granted == const $CopyWithPlaceholder()
          ? _value.granted
          // ignore: cast_nullable_to_non_nullable
          : granted as bool,
      appVersion: appVersion == const $CopyWithPlaceholder()
          ? _value.appVersion
          // ignore: cast_nullable_to_non_nullable
          : appVersion as String?,
    );
  }
}

extension $RecordConsentDtoCopyWith on RecordConsentDto {
  /// Returns a callable class that can be used as follows: `instanceOfRecordConsentDto.copyWith(...)` or like so:`instanceOfRecordConsentDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RecordConsentDtoCWProxy get copyWith => _$RecordConsentDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecordConsentDto _$RecordConsentDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('RecordConsentDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['documentId', 'granted']);
      final val = RecordConsentDto(
        documentId: $checkedConvert('documentId', (v) => v as String),
        granted: $checkedConvert('granted', (v) => v as bool),
        appVersion: $checkedConvert('appVersion', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$RecordConsentDtoToJson(RecordConsentDto instance) =>
    <String, dynamic>{
      'documentId': instance.documentId,
      'granted': instance.granted,
      'appVersion': ?instance.appVersion,
    };
