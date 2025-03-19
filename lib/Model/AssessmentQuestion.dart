class AssessmentQuestion {
  final int id;
  final String sectionName;
  final String question;
  final int status;

  AssessmentQuestion({
    required this.id,
    required this.sectionName,
    required this.question,
    required this.status,
  });

  // Factory method to create an instance from JSON
  factory AssessmentQuestion.fromJson(Map<String, dynamic> json) {
    return AssessmentQuestion(
      id: json['id'],
      sectionName: json['section_name'],
      question: json['Q1'],
      status: json['status'],
    );
  }
}
