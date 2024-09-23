import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'FirstLetterCaps.dart'; // For image picking
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

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
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? _image;
  final picker = ImagePicker();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  String profile_image = "";
  bool is_loading = false;
  bool image_uploading = false;

  final String userId = "20"; // Static User ID

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.userName ?? "";
    _emailController.text = widget.userEmail ?? "";
    profile_image = widget.profileImageUrl ?? "";
  }

  // Method to pick an image from gallery and upload it
  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _uploadImage(_image!); // Trigger image upload
      } else {
        print('No image selected.');
      }
    });
  }

  // Method to upload image to the server
  Future<void> _uploadImage(File image) async {
    setState(() {
      image_uploading = true;
    });

    // API endpoint
    final String url = 'https://admin.neuromitra.com/api/update_profile_image/20';

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers['Authorization'] = 'Bearer token_here'; // Add token if required

      // Attach image file
      var mimeType = lookupMimeType(image.path);
      var multipartFile = await http.MultipartFile.fromPath(
        'user_profile', // Parameter name expected by the API
        image.path,
        contentType: mimeType != null ? MediaType.parse(mimeType) : null,
      );
      request.files.add(multipartFile);

      // Send request
      var response = await request.send();
      if (response.statusCode == 200) {
        setState(() {
          profile_image = image.path; // Use file path as mock for uploaded image URL
        });
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
          SnackBar(content: Text('Image uploaded successfully!')),
        );
      } else {
        print('Image upload failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }

    setState(() {
      image_uploading = false;
    });
  }

  // Method to update user details
  Future<void> _updateProfileDetails() async {
    // Validate input fields
    if (_nameController.text.isEmpty) {
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        SnackBar(content: Text('Please enter your name')),
      );
      return;
    }

    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        SnackBar(content: Text('Please enter your email')),
      );
      return;
    }

    if (_phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        SnackBar(content: Text('Please enter your phone number')),
      );
      return;
    }

    setState(() {
      is_loading = true;
    });

    final String url = 'https://admin.neuromitra.com/api/update_user_details/20';

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer token_here', // Add token if required
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': _nameController.text,
          'email': _emailController.text,
          'phone': _phoneController.text,
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
          SnackBar(content: Text('Profile details updated successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
          SnackBar(
            content: Text('Failed to update details: ${response.statusCode}'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        SnackBar(
          content: Text('Error updating profile: $e'),
        ),
      );
    }

    setState(() {
      is_loading = false;
    });
  }



  @override
  Widget build(BuildContext context) {
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
                    style: const TextStyle(
                        fontSize: 50, color: Color(0xffFFF6E9)),
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
                      child: image_uploading
                          ? CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                          : const Icon(
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
              r'[a-zA-Z0-9@._-]+',
              0,
              [],
            ),
            const SizedBox(height: 20),
            _buildTextField(
              "Phone number",
              _phoneController,
              TextInputType.phone,
              "",
              FocusNode(),
              r'^\d+$', // Validation for numbers only
              10, // Max length 10 for phone number
              [],
            ),
            const SizedBox(height: 50),
            GestureDetector(
              onTap: () {
                if (!is_loading && !image_uploading) {
                  _updateProfileDetails(); // Update profile details
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
                    valueColor:
                    AlwaysStoppedAnimation<Color>(Colors.white),
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
}

