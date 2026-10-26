//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class RegisterDto {
  /// Returns a new [RegisterDto] instance.
  RegisterDto({

    required  this.email,

    required  this.password,

    required  this.birthYear,

    required  this.ageConfirmed,
  });

  @JsonKey(
    
    name: r'email',
    required: true,
    includeIfNull: false,
  )


  final String email;



  @JsonKey(
    
    name: r'password',
    required: true,
    includeIfNull: false,
  )


  final String password;



  @JsonKey(
    
    name: r'birthYear',
    required: true,
    includeIfNull: false,
  )


  final num birthYear;



      /// El usuario declara ser mayor de 18 años.
  @JsonKey(
    
    name: r'ageConfirmed',
    required: true,
    includeIfNull: false,
  )


  final bool ageConfirmed;





    @override
    bool operator ==(Object other) => identical(this, other) || other is RegisterDto &&
      other.email == email &&
      other.password == password &&
      other.birthYear == birthYear &&
      other.ageConfirmed == ageConfirmed;

    @override
    int get hashCode =>
        email.hashCode +
        password.hashCode +
        birthYear.hashCode +
        ageConfirmed.hashCode;

  factory RegisterDto.fromJson(Map<String, dynamic> json) => _$RegisterDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

