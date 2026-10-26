//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account_deletion_request_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AccountDeletionRequestDto {
  /// Returns a new [AccountDeletionRequestDto] instance.
  AccountDeletionRequestDto({

    required  this.email,
  });

  @JsonKey(
    
    name: r'email',
    required: true,
    includeIfNull: false,
  )


  final String email;





    @override
    bool operator ==(Object other) => identical(this, other) || other is AccountDeletionRequestDto &&
      other.email == email;

    @override
    int get hashCode =>
        email.hashCode;

  factory AccountDeletionRequestDto.fromJson(Map<String, dynamic> json) => _$AccountDeletionRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AccountDeletionRequestDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

