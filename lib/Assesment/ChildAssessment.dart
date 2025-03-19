import 'package:flutter/material.dart';
import 'package:neuromithra/Components/CustomAppButton.dart';

import '../Model/AssessmentQuestion.dart';
import '../services/userapi.dart';

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

  String communicationAnswer = 'Yes';
  String socialAnswer = 'Yes';
  String motorAnswer = 'Yes';
  String cognitiveAnswer = 'Yes';
  String emotionalAnswer = 'Yes';

  bool isLoading = true;
  Map<int, String> selectedAnswers = {};
  Map<String, List<AssessmentQuestion>> parsedData = {};

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

  // Fetch questions from UserApi
  Future<void> fetchQuestions() async {
    parsedData = await Userapi.fetchQuestions();
    setState(() {
      isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Child Development Assessment',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: "Inter",
            color: Color(0xff3EA4D2),
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xff3EA4D2)),
          onPressed: () => Navigator.pop(context),
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
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            const Text(
              'Get started today by taking our simple guide. It’s quick, easy, and provides actionable insights into your child’s development.',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 20),
            const Text(
              'Take Our Simple Guide Now',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            const Text(
              'Purpose ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              'To help parents check their child’s developmental milestones and identify early signs of conditions like Autism Spectrum Disorder (ASD), ADHD, Dyslexia, and other developmental delays.',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 16),

            // Form Section
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInputField("Child's Name", _childNameController),
                  _buildInputField("Age", _childAgeController),
                  _buildInputField("Gender", _childGenderController),
                  _buildInputField("Date of Assessment", _assessmentDateController),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Questions Section
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
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff3EA4D2),
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
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              // Radio Button Options
                              Column(
                                children: ["Yes", "No", "Sometimes"]
                                    .map(
                                      (answer) => RadioListTile(
                                        visualDensity: VisualDensity.compact,
                                    title: Text(answer),
                                    value: answer,
                                    groupValue:
                                    selectedAnswers[question.id],
                                    onChanged: (value) {
                                      setState(() {
                                        selectedAnswers[question.id] =
                                        value!;
                                      });
                                    },
                                    activeColor: const Color(0xff3EA4D2),
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
              onPlusTap: () {
                if (_formKey.currentState!.validate()) {
                  print('Form Submitted');
                  print('Selected Answers: $selectedAnswers');
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildRadioGroup(String question, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(question),
        Row(
          children: [
            _buildRadioOption('Yes', onChanged),
            _buildRadioOption('Sometimes', onChanged),
            _buildRadioOption('No', onChanged),
          ],
        ),
        SizedBox(height: 12),
      ],
    );
  }

  Widget _buildRadioOption(String value, Function(String) onChanged) {
    return Expanded(
      child: Row(
        children: [
          Radio<String>(
            value: value,
            groupValue: communicationAnswer,
            onChanged: (value) => onChanged(value!),
          ),
          Text(value),
        ],
      ),
    );
  }
}
