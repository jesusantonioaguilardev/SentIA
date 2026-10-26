//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:sentia_api/src/model/emergency_contact_dto.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_profile_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpdateProfileDto {
  /// Returns a new [UpdateProfileDto] instance.
  UpdateProfileDto({

     this.displayName,

     this.timezone,

     this.emergencyContact,
  });

  @JsonKey(
    
    name: r'displayName',
    required: false,
    includeIfNull: false,
  )


  final String? displayName;



  @JsonKey(
    
    name: r'timezone',
    required: false,
    includeIfNull: false,
  )


  final String? timezone;



      /// Opcional. La persona debe estar informada de que la registras (docs/02).
  @JsonKey(
    
    name: r'emergencyContact',
    required: false,
    includeIfNull: false,
  )


  final EmergencyContactDto? emergencyContact;





    @override
    bool operator ==(Object other) => identical(this, other) || other is UpdateProfileDto &&
      other.displayName == displayName &&
      other.timezone == timezone &&
      other.emergencyContact == emergencyContact;

    @override
    int get hashCode =>
        displayName.hashCode +
        timezone.hashCode +
        emergencyContact.hashCode;

  factory UpdateProfileDto.fromJson(Map<String, dynamic> json) => _$UpdateProfileDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProfileDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

