import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sentia2/core/error/result.dart';
import 'package:sentia2/features/profile/data/api_profile_repository.dart';
import 'package:sentia2/features/profile/domain/profile.dart';

part 'profile_controller.g.dart';

@riverpod
class ProfileController extends _$ProfileController {
  @override
  Future<Profile> build() async {
    final result = await ref.watch(profileRepositoryProvider).get();
    return _unwrap<Profile>(result);
  }

  Future<Result<Profile>> save({
    String? displayName,
    EmergencyContact? emergencyContact,
  }) async {
    final result = await ref
        .read(profileRepositoryProvider)
        .update(displayName: displayName, emergencyContact: emergencyContact);
    if (result case Ok(:final value) when ref.mounted) {
      state = AsyncData(value);
    }
    return result;
  }

  Future<Result<void>> removeEmergencyContact() async {
    final result = await ref
        .read(profileRepositoryProvider)
        .clearEmergencyContact();
    if (result is Ok && ref.mounted) ref.invalidateSelf();
    return result;
  }

  static T _unwrap<T>(Result<T> result) => switch (result) {
    Ok(:final value) => value,
    Err(:final failure) => throw failure,
  };
}
