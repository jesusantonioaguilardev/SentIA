//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'health_dto.g.dart';


@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class HealthDto {
  /// Returns a new [HealthDto] instance.
  HealthDto({

    required  this.status,

    required  this.database,

    required  this.environment,

    required  this.version,
  });

  @JsonKey(
    
    name: r'status',
    required: true,
    includeIfNull: false,
  )


  final HealthDtoStatusEnum status;



  @JsonKey(
    
    name: r'database',
    required: true,
    includeIfNull: false,
  )


  final HealthDtoDatabaseEnum database;



  @JsonKey(
    
    name: r'environment',
    required: true,
    includeIfNull: false,
  )


  final HealthDtoEnvironmentEnum environment;



  @JsonKey(
    
    name: r'version',
    required: true,
    includeIfNull: false,
  )


  final String version;





    @override
    bool operator ==(Object other) => identical(this, other) || other is HealthDto &&
      other.status == status &&
      other.database == database &&
      other.environment == environment &&
      other.version == version;

    @override
    int get hashCode =>
        status.hashCode +
        database.hashCode +
        environment.hashCode +
        version.hashCode;

  factory HealthDto.fromJson(Map<String, dynamic> json) => _$HealthDtoFromJson(json);

  Map<String, dynamic> toJson() => _$HealthDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

enum HealthDtoStatusEnum {
@JsonValue(r'ok')
ok(r'ok'),
@JsonValue(r'degraded')
degraded(r'degraded');

const HealthDtoStatusEnum(this.value);

final String value;

@override
String toString() => value;
}


enum HealthDtoDatabaseEnum {
@JsonValue(r'up')
up(r'up'),
@JsonValue(r'down')
down(r'down');

const HealthDtoDatabaseEnum(this.value);

final String value;

@override
String toString() => value;
}


enum HealthDtoEnvironmentEnum {
@JsonValue(r'dev')
dev(r'dev'),
@JsonValue(r'staging')
staging(r'staging'),
@JsonValue(r'prod')
prod(r'prod');

const HealthDtoEnvironmentEnum(this.value);

final String value;

@override
String toString() => value;
}


