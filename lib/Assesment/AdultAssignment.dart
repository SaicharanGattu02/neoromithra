import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../Components/CustomAppButton.dart';
import '../Model/AssessmentQuestion.dart';
import '../Presentation/MainDashBoard.dart';
import '../Providers/AssessmentProvider.dart';
import '../services/userapi.dart';
import '../utils/Color_Constants.dart';
import 'ResultScreen.dart';

class Adultassignment extends StatefulWidget {
  const Adultassignment({super.key});

  @override
  State<Adultassignment> createState() => _AdultassignmentState();
}

class _AdultassignmentState extends State<Adultassignment> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AssessmentProvider>(context, listen: false).fetchQuestions("1");
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AssessmentProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Adult Intake Form',
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
            const Center(
              child: Text(
                'Start with Our Simple Guide',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  height: 1,
                  fontFamily: "general_sans",
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Go through our guide or schedule a counseling session. Begin your journey toward mental wellness with personalized support.',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: "general_sans",
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Here’s a simple guide designed to help individuals reflect on different aspects of their lives and identify areas for improvement:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: "general_sans",
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Instructions: For each of the following statements, rate yourself on a scale from 1 to 5, where:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: "general_sans",
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              '1 = Strongly Disagree\n2 = Disagree\n3 = Neutral\n4 = Agree\n5 = Strongly Agree',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                fontFamily: "general_sans",
              ),
            ),
            const SizedBox(height: 20),
            provider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...provider.questions.entries.map((entry) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry.key,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: "general_sans",
                            color: primarycolor,
                          ),
                        ),
                        ...entry.value.map((question) {
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
                                      fontSize: 15,
                                      fontFamily: "general_sans",
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  // Radio Button Options
                                  Column(
                                    children: [
                                      "Strongly Disagree",
                                      "Disagree",
                                      "Neutral",
                                      "Agree",
                                      "Strongly Agree",
                                    ].map((answer) {
                                      return RadioListTile(
                                        visualDensity:
                                        VisualDensity.compact,
                                        title: Text(
                                          answer,
                                          style: const TextStyle(
                                            fontFamily: "general_sans",
                                          ),
                                        ),
                                        value: answer,
                                        groupValue: provider
                                            .selectedAnswers[question.id],
                                        onChanged: (value) {
                                          provider.selectAnswer(
                                              question.id, value!);
                                        },
                                        activeColor: primarycolor,
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    );
                  }).toList(),
                  const SizedBox(height: 20),
                  CustomAppButton(
                    text: 'Submit',
                    isLoading: provider.isSaving,
                    onPlusTap: provider.isSaving
                        ? null
                        : () {
                      provider.submitAnswers(context,"1");
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
