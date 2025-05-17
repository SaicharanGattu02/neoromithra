import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:neuromithra/Components/CustomAppButton.dart';
import 'package:neuromithra/Presentation/MainDashBoard.dart';
import 'package:provider/provider.dart';

import '../Model/AssessmentQuestion.dart';
import '../Providers/AssessmentProvider.dart';
import '../services/userapi.dart';
import '../utils/Color_Constants.dart';
import '../utils/constants.dart';
import 'ResultScreen.dart';

class ChildAssessment extends StatefulWidget {
  const ChildAssessment({super.key});

  @override
  State<ChildAssessment> createState() => _ChildAssessmentState();
}

class _ChildAssessmentState extends State<ChildAssessment> {
  final _formKey = GlobalKey<FormState>();
  final _childNameController = TextEditingController();
  final _childAgeController = TextEditingController();
  final _childGenderController = TextEditingController();
  final _assessmentDateController = TextEditingController();
  String? _selectedGender;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AssessmentProvider>(context, listen: false)
          .fetchQuestions("0");
    });
  }

  @override
  void dispose() {
    _childNameController.dispose();
    _childAgeController.dispose();
    _childGenderController.dispose();
    _assessmentDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AssessmentProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Child Intake Form',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontFamily: "general_sans",
            color: primarycolor, // Ensure primarycolor is defined
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
              'Purpose',
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
            provider.isLoading
                ? const Center(child: CircularProgressIndicator(color: primarycolor,))
                : provider.questions.isEmpty
                ? const Center(
              child: Text(
                "No questions available",
                style: TextStyle(fontFamily: "general_sans"),
              ),
            )
                : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: provider.questions.entries.map<Widget>((entry) {
                String sectionName = entry.key;
                List<AssessmentQuestion> questions = entry.value;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
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
                              Column(
                                children: ["Yes", "No", "Sometimes"]
                                    .map(
                                      (answer) => RadioListTile(
                                    visualDensity:
                                    VisualDensity.compact,
                                    title: Text(
                                      answer,
                                      style: const TextStyle(
                                          fontFamily:
                                          "general_sans"),
                                    ),
                                    value: answer,
                                    groupValue: provider
                                        .selectedAnswers[
                                    question.id],
                                    onChanged: (value) {
                                      provider.selectAnswer(
                                          question.id, value!);
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
            CustomAppButton(
              text: 'Submit',
              isLoading: provider.isSaving,
              onPlusTap: provider.isSaving
                  ? null
                  : () {
                if (_formKey.currentState!.validate()) {
                  provider.submitAnswers(
                    context,
                    "0",
                    childInfo: {
                      "name": _childNameController.text,
                      "age": _childAgeController.text,
                      "gender": _selectedGender,
                      "assessment_date": _assessmentDateController.text,
                    },
                  );
                }else{
                  showAnimatedTopSnackBar(
                      context, 'Please Fill Child Details Above!');
                }
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(
      String label, TextEditingController controller, TextInputType inputType) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        style: const TextStyle(
          color: charcoal,
          fontFamily: "general_sans",
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        inputFormatters: label == "Age"
            ? [FilteringTextInputFormatter.digitsOnly]
            : [],
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
              fontFamily: "general_sans",
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: primarycolor, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: primarycolor, width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
          errorStyle: TextStyle(
            color: Colors.red,
            fontSize: 12,
            fontFamily: "general_sans",
          ),
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

  Widget _buildGenderDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: "Gender",
          labelStyle: TextStyle(
              fontFamily: "general_sans",
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: primarycolor, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: primarycolor, width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
          errorStyle: TextStyle(
            color: Colors.red,
            fontSize: 12,
            fontFamily: "general_sans",
          ),
        ),
        value: _selectedGender,
        items: ["Male", "Female"].map((gender) {
          return DropdownMenuItem(
            value: gender,
            child: Text(gender, style: const TextStyle(fontFamily: "general_sans")),
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

  Widget _buildDatePickerField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        style: const TextStyle(
          color: charcoal,
          fontFamily: "general_sans",
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: Icon(Icons.calendar_today_outlined,color: Colors.black,),
          labelStyle: TextStyle(
              fontFamily: "general_sans",
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: primarycolor, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: primarycolor, width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
          ),
          errorStyle: TextStyle(
            color: Colors.red,
            fontSize: 12,
            fontFamily: "general_sans",
          ),
        ),
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2100),
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                    primary: primarycolor, // Header background color
                    onPrimary: Colors.white, // Header text color
                    onSurface: Colors.black, // Body text color
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor: primarycolor, // Button text color
                    ),
                  ),
                ),
                child: child!,
              );
            },
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
