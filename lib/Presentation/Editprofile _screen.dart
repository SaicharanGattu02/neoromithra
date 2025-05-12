import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neuromithra/services/userapi.dart';
import 'package:neuromithra/utils/CustomSnackBar.dart';
import 'package:provider/provider.dart';

import '../Providers/UserProvider.dart';
import '../utils/Color_Constants.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProviders>(context, listen: false).getProfileDetails();
    });
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();

  String name = "";

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    if (!RegExp(pattern).hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your mobile number';
    }
    if (value.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Please enter a valid 10-digit mobile number';
    }
    return null;
  }

  void _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      FormData formData = FormData.fromMap({
        "name": _nameController.text,
        "email": _emailController.text,
        "contact": _mobileController.text,
        "password": _pwdController.text,
        "profile_pic": _image != null
            ? await MultipartFile.fromFile(_image!.path,
                filename: _image!.path.split('/').last)
            : null,
      });
      try {
        final res = await Provider.of<UserProviders>(context, listen: false)
            .updateProfileDetails(formData);
        if (res == true) {
          context.pop();
        }
      } catch (e) {
        print("Error submitting form: $e");
        // Show error to user (e.g., using a SnackBar)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to update profile: $e")),
        );
      }
    } else {
      print("Form validation failed");
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  File? _image;
  final picker = ImagePicker();
  String profile_image = "";
  bool is_loading = true;
  bool isLoading = false;
  bool image_uploading = false;

  final String userId = "20"; // Static User ID

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path); // Trigger image upload
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: "Inter",
                color: primarycolor,
                fontSize: 18)),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton.filled(
          icon: Icon(Icons.arrow_back, color: primarycolor), // Icon color
          onPressed: () => Navigator.pop(context),
          style: IconButton.styleFrom(
            backgroundColor: Color(0xFFECFAFA), // Filled color
          ),
        ),
      ),
      body: Consumer<UserProviders>(
        builder: (context, profileProvider, child) {
          if (profileProvider.isLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }
          _nameController.text = profileProvider.userData.name ?? '';
          _emailController.text = profileProvider.userData.email ?? '';
          _mobileController.text =
              profileProvider.userData.contact?.toString() ?? '';

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey,
                        backgroundImage: _image != null
                            ? FileImage(_image!)
                            : (profile_image != null &&
                                    profile_image.isNotEmpty)
                                ? CachedNetworkImageProvider(profile_image)
                                    as ImageProvider
                                : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: _pickImage,
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.camera_alt,
                              color:
                                  primarycolor, // Ensure primarycolor is defined
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _nameController,
                        cursorColor: Colors.black,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontFamily: "general_sans"),
                        decoration: InputDecoration(
                          labelText: 'Name',
                          labelStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontFamily: "general_sans"),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey.shade500),
                          ), // Normal border
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey.shade500),
                          ), // Focused border
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey.shade500),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey.shade500),
                          ),
                          errorStyle: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontFamily: "general_sans",
                          ),
                        ),
                        validator: _validateName,
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _emailController,
                        cursorColor: Colors.black,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontFamily: "general_sans"),
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontFamily: "general_sans"),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey.shade500),
                          ), // Normal border
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey.shade500),
                          ), // Focused border
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey.shade500),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey.shade500),
                          ),
                          errorStyle: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontFamily: "general_sans",
                          ),
                        ),
                        validator: _validateEmail,
                      ),
                      SizedBox(height: 16), // Space between fields
                      TextFormField(
                        controller: _mobileController,
                        cursorColor: Colors.black,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontFamily: "general_sans"),
                        decoration: InputDecoration(
                          labelText: 'Mobile Number',
                          labelStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontFamily: "general_sans"),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey.shade500),
                          ), // Normal border
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey.shade500),
                          ), // Focused border
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey.shade500),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey.shade500),
                          ),
                          errorStyle: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontFamily: "general_sans",
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: _validateMobile,
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _pwdController,
                        cursorColor: Colors.black,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontFamily: "general_sans"),
                        decoration: InputDecoration(
                          labelText: 'Enter Your Password',
                          labelStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontFamily: "general_sans"),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey.shade500),
                          ), // Normal border
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey.shade500),
                          ), // Focused border
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey.shade500),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey.shade500),
                          ),
                          errorStyle: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontFamily: "general_sans",
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Consumer<UserProviders>(
        builder: (context, userDetails, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: 48,
              child: ElevatedButton(
                  onPressed: isLoading ? null : () => _submitForm(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primarycolor, // Button Background Color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0, // Light shadow for better visibility
                  ),
                  child: userDetails.isSaving
                      ? SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Text(
                          "Save",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: "general_sans",
                            fontWeight: FontWeight.w600,
                          ),
                        )),
            ),
          );
        },
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
