//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'consent_document_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ConsentDocumentDto {
  /// Returns a new [ConsentDocumentDto] instance.
  ConsentDocumentDto({

    required  this.id,

    required  this.type,

    required  this.version,

    required  this.title,

    required  this.content,

    required  this.required_,

    required  this.isDraft,

    required  this.publishedAt,
  });

  @JsonKey(
    
    name: r'id',
    required: true,
    includeIfNull: false,
  )


  final String id;



  @JsonKey(
    
    name: r'type',
    required: true,
    includeIfNull: false,
  )


  final ConsentDocumentDtoTypeEnum type;



  @JsonKey(
    
    name: r'version',
    required: true,
    includeIfNull: false,
  )


  final String version;



  @JsonKey(
    
    name: r'title',
    required: true,
    includeIfNull: false,
  )


  final String title;



      /// Markdown.
  @JsonKey(
    
    name: r'content',
    required: true,
    includeIfNull: false,
  )


  final String content;



      /// Debe aceptarse para usar la app.
  @JsonKey(
    
    name: r'required',
    required: true,
    includeIfNull: false,
  )


  final bool required_;



      /// Texto sin revisión legal: la app debe mostrarlo como borrador.
  @JsonKey(
    
    name: r'isDraft',
    required: true,
    includeIfNull: false,
  )


  final bool isDraft;



  @JsonKey(
    
    name: r'publishedAt',
    required: true,
    includeIfNull: false,
  )


  final String publishedAt;





    @override
    bool operator ==(Object other) => identical(this, other) || other is ConsentDocumentDto &&
      other.id == id &&
      other.type == type &&
      other.version == version &&
      other.title == title &&
      other.content == content &&
      other.required_ == required_ &&
      other.isDraft == isDraft &&
      other.publishedAt == publishedAt;

    @override
    int get hashCode =>
        id.hashCode +
        type.hashCode +
        version.hashCode +
        title.hashCode +
        content.hashCode +
        required_.hashCode +
        isDraft.hashCode +
        publishedAt.hashCode;

  factory ConsentDocumentDto.fromJson(Map<String, dynamic> json) => _$ConsentDocumentDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ConsentDocumentDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

enum ConsentDocumentDtoTypeEnum {
@JsonValue(r'privacy_notice')
privacyNotice(r'privacy_notice'),
@JsonValue(r'terms')
terms(r'terms'),
@JsonValue(r'sensitive_data')
sensitiveData(r'sensitive_data'),
@JsonValue(r'ai_disclaimer')
aiDisclaimer(r'ai_disclaimer'),
@JsonValue(r'research')
research(r'research');

const ConsentDocumentDtoTypeEnum(this.value);

final String value;

@override
String toString() => value;
}


