import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../Model/AssessmentQuestion.dart';
import '../services/userapi.dart';

class AssessmentProvider with ChangeNotifier {
  Map<String, List<AssessmentQuestion>> _questions = {};
  Map<int, String> _selectedAnswers = {};
  bool _isLoading = false;
  bool _isSaving = false;

  Map<String, List<AssessmentQuestion>> get questions => _questions;
  Map<int, String> get selectedAnswers => _selectedAnswers;
  bool get isLoading => _isLoading;
  bool get isSaving => _isSaving;

  Future<void> fetchQuestions(role) async {
    _isLoading = true;
    notifyListeners();
    _questions = await Userapi.fetchAdultQuestions();
    _isLoading = false;
    notifyListeners();
  }

  void selectAnswer(int questionId, String answer) {
    _selectedAnswers[questionId] = answer;
    notifyListeners();
  }

  bool allAnswered() {
    for (var section in _questions.values) {
      for (var question in section) {
        if (!_selectedAnswers.containsKey(question.id) ||
            _selectedAnswers[question.id]!.isEmpty) {
          return false;
        }
      }
    }
    return true;
  }

  Future<void> submitAnswers(
    BuildContext context,
    String role, {
    Map<String, dynamic>? childInfo,
  }) async {
    if (!allAnswered()) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Please answer all questions before submitting!")),
        );
      }
      return;
    }

    try {
      _isSaving = true;
      notifyListeners();

      Map<String, dynamic> submissionData = {
        if (childInfo != null) "child_info": childInfo,
        "role": role,
        "answers": _questions.map((section, questions) {
          return MapEntry(
            section,
            questions.map((q) {
              return {
                "id": q.id,
                "section_name": q.sectionName,
                "question": q.question,
                "answer": _selectedAnswers[q.id] ?? "",
              };
            }).toList(),
          );
        }),
      };

      final res = await Userapi.submitAnswers(submissionData, role);

      if (res["status"] == true) {
        String resultRole = res["role"].toString();
        String resultString = res["result"];
        Map<String, dynamic> resultData = jsonDecode(resultString);
          context.pushReplacement(
            "/result_screen",
          );
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(res["message"] ?? "Submission failed"),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error submitting answers: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      _isSaving = false;
      notifyListeners();
    }
  }
}
