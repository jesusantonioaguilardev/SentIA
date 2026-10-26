//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sentia_api/src/model/emergency_contact_dto.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ProfileDto {
  /// Returns a new [ProfileDto] instance.
  ProfileDto({

    required  this.email,

    required  this.birthYear,

     this.displayName,

    required  this.timezone,

     this.emergencyContact,

    required  this.createdAt,
  });

  @JsonKey(
    
    name: r'email',
    required: true,
    includeIfNull: false,
  )


  final String email;



  @JsonKey(
    
    name: r'birthYear',
    required: true,
    includeIfNull: false,
  )


  final num birthYear;



  @JsonKey(
    
    name: r'displayName',
    required: false,
    includeIfNull: false,
  )


  final String? displayName;



  @JsonKey(
    
    name: r'timezone',
    required: true,
    includeIfNull: false,
  )


  final String timezone;



  @JsonKey(
    
    name: r'emergencyContact',
    required: false,
    includeIfNull: false,
  )


  final EmergencyContactDto? emergencyContact;



  @JsonKey(
    
    name: r'createdAt',
    required: true,
    includeIfNull: false,
  )


  final String createdAt;





    @override
    bool operator ==(Object other) => identical(this, other) || other is ProfileDto &&
      other.email == email &&
      other.birthYear == birthYear &&
      other.displayName == displayName &&
      other.timezone == timezone &&
      other.emergencyContact == emergencyContact &&
      other.createdAt == createdAt;

    @override
    int get hashCode =>
        email.hashCode +
        birthYear.hashCode +
        (displayName == null ? 0 : displayName.hashCode) +
        timezone.hashCode +
        (emergencyContact == null ? 0 : emergencyContact.hashCode) +
        createdAt.hashCode;

  factory ProfileDto.fromJson(Map<String, dynamic> json) => _$ProfileDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

