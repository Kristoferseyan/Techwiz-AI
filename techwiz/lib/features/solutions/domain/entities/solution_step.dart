class SolutionStep {
  final int stepNumber;
  final String instruction;

  SolutionStep({required this.stepNumber, required this.instruction});

  factory SolutionStep.fromJson(Map<String, dynamic> json) {
    return SolutionStep(
      stepNumber: json['step_number'] ?? 0,
      instruction: json['instruction'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'step_number': stepNumber, 'instruction': instruction};
  }
}
