import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sentia2/core/error/result.dart';
import 'package:sentia2/core/network/api_providers.dart';
import 'package:sentia2/core/security/token_storage.dart';
import 'package:sentia2/features/profile/domain/profile.dart';
import 'package:sentia_api/sentia_api.dart';

part 'api_profile_repository.g.dart';

@riverpod
ProfileRepository profileRepository(Ref ref) => ApiProfileRepository(
  ref.watch(sentiaApiProvider).getMeApi(),
  ref.watch(tokenStorageProvider),
);

class ApiProfileRepository implements ProfileRepository {
  new(this._api, this._tokens);

  final MeApi _api;
  final TokenStorage _tokens;

  @override
  Future<Result<Profile>> get() =>
      Result.guard(() async => _toProfile((await _api.meGet()).data!));

  @override
  Future<Result<Profile>> update({
    String? displayName,
    EmergencyContact? emergencyContact,
  }) => Result.guard(() async {
    final response = await _api.meUpdate(
      updateProfileDto: UpdateProfileDto(
        displayName: displayName,
        emergencyContact: emergencyContact == null
            ? null
            : EmergencyContactDto(
                name: emergencyContact.name.trim(),
                phone: emergencyContact.phone.trim(),
              ),
      ),
    );
    return _toProfile(response.data!);
  });

  @override
  Future<Result<void>> clearEmergencyContact() => Result.guard(() async {
    await _api.meClearEmergencyContact();
  });

  @override
  Future<Result<String>> export() => Result.guard(() async {
    final response = await _api.meExport();
    return const JsonEncoder.withIndent('  ').convert(response.data);
  });

  @override
  Future<Result<void>> deleteAccount(String password) => Result.guard(() async {
    await _api.meRemove(deleteAccountDto: DeleteAccountDto(password: password));
    // La cuenta ya no existe: los tokens quedaron revocados en el servidor.
    await _tokens.clear();
  });

  static Profile _toProfile(ProfileDto dto) => Profile(
    email: dto.email,
    birthYear: dto.birthYear.toInt(),
    displayName: dto.displayName,
    emergencyContact: dto.emergencyContact == null
        ? null
        : EmergencyContact(
            name: dto.emergencyContact!.name,
            phone: dto.emergencyContact!.phone,
          ),
  );
}
