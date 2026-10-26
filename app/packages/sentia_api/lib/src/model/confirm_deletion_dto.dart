//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'confirm_deletion_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ConfirmDeletionDto {
  /// Returns a new [ConfirmDeletionDto] instance.
  ConfirmDeletionDto({

    required  this.token,
  });

  @JsonKey(
    
    name: r'token',
    required: true,
    includeIfNull: false,
  )


  final String token;





    @override
    bool operator ==(Object other) => identical(this, other) || other is ConfirmDeletionDto &&
      other.token == token;

    @override
    int get hashCode =>
        token.hashCode;

  factory ConfirmDeletionDto.fromJson(Map<String, dynamic> json) => _$ConfirmDeletionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmDeletionDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

