import 'package:flutter/material.dart';
import 'package:neuromithra/Components/CustomAppButton.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Child Development Assessment'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title & Description
            Text(
              'Our simple guide\nGet started today by taking our simple guide. It’s quick, easy, and provides actionable insights into your child’s development.',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 20),
            Text(
              'Take our simple guide Now',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 20),
            Text(
              'Purpose ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            Text(
              'To help parents check their child’s developmental milestones and identify early signs of conditions like Autism Spectrum Disorder (ASD), Attention-Deficit/Hyperactivity Disorde (ADHD), Dyslexia, and other developmental delays. General Information Parent Input',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 16),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInputField('Child\'s Name', _childNameController),
                  _buildInputField('Age', _childAgeController),
                  _buildInputField('Gender', _childGenderController),
                  _buildInputField(
                      'Date of Assessment', _assessmentDateController),
                ],
              ),
            ),

            _buildSectionTitle('A. Communication Skills'),
            _buildRadioGroup(
                'Does your child respond to their name when called?', (value) {
              setState(() {
                communicationAnswer = value;
              });
            }),

            _buildRadioGroup(
                'Does your child use gestures (e.g., pointing, waving) to communicate needs?',
                (value) {
              setState(() {
                communicationAnswer = value;
              });
            }),

            _buildRadioGroup(
                'Does your child form sentences appropriate for their age?',
                (value) {
              setState(() {
                communicationAnswer = value;
              });
            }),

            // Social Skills Section
            _buildSectionTitle('B. Social Skills'),
            _buildRadioGroup(
                'Does your child make eye contact during interactions?',
                (value) {
              setState(() {
                socialAnswer = value;
              });
            }),

            _buildRadioGroup(
                'Does your child play or interact with other children?',
                (value) {
              setState(() {
                socialAnswer = value;
              });
            }),

            CustomAppButton(text: 'Submit', onPlusTap: (){
              if (_formKey.currentState!.validate()) {
                        print('Form Submitted');
                      }
            })

            // Submit Button
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 20.0),
            //   child: ElevatedButton(
            //     onPressed: () {
            //       if (_formKey.currentState!.validate()) {
            //         print('Form Submitted');
            //       }
            //     },
            //     child: Text('Submit Assessment'),
            //   ),
            // ),
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
