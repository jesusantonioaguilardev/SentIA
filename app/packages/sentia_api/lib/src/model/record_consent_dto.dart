//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'record_consent_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class RecordConsentDto {
  /// Returns a new [RecordConsentDto] instance.
  RecordConsentDto({

    required  this.documentId,

    required  this.granted,

     this.appVersion,
  });

  @JsonKey(
    
    name: r'documentId',
    required: true,
    includeIfNull: false,
  )


  final String documentId;



      /// true = acepta, false = revoca.
  @JsonKey(
    
    name: r'granted',
    required: true,
    includeIfNull: false,
  )


  final bool granted;



  @JsonKey(
    
    name: r'appVersion',
    required: false,
    includeIfNull: false,
  )


  final String? appVersion;





    @override
    bool operator ==(Object other) => identical(this, other) || other is RecordConsentDto &&
      other.documentId == documentId &&
      other.granted == granted &&
      other.appVersion == appVersion;

    @override
    int get hashCode =>
        documentId.hashCode +
        granted.hashCode +
        appVersion.hashCode;

  factory RecordConsentDto.fromJson(Map<String, dynamic> json) => _$RecordConsentDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RecordConsentDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

