import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sentia2/core/logging/app_logger.dart';
import 'package:sentia2/core/network/api_providers.dart';
import 'package:sentia2/features/safety/domain/safety_resource.dart';
import 'package:sentia_api/sentia_api.dart';

part 'safety_repository_impl.g.dart';

const bundledResourcesAsset = 'assets/safety/resources_mx.json';

@riverpod
SafetyRepository safetyRepository(Ref ref) => SafetyRepositoryImpl(
  ref.watch(sentiaApiProvider).getSafetyApi(),
  () => rootBundle.loadString(bundledResourcesAsset),
);

/// Pide los recursos al backend con un tiempo de espera corto y, si falla,
/// usa la copia empaquetada: la pantalla de ayuda nunca debe quedar vacía.
class SafetyRepositoryImpl implements SafetyRepository {
  new(this._api, this._loadBundled);

  final SafetyApi _api;
  final Future<String> Function() _loadBundled;

  static const _timeout = Duration(seconds: 4);

  @override
  Future<SafetyResources> resources() async {
    try {
      final response = await _api
          .safetyResources(country: 'MX')
          .timeout(_timeout);
      final items = response.data!.map(_fromDto).toList();
      if (items.isNotEmpty) {
        return SafetyResources(items: items, fromCache: false);
      }
    } on Object catch (error) {
      AppLogger.warning('Recursos de ayuda sin red: se usa la copia local', {
        'errorType': error.runtimeType,
      });
    }
    return SafetyResources(items: await _bundled(), fromCache: true);
  }

  Future<List<SafetyResource>> _bundled() async {
    final json = jsonDecode(await _loadBundled()) as Map<String, dynamic>;
    final resources = (json['resources'] as List<dynamic>)
        .cast<Map<String, dynamic>>();
    return [
      for (final r in resources)
        SafetyResource(
          name: r['name'] as String,
          description: r['description'] as String?,
          phone: r['phone'] as String?,
          hours: r['hours'] as String?,
          verifiedSourceUrl: r['verifiedSourceUrl'] as String,
          verifiedAt: DateTime.parse(r['verifiedAt'] as String),
          clinicallyApproved: r['clinicalApproval'] == 'approved',
        ),
    ];
  }

  static SafetyResource _fromDto(SafetyResourceDto dto) => SafetyResource(
    name: dto.name,
    description: dto.description,
    phone: dto.phone,
    hours: dto.hours,
    verifiedSourceUrl: dto.verifiedSourceUrl,
    verifiedAt: DateTime.parse(dto.verifiedAt),
    clinicallyApproved:
        dto.clinicalApproval == SafetyResourceDtoClinicalApprovalEnum.approved,
  );
}
