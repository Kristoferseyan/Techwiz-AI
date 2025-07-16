class AiMatchRequest {
  final String deviceType;
  final String category;
  final String description;

  const AiMatchRequest({
    required this.deviceType,
    required this.category,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'deviceType': deviceType,
      'category': category,
      'description': description,
    };
  }
}
