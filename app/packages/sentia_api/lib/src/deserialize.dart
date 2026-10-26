import 'package:sentia_api/src/model/account_deletion_request_dto.dart';
import 'package:sentia_api/src/model/confirm_deletion_dto.dart';
import 'package:sentia_api/src/model/consent_document_dto.dart';
import 'package:sentia_api/src/model/consent_status_dto.dart';
import 'package:sentia_api/src/model/delete_account_dto.dart';
import 'package:sentia_api/src/model/emergency_contact_dto.dart';
import 'package:sentia_api/src/model/forgot_password_dto.dart';
import 'package:sentia_api/src/model/health_dto.dart';
import 'package:sentia_api/src/model/login_dto.dart';
import 'package:sentia_api/src/model/profile_dto.dart';
import 'package:sentia_api/src/model/record_consent_dto.dart';
import 'package:sentia_api/src/model/refresh_dto.dart';
import 'package:sentia_api/src/model/register_dto.dart';
import 'package:sentia_api/src/model/reset_password_dto.dart';
import 'package:sentia_api/src/model/safety_resource_dto.dart';
import 'package:sentia_api/src/model/token_pair_dto.dart';
import 'package:sentia_api/src/model/update_profile_dto.dart';

final _regList = RegExp(r'^List<(.*)>$');
final _regSet = RegExp(r'^Set<(.*)>$');
final _regMap = RegExp(r'^Map<String,(.*)>$');

  ReturnType deserialize<ReturnType, BaseType>(dynamic value, String targetType, {bool growable= true}) {
      switch (targetType) {
        case 'String':
          return '$value' as ReturnType;
        case 'int':
          return (value is int ? value : int.parse('$value')) as ReturnType;
        case 'bool':
          if (value is bool) {
            return value as ReturnType;
          }
          final valueString = '$value'.toLowerCase();
          return (valueString == 'true' || valueString == '1') as ReturnType;
        case 'double':
          return (value is double ? value : double.parse('$value')) as ReturnType;
        case 'AccountDeletionRequestDto':
          return AccountDeletionRequestDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ConfirmDeletionDto':
          return ConfirmDeletionDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ConsentDocumentDto':
          return ConsentDocumentDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ConsentStatusDto':
          return ConsentStatusDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'DeleteAccountDto':
          return DeleteAccountDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'EmergencyContactDto':
          return EmergencyContactDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ForgotPasswordDto':
          return ForgotPasswordDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'HealthDto':
          return HealthDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'LoginDto':
          return LoginDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ProfileDto':
          return ProfileDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'RecordConsentDto':
          return RecordConsentDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'RefreshDto':
          return RefreshDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'RegisterDto':
          return RegisterDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'ResetPasswordDto':
          return ResetPasswordDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'SafetyResourceDto':
          return SafetyResourceDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'TokenPairDto':
          return TokenPairDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        case 'UpdateProfileDto':
          return UpdateProfileDto.fromJson(value as Map<String, dynamic>) as ReturnType;
        default:
          RegExpMatch? match;

          if (value is List && (match = _regList.firstMatch(targetType)) != null) {
            targetType = match![1]!; // ignore: parameter_assignments
            return value
              .map<BaseType>((dynamic v) => deserialize<BaseType, BaseType>(v, targetType, growable: growable))
              .toList(growable: growable) as ReturnType;
          }
          if (value is Set && (match = _regSet.firstMatch(targetType)) != null) {
            targetType = match![1]!; // ignore: parameter_assignments
            return value
              .map<BaseType>((dynamic v) => deserialize<BaseType, BaseType>(v, targetType, growable: growable))
              .toSet() as ReturnType;
          }
          if (value is Map && (match = _regMap.firstMatch(targetType)) != null) {
            targetType = match![1]!.trim(); // ignore: parameter_assignments
            return Map<String, BaseType>.fromIterables(
              value.keys as Iterable<String>,
              value.values.map((dynamic v) => deserialize<BaseType, BaseType>(v, targetType, growable: growable)),
            ) as ReturnType;
          }
          break;
    }
    throw Exception('Cannot deserialize');
  }