// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consent_document_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ConsentDocumentDtoCWProxy {
  ConsentDocumentDto id(String id);

  ConsentDocumentDto type(ConsentDocumentDtoTypeEnum type);

  ConsentDocumentDto version(String version);

  ConsentDocumentDto title(String title);

  ConsentDocumentDto content(String content);

  ConsentDocumentDto required_(bool required_);

  ConsentDocumentDto isDraft(bool isDraft);

  ConsentDocumentDto publishedAt(String publishedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ConsentDocumentDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ConsentDocumentDto(...).copyWith(id: 12, name: "My name")
  /// ````
  ConsentDocumentDto call({
    String id,
    ConsentDocumentDtoTypeEnum type,
    String version,
    String title,
    String content,
    bool required_,
    bool isDraft,
    String publishedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfConsentDocumentDto.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfConsentDocumentDto.copyWith.fieldName(...)`
class _$ConsentDocumentDtoCWProxyImpl implements _$ConsentDocumentDtoCWProxy {
  const _$ConsentDocumentDtoCWProxyImpl(this._value);

  final ConsentDocumentDto _value;

  @override
  ConsentDocumentDto id(String id) => this(id: id);

  @override
  ConsentDocumentDto type(ConsentDocumentDtoTypeEnum type) => this(type: type);

  @override
  ConsentDocumentDto version(String version) => this(version: version);

  @override
  ConsentDocumentDto title(String title) => this(title: title);

  @override
  ConsentDocumentDto content(String content) => this(content: content);

  @override
  ConsentDocumentDto required_(bool required_) => this(required_: required_);

  @override
  ConsentDocumentDto isDraft(bool isDraft) => this(isDraft: isDraft);

  @override
  ConsentDocumentDto publishedAt(String publishedAt) =>
      this(publishedAt: publishedAt);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ConsentDocumentDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ConsentDocumentDto(...).copyWith(id: 12, name: "My name")
  /// ````
  ConsentDocumentDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? version = const $CopyWithPlaceholder(),
    Object? title = const $CopyWithPlaceholder(),
    Object? content = const $CopyWithPlaceholder(),
    Object? required_ = const $CopyWithPlaceholder(),
    Object? isDraft = const $CopyWithPlaceholder(),
    Object? publishedAt = const $CopyWithPlaceholder(),
  }) {
    return ConsentDocumentDto(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      type: type == const $CopyWithPlaceholder()
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as ConsentDocumentDtoTypeEnum,
      version: version == const $CopyWithPlaceholder()
          ? _value.version
          // ignore: cast_nullable_to_non_nullable
          : version as String,
      title: title == const $CopyWithPlaceholder()
          ? _value.title
          // ignore: cast_nullable_to_non_nullable
          : title as String,
      content: content == const $CopyWithPlaceholder()
          ? _value.content
          // ignore: cast_nullable_to_non_nullable
          : content as String,
      required_: required_ == const $CopyWithPlaceholder()
          ? _value.required_
          // ignore: cast_nullable_to_non_nullable
          : required_ as bool,
      isDraft: isDraft == const $CopyWithPlaceholder()
          ? _value.isDraft
          // ignore: cast_nullable_to_non_nullable
          : isDraft as bool,
      publishedAt: publishedAt == const $CopyWithPlaceholder()
          ? _value.publishedAt
          // ignore: cast_nullable_to_non_nullable
          : publishedAt as String,
    );
  }
}

extension $ConsentDocumentDtoCopyWith on ConsentDocumentDto {
  /// Returns a callable class that can be used as follows: `instanceOfConsentDocumentDto.copyWith(...)` or like so:`instanceOfConsentDocumentDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ConsentDocumentDtoCWProxy get copyWith =>
      _$ConsentDocumentDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConsentDocumentDto _$ConsentDocumentDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ConsentDocumentDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const [
          'id',
          'type',
          'version',
          'title',
          'content',
          'required',
          'isDraft',
          'publishedAt',
        ],
      );
      final val = ConsentDocumentDto(
        id: $checkedConvert('id', (v) => v as String),
        type: $checkedConvert(
          'type',
          (v) => $enumDecode(_$ConsentDocumentDtoTypeEnumEnumMap, v),
        ),
        version: $checkedConvert('version', (v) => v as String),
        title: $checkedConvert('title', (v) => v as String),
        content: $checkedConvert('content', (v) => v as String),
        required_: $checkedConvert('required', (v) => v as bool),
        isDraft: $checkedConvert('isDraft', (v) => v as bool),
        publishedAt: $checkedConvert('publishedAt', (v) => v as String),
      );
      return val;
    }, fieldKeyMap: const {'required_': 'required'});

Map<String, dynamic> _$ConsentDocumentDtoToJson(ConsentDocumentDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$ConsentDocumentDtoTypeEnumEnumMap[instance.type]!,
      'version': instance.version,
      'title': instance.title,
      'content': instance.content,
      'required': instance.required_,
      'isDraft': instance.isDraft,
      'publishedAt': instance.publishedAt,
    };

const _$ConsentDocumentDtoTypeEnumEnumMap = {
  ConsentDocumentDtoTypeEnum.privacyNotice: 'privacy_notice',
  ConsentDocumentDtoTypeEnum.terms: 'terms',
  ConsentDocumentDtoTypeEnum.sensitiveData: 'sensitive_data',
  ConsentDocumentDtoTypeEnum.aiDisclaimer: 'ai_disclaimer',
  ConsentDocumentDtoTypeEnum.research: 'research',
};
