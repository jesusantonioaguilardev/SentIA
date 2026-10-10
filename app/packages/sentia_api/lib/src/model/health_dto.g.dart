// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$HealthDtoCWProxy {
  HealthDto status(HealthDtoStatusEnum status);

  HealthDto database(HealthDtoDatabaseEnum database);

  HealthDto environment(HealthDtoEnvironmentEnum environment);

  HealthDto version(String version);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `HealthDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HealthDto(...).copyWith(id: 12, name: "My name")
  /// ````
  HealthDto call({
    HealthDtoStatusEnum status,
    HealthDtoDatabaseEnum database,
    HealthDtoEnvironmentEnum environment,
    String version,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfHealthDto.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfHealthDto.copyWith.fieldName(...)`
class _$HealthDtoCWProxyImpl implements _$HealthDtoCWProxy {
  const _$HealthDtoCWProxyImpl(this._value);

  final HealthDto _value;

  @override
  HealthDto status(HealthDtoStatusEnum status) => this(status: status);

  @override
  HealthDto database(HealthDtoDatabaseEnum database) =>
      this(database: database);

  @override
  HealthDto environment(HealthDtoEnvironmentEnum environment) =>
      this(environment: environment);

  @override
  HealthDto version(String version) => this(version: version);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `HealthDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HealthDto(...).copyWith(id: 12, name: "My name")
  /// ````
  HealthDto call({
    Object? status = const $CopyWithPlaceholder(),
    Object? database = const $CopyWithPlaceholder(),
    Object? environment = const $CopyWithPlaceholder(),
    Object? version = const $CopyWithPlaceholder(),
  }) {
    return HealthDto(
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as HealthDtoStatusEnum,
      database: database == const $CopyWithPlaceholder()
          ? _value.database
          // ignore: cast_nullable_to_non_nullable
          : database as HealthDtoDatabaseEnum,
      environment: environment == const $CopyWithPlaceholder()
          ? _value.environment
          // ignore: cast_nullable_to_non_nullable
          : environment as HealthDtoEnvironmentEnum,
      version: version == const $CopyWithPlaceholder()
          ? _value.version
          // ignore: cast_nullable_to_non_nullable
          : version as String,
    );
  }
}

extension $HealthDtoCopyWith on HealthDto {
  /// Returns a callable class that can be used as follows: `instanceOfHealthDto.copyWith(...)` or like so:`instanceOfHealthDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$HealthDtoCWProxy get copyWith => _$HealthDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HealthDto _$HealthDtoFromJson(Map<String, dynamic> json) => $checkedCreate(
      'HealthDto',
      json,
      ($checkedConvert) {
        $checkKeys(
          json,
          requiredKeys: const ['status', 'database', 'environment', 'version'],
        );
        final val = HealthDto(
          status: $checkedConvert(
              'status', (v) => $enumDecode(_$HealthDtoStatusEnumEnumMap, v)),
          database: $checkedConvert('database',
              (v) => $enumDecode(_$HealthDtoDatabaseEnumEnumMap, v)),
          environment: $checkedConvert('environment',
              (v) => $enumDecode(_$HealthDtoEnvironmentEnumEnumMap, v)),
          version: $checkedConvert('version', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$HealthDtoToJson(HealthDto instance) => <String, dynamic>{
      'status': _$HealthDtoStatusEnumEnumMap[instance.status]!,
      'database': _$HealthDtoDatabaseEnumEnumMap[instance.database]!,
      'environment': _$HealthDtoEnvironmentEnumEnumMap[instance.environment]!,
      'version': instance.version,
    };

const _$HealthDtoStatusEnumEnumMap = {
  HealthDtoStatusEnum.ok: 'ok',
  HealthDtoStatusEnum.degraded: 'degraded',
};

const _$HealthDtoDatabaseEnumEnumMap = {
  HealthDtoDatabaseEnum.up: 'up',
  HealthDtoDatabaseEnum.down: 'down',
};

const _$HealthDtoEnvironmentEnumEnumMap = {
  HealthDtoEnvironmentEnum.dev: 'dev',
  HealthDtoEnvironmentEnum.staging: 'staging',
  HealthDtoEnvironmentEnum.prod: 'prod',
};
