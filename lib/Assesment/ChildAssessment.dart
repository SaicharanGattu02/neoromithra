import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:neuromithra/Components/CustomAppButton.dart';
import 'package:neuromithra/Presentation/MainDashBoard.dart';

import '../Model/AssessmentQuestion.dart';
import '../services/userapi.dart';
import '../utils/Color_Constants.dart';
import 'ResultScreen.dart';

class ChildAssessment extends StatefulWidget {
  const ChildAssessment({super.key});

  @override
  State<ChildAssessment> createState() => _ChildAssessmentState();
}

class _ChildAssessmentState extends State<ChildAssessment> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _childNameController = TextEditingController();
  TextEditingController _childAgeController = TextEditingController();
  TextEditingController _childGenderController = TextEditingController();
  TextEditingController _assessmentDateController = TextEditingController();

  bool isLoading = true;
  bool isSaving = false;
  String? _selectedGender;
  Map<int, String> selectedAnswers = {};
  Map<String, List<AssessmentQuestion>> parsedData = {};

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

  // Fetch questions from UserApi
  Future<void> fetchQuestions() async {
    parsedData = await Userapi.fetchChildrenQuestions();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> submitAnswersApi(Map<String, dynamic> data) async {
    setState(() {
      isSaving = true;
    });

    var res = await Userapi.submitChildrenAnswers(
        data, "0"); // Change role dynamically

    setState(() {
      isSaving = false;
    });

    if (res["status"] == true) {
      String role = res["role"].toString();
      String resultString = res["result"];
      Map<String, dynamic> resultData = jsonDecode(resultString);
      context.pushReplacement(
          '/result_screen?resultData=${resultData}&role=${role}');
    } else {
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
          'Child Intake Form',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: "general_sans",
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
            // Introduction Section
            const Text(
              'Start with Our Simple Guide',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: "general_sans",
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Get started today by taking our simple guide. It’s quick, easy, and provides actionable insights into your child’s development.',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: "general_sans",
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Take Our Simple Guide Now',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: "general_sans",
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Purpose ',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: "general_sans",
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'To help parents check their child’s developmental milestones and identify early signs of conditions like Autism Spectrum Disorder (ASD), ADHD, Dyslexia, and other developmental delays.',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: "general_sans",
              ),
            ),
            const SizedBox(height: 16),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInputField(
                      "Child's Name", _childNameController, TextInputType.text),
                  _buildInputField(
                      "Age", _childAgeController, TextInputType.number),
                  _buildGenderDropdown(),
                  _buildDatePickerField(
                      "Date of Assessment", _assessmentDateController),
                ],
              ),
            ),

            const SizedBox(height: 20),
            // Questions Section
            isLoading
                ? const Center(
                    child: CircularProgressIndicator()) // Show loader
                : parsedData.isEmpty
                    ? const Center(
                        child: Text(
                        "No questions available",
                        style: TextStyle(
                          fontFamily: "general_sans",
                        ),
                      ))
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  sectionName,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "general_sans",
                                    color: primarycolor,
                                  ),
                                ),
                              ),
                              // Questions List
                              ...questions.map((question) {
                                return Card(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  elevation: 3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          question.question,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontFamily: "general_sans",
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        // Radio Button Options
                                        Column(
                                          children: ["Yes", "No", "Sometimes"]
                                              .map(
                                                (answer) => RadioListTile(
                                                  visualDensity:
                                                      VisualDensity.compact,
                                                  title: Text(
                                                    answer,
                                                    style: TextStyle(
                                                        fontFamily: "Poppins"),
                                                  ),
                                                  value: answer,
                                                  groupValue: selectedAnswers[
                                                      question.id],
                                                  onChanged: (value) {
                                                    setState(() {
                                                      selectedAnswers[
                                                          question.id] = value!;
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
              onPlusTap: isSaving
                  ? null
                  : () {
                      if (_formKey.currentState!.validate()) {
                        // Ensure all answers are provided
                        bool allAnswered = selectedAnswers.values
                            .every((answer) => answer.isNotEmpty);
                        if (!allAnswered) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "Please answer all questions before submitting!")));
                          return;
                        }
                        // Prepare final JSON data for submission
                        Map<String, dynamic> submissionData = {
                          "child_info": {
                            "name": _childNameController.text,
                            "age": _childAgeController.text,
                            "gender": _selectedGender,
                            "assessment_date": _assessmentDateController.text
                          },
                          "role": "0",
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
                        debugPrint(
                            "Final Submission JSON: ${jsonEncode(submissionData)}");
                        submitAnswersApi(submissionData);
                      }
                    },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// Builds a text input field with validation
  Widget _buildInputField(
      String label, TextEditingController controller, TextInputType inputType) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        inputFormatters:
            label == "Age" ? [FilteringTextInputFormatter.digitsOnly] : [],
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            fontFamily: "general_sans",
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          if (label == "Age") {
            final age = int.tryParse(value);
            if (age == null || age <= 0 || age > 100) {
              return "Enter a valid age (1-100)";
            }
          }
          return null;
        },
      ),
    );
  }

  /// Builds a gender dropdown field
  Widget _buildGenderDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: "Gender",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        value: _selectedGender,
        items: ["Male", "Female"].map((gender) {
          return DropdownMenuItem(
            value: gender,
            child: Text(gender),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _selectedGender = value;
          });
        },
        validator: (value) => value == null ? "Please select a gender" : null,
      ),
    );
  }

  /// Builds a date picker field
  Widget _buildDatePickerField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: Icon(Icons.calendar_today),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2100),
          );

          if (pickedDate != null) {
            setState(() {
              controller.text = DateFormat("yyyy-MM-dd").format(pickedDate);
            });
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select a date';
          }
          return null;
        },
      ),
    );
  }
}
