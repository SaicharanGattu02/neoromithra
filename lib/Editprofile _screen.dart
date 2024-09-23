import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'FirstLetterCaps.dart'; // For image picking
class EditProfileScreen extends StatefulWidget {
  final String? userName;
  final String? userEmail;
  final String? profileImageUrl;

  const EditProfileScreen({
    Key? key,
    this.userName,
    this.userEmail,
    this.profileImageUrl,
  }) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreen();
}

class _EditProfileScreen extends State<EditProfileScreen> {
  File? _image;
  final picker = ImagePicker();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  String profile_image = "";
  bool is_loading = false;

  @override
  void initState() {
    super.initState();
    // Initialize the controllers with the passed data (if available)
    _nameController.text = widget.userName ?? "";
    _emailController.text = widget.userEmail ?? "";
    profile_image = widget.profileImageUrl ?? "";
  }

  // Method to pick an image from gallery
  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: const Color(0xff80C4E9),
                  backgroundImage: _image != null
                      ? FileImage(_image!)
                      : (profile_image.isNotEmpty
                      ? NetworkImage(profile_image)
                      : null) as ImageProvider?,
                  child: (_image == null && profile_image.isEmpty)
                      ? Text(
                    _nameController.text.isNotEmpty
                        ? _nameController.text[0].toUpperCase()
                        : "",
                    style: const TextStyle(fontSize: 50, color: Color(0xffFFF6E9)),
                  )
                      : null,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.grey,
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildTextField(
              "Name",
              _nameController,
              TextInputType.text,
              "",
              FocusNode(),
              r'^[a-zA-Z\s]+$',
              0,
              [CapitalizationInputFormatter()],
            ),
            const SizedBox(height: 20),
            _buildTextField(
              "Email",
              _emailController,
              TextInputType.emailAddress,
              "",
              FocusNode(),
              r'[a-zA-Z0-9@._-]',
              0,
              [],
            ),

            _buildTextField(
              "Phone number",
              _emailController,
              TextInputType.emailAddress,
              "",
              FocusNode(),
              r'[a-zA-Z0-9@._-]',
              0,
              [],
            ),
            const SizedBox(height: 50),
            GestureDetector(
              onTap: () {
                if (!is_loading) {

                }
              },
              child: Container(
                width: 240,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xFF2DB3FF),
                ),
                child: Center(
                  child: is_loading
                      ? CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                      : const Text(
                    "Save",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildTextField(
      String labelText,
      TextEditingController controller,
      TextInputType keyboardType,
      String hintText,
      FocusNode focusNode,
      String validationRegex,
      int maxLength,
      List<TextInputFormatter> inputFormatters,
      ) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      maxLength: maxLength > 0 ? maxLength : null,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $labelText';
        } else if (!RegExp(validationRegex).hasMatch(value)) {
          return 'Invalid $labelText';
        }
        return null;
      },
    );
  }


// Other methods like _validateFields(), _buildTextField() remain the same
}
