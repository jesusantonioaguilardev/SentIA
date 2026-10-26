//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sentia_api/src/model/consent_document_dto.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'consent_status_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ConsentStatusDto {
  /// Returns a new [ConsentStatusDto] instance.
  ConsentStatusDto({

    required  this.document,

    required  this.granted,

     this.decidedAt,
  });

  @JsonKey(
    
    name: r'document',
    required: true,
    includeIfNull: false,
  )


  final ConsentDocumentDto document;



      /// Decisión vigente del usuario sobre esta versión.
  @JsonKey(
    
    name: r'granted',
    required: true,
    includeIfNull: false,
  )


  final bool granted;



  @JsonKey(
    
    name: r'decidedAt',
    required: false,
    includeIfNull: false,
  )


  final String? decidedAt;





    @override
    bool operator ==(Object other) => identical(this, other) || other is ConsentStatusDto &&
      other.document == document &&
      other.granted == granted &&
      other.decidedAt == decidedAt;

    @override
    int get hashCode =>
        document.hashCode +
        granted.hashCode +
        (decidedAt == null ? 0 : decidedAt.hashCode);

  factory ConsentStatusDto.fromJson(Map<String, dynamic> json) => _$ConsentStatusDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ConsentStatusDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

