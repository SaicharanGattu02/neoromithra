import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../Components/CustomAppButton.dart';
import '../Model/AssessmentQuestion.dart';
import '../Presentation/MainDashBoard.dart';
import '../services/userapi.dart';
import '../utils/Color_Constants.dart';
import 'ResultScreen.dart';

class Adultassignment extends StatefulWidget {
  const Adultassignment({super.key});

  @override
  State<Adultassignment> createState() => _AdultassignmentState();
}

class _AdultassignmentState extends State<Adultassignment> {
  bool isLoading = true;
  bool isSaving = false;
  Map<int, String> selectedAnswers = {};
  Map<String, List<AssessmentQuestion>> parsedData = {};

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

  // Fetch questions from UserApi
  Future<void> fetchQuestions() async {
    parsedData = await Userapi.fetchAdultQuestions();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> submitAnswersApi(Map<String, dynamic> data) async {
    setState(() {
      isSaving = true;
    });

    var res = await Userapi.submitChildrenAnswers(data, "1"); // Change role dynamically

    setState(() {
      isSaving = false;
    });

    if (res["status"] == true) {
      String role = res["role"].toString();
      String resultString = res["result"];
      Map<String, dynamic> resultData = jsonDecode(resultString); // Convert to Map

      context.pushReplacement('/result_screen?resultData=${resultData}&role=${role}');

    } else {
      // Failure message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(res["message"] ?? "Failed to submit answers!"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Adult Intake Form',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: "Inter",
            color: primarycolor,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: primarycolor),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: const Text(
                'Start with Our Simple Guide',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    height: 1,
                    fontFamily: "Poppins"),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Go through our guide or schedule a counseling session.Begin your journey toward mental wellness with personalized support.',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Poppins"),
            ),
            const SizedBox(height: 20),
            const Text(
              'Here’s a simple guide designed to help individuals reflect on different aspects of their lives and identify areas for improvement:',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Poppins"),
            ),
            const SizedBox(height: 20),
            const Text(
              'Instructions: For each of the following statements, rate yourself on a scale from 1 to 5, where:',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Poppins"),
            ),
            const SizedBox(height: 20),
            const Text(
              '1 = Strongly Disagree\n2 = Disagree\n3 = Neutral\n4 = Agree\n5 = Strongly Agree',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Poppins"),
            ),
            const SizedBox(height: 20),
            isLoading
                ? const Center(child: CircularProgressIndicator()) // Show loader
                : parsedData.isEmpty
                ? const Center(child: Text("No questions available"))
                : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: parsedData.entries.map<Widget>((entry) {
                String sectionName = entry.key;
                List<AssessmentQuestion> questions = entry.value;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section Title
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        sectionName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Poppins",
                          color: primarycolor,
                        ),
                      ),
                    ),
                    // Questions List
                    ...questions.map((question) {
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                question.question,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              // Radio Button Options
                              Column(
                                children: ["Strongly Disagree", "Disagree", "Neutral","Agree","Strongly Agree"]
                                    .map(
                                      (answer) => RadioListTile(
                                    visualDensity: VisualDensity.compact,
                                    title: Text(answer,style: TextStyle(
                                        fontFamily: "Poppins"
                                    ),),
                                    value: answer,
                                    groupValue:
                                    selectedAnswers[question.id],
                                    onChanged: (value) {
                                      setState(() {
                                        selectedAnswers[question.id] =
                                        value!;
                                      });
                                    },
                                    activeColor: primarycolor,
                                  ),
                                )
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            // Submit Button
            CustomAppButton(
              text: 'Submit',
              isLoading: isSaving,
              onPlusTap: isSaving ? null: () {
                  bool allAnswered = selectedAnswers.values.every((answer) => answer.isNotEmpty);

                  if (!allAnswered) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please answer all questions before submitting!"))
                    );
                    return;
                  }
                  // Prepare final JSON data for submission
                  Map<String, dynamic> submissionData = {
                    "answers": parsedData.map((section, questions) {
                      return MapEntry(
                        section,
                        questions.map((question) {
                          return {
                            "id": question.id,
                            "section_name": question.sectionName,
                            "question": question.question,
                            "answer": selectedAnswers[question.id] ?? ""
                          };
                        }).toList(),
                      );
                    })
                  };
                  print("Final Submission JSON: ${jsonEncode(submissionData)}");
                  submitAnswersApi(submissionData);

              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
