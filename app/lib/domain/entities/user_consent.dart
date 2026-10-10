class ConsentRecord {
  final bool accepted;
  final String documentVersion;
  final DateTime timestamp;

  const ConsentRecord({
    required this.accepted,
    required this.documentVersion,
    required this.timestamp,
  });
}

class UserConsent {
  final ConsentRecord sensitiveData;
  final ConsentRecord clinicalLimit;
  final ConsentRecord professionalLink;
  final ConsentRecord researchImprovement;

  const UserConsent({
    required this.sensitiveData,
    required this.clinicalLimit,
    required this.professionalLink,
    required this.researchImprovement,
  });
}
