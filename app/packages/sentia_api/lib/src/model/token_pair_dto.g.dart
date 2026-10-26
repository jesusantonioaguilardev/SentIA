// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_pair_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TokenPairDtoCWProxy {
  TokenPairDto accessToken(String accessToken);

  TokenPairDto refreshToken(String refreshToken);

  TokenPairDto expiresIn(num expiresIn);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TokenPairDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TokenPairDto(...).copyWith(id: 12, name: "My name")
  /// ````
  TokenPairDto call({String accessToken, String refreshToken, num expiresIn});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTokenPairDto.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTokenPairDto.copyWith.fieldName(...)`
class _$TokenPairDtoCWProxyImpl implements _$TokenPairDtoCWProxy {
  const _$TokenPairDtoCWProxyImpl(this._value);

  final TokenPairDto _value;

  @override
  TokenPairDto accessToken(String accessToken) =>
      this(accessToken: accessToken);

  @override
  TokenPairDto refreshToken(String refreshToken) =>
      this(refreshToken: refreshToken);

  @override
  TokenPairDto expiresIn(num expiresIn) => this(expiresIn: expiresIn);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TokenPairDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TokenPairDto(...).copyWith(id: 12, name: "My name")
  /// ````
  TokenPairDto call({
    Object? accessToken = const $CopyWithPlaceholder(),
    Object? refreshToken = const $CopyWithPlaceholder(),
    Object? expiresIn = const $CopyWithPlaceholder(),
  }) {
    return TokenPairDto(
      accessToken: accessToken == const $CopyWithPlaceholder()
          ? _value.accessToken
          // ignore: cast_nullable_to_non_nullable
          : accessToken as String,
      refreshToken: refreshToken == const $CopyWithPlaceholder()
          ? _value.refreshToken
          // ignore: cast_nullable_to_non_nullable
          : refreshToken as String,
      expiresIn: expiresIn == const $CopyWithPlaceholder()
          ? _value.expiresIn
          // ignore: cast_nullable_to_non_nullable
          : expiresIn as num,
    );
  }
}

extension $TokenPairDtoCopyWith on TokenPairDto {
  /// Returns a callable class that can be used as follows: `instanceOfTokenPairDto.copyWith(...)` or like so:`instanceOfTokenPairDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TokenPairDtoCWProxy get copyWith => _$TokenPairDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenPairDto _$TokenPairDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('TokenPairDto', json, ($checkedConvert) {
      $checkKeys(
        json,
        requiredKeys: const ['accessToken', 'refreshToken', 'expiresIn'],
      );
      final val = TokenPairDto(
        accessToken: $checkedConvert('accessToken', (v) => v as String),
        refreshToken: $checkedConvert('refreshToken', (v) => v as String),
        expiresIn: $checkedConvert('expiresIn', (v) => v as num),
      );
      return val;
    });

Map<String, dynamic> _$TokenPairDtoToJson(TokenPairDto instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'expiresIn': instance.expiresIn,
    };
