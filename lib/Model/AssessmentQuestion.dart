class AssessmentQuestion {
  final int id;
  final String sectionName;
  final String question;
  final int status; // Changed to int to match JSON
  final int forWhome; // Changed to int to match JSON

  AssessmentQuestion({
    required this.id,
    required this.sectionName,
    required this.question,
    required this.status,
    required this.forWhome,
  });

  factory AssessmentQuestion.fromJson(Map<String, dynamic> json) {
    return AssessmentQuestion(
      id: json['id'] ?? 0,
      sectionName: json['section_name']?.toString() ?? '',
      question: json['Q1']?.toString() ?? '',
      status: json['status'] is int
          ? json['status']
          : int.tryParse(json['status'].toString()) ?? 0,
      forWhome: json['for_whome'] is int
          ? json['for_whome']
          : int.tryParse(json['for_whome'].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'section_name': sectionName,
      'Q1': question,
      'status': status,
      'for_whome': forWhome,
    };
  }
}