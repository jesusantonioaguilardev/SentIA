// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consent_status_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ConsentStatusDtoCWProxy {
  ConsentStatusDto document(ConsentDocumentDto document);

  ConsentStatusDto granted(bool granted);

  ConsentStatusDto decidedAt(String? decidedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ConsentStatusDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ConsentStatusDto(...).copyWith(id: 12, name: "My name")
  /// ````
  ConsentStatusDto call({
    ConsentDocumentDto document,
    bool granted,
    String? decidedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfConsentStatusDto.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfConsentStatusDto.copyWith.fieldName(...)`
class _$ConsentStatusDtoCWProxyImpl implements _$ConsentStatusDtoCWProxy {
  const _$ConsentStatusDtoCWProxyImpl(this._value);

  final ConsentStatusDto _value;

  @override
  ConsentStatusDto document(ConsentDocumentDto document) =>
      this(document: document);

  @override
  ConsentStatusDto granted(bool granted) => this(granted: granted);

  @override
  ConsentStatusDto decidedAt(String? decidedAt) => this(decidedAt: decidedAt);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ConsentStatusDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ConsentStatusDto(...).copyWith(id: 12, name: "My name")
  /// ````
  ConsentStatusDto call({
    Object? document = const $CopyWithPlaceholder(),
    Object? granted = const $CopyWithPlaceholder(),
    Object? decidedAt = const $CopyWithPlaceholder(),
  }) {
    return ConsentStatusDto(
      document: document == const $CopyWithPlaceholder()
          ? _value.document
          // ignore: cast_nullable_to_non_nullable
          : document as ConsentDocumentDto,
      granted: granted == const $CopyWithPlaceholder()
          ? _value.granted
          // ignore: cast_nullable_to_non_nullable
          : granted as bool,
      decidedAt: decidedAt == const $CopyWithPlaceholder()
          ? _value.decidedAt
          // ignore: cast_nullable_to_non_nullable
          : decidedAt as String?,
    );
  }
}

extension $ConsentStatusDtoCopyWith on ConsentStatusDto {
  /// Returns a callable class that can be used as follows: `instanceOfConsentStatusDto.copyWith(...)` or like so:`instanceOfConsentStatusDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ConsentStatusDtoCWProxy get copyWith => _$ConsentStatusDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConsentStatusDto _$ConsentStatusDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ConsentStatusDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['document', 'granted']);
      final val = ConsentStatusDto(
        document: $checkedConvert(
          'document',
          (v) => ConsentDocumentDto.fromJson(v as Map<String, dynamic>),
        ),
        granted: $checkedConvert('granted', (v) => v as bool),
        decidedAt: $checkedConvert('decidedAt', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$ConsentStatusDtoToJson(ConsentStatusDto instance) =>
    <String, dynamic>{
      'document': instance.document.toJson(),
      'granted': instance.granted,
      'decidedAt': ?instance.decidedAt,
    };
