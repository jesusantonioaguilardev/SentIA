//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'safety_resource_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class SafetyResourceDto {
  /// Returns a new [SafetyResourceDto] instance.
  SafetyResourceDto({

    required  this.name,

     this.description,

     this.phone,

     this.sms,

     this.url,

     this.hours,

    required  this.verifiedSourceUrl,

    required  this.verifiedAt,

    required  this.clinicalApproval,
  });

  @JsonKey(
    
    name: r'name',
    required: true,
    includeIfNull: false,
  )


  final String name;



  @JsonKey(
    
    name: r'description',
    required: false,
    includeIfNull: false,
  )


  final String? description;



      /// Número marcable, sin espacios.
  @JsonKey(
    
    name: r'phone',
    required: false,
    includeIfNull: false,
  )


  final String? phone;



  @JsonKey(
    
    name: r'sms',
    required: false,
    includeIfNull: false,
  )


  final String? sms;



  @JsonKey(
    
    name: r'url',
    required: false,
    includeIfNull: false,
  )


  final String? url;



  @JsonKey(
    
    name: r'hours',
    required: false,
    includeIfNull: false,
  )


  final String? hours;



      /// Página oficial donde se verificó.
  @JsonKey(
    
    name: r'verifiedSourceUrl',
    required: true,
    includeIfNull: false,
  )


  final String verifiedSourceUrl;



  @JsonKey(
    
    name: r'verifiedAt',
    required: true,
    includeIfNull: false,
  )


  final String verifiedAt;



  @JsonKey(
    
    name: r'clinicalApproval',
    required: true,
    includeIfNull: false,
  )


  final SafetyResourceDtoClinicalApprovalEnum clinicalApproval;





    @override
    bool operator ==(Object other) => identical(this, other) || other is SafetyResourceDto &&
      other.name == name &&
      other.description == description &&
      other.phone == phone &&
      other.sms == sms &&
      other.url == url &&
      other.hours == hours &&
      other.verifiedSourceUrl == verifiedSourceUrl &&
      other.verifiedAt == verifiedAt &&
      other.clinicalApproval == clinicalApproval;

    @override
    int get hashCode =>
        name.hashCode +
        (description == null ? 0 : description.hashCode) +
        (phone == null ? 0 : phone.hashCode) +
        (sms == null ? 0 : sms.hashCode) +
        (url == null ? 0 : url.hashCode) +
        (hours == null ? 0 : hours.hashCode) +
        verifiedSourceUrl.hashCode +
        verifiedAt.hashCode +
        clinicalApproval.hashCode;

  factory SafetyResourceDto.fromJson(Map<String, dynamic> json) => _$SafetyResourceDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SafetyResourceDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

enum SafetyResourceDtoClinicalApprovalEnum {
@JsonValue(r'pending')
pending(r'pending'),
@JsonValue(r'approved')
approved(r'approved');

const SafetyResourceDtoClinicalApprovalEnum(this.value);

final String value;

@override
String toString() => value;
}


