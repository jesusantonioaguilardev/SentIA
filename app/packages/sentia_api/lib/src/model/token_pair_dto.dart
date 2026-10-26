//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'token_pair_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class TokenPairDto {
  /// Returns a new [TokenPairDto] instance.
  TokenPairDto({

    required  this.accessToken,

    required  this.refreshToken,

    required  this.expiresIn,
  });

  @JsonKey(
    
    name: r'accessToken',
    required: true,
    includeIfNull: false,
  )


  final String accessToken;



  @JsonKey(
    
    name: r'refreshToken',
    required: true,
    includeIfNull: false,
  )


  final String refreshToken;



      /// Segundos de vida del access token.
  @JsonKey(
    
    name: r'expiresIn',
    required: true,
    includeIfNull: false,
  )


  final num expiresIn;





    @override
    bool operator ==(Object other) => identical(this, other) || other is TokenPairDto &&
      other.accessToken == accessToken &&
      other.refreshToken == refreshToken &&
      other.expiresIn == expiresIn;

    @override
    int get hashCode =>
        accessToken.hashCode +
        refreshToken.hashCode +
        expiresIn.hashCode;

  factory TokenPairDto.fromJson(Map<String, dynamic> json) => _$TokenPairDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TokenPairDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

