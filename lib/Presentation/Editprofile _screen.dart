import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  String? _validateMobileSos1(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your sos1 mobile number';
    }
    if (value.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Please enter a valid 10-digit mobile number';
    }
    return null;
  }

  String? _validateMobileSos2(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your sos2 mobile number';
    }
    if (value.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Please enter a valid 10-digit mobile number';
    }
    return null;
  }

  String? _validateMobileSos3(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your sos3 mobile number';
    }
    if (value.length != 10 || !RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Please enter a valid 10-digit mobile number';
    }
    return null;
  }

  void _submitForm(context) {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      _updateProfileDetails(context);
    } else {
      setState(() {
        isLoading = false;
      });
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

  Future<void> _updateProfileDetails(BuildContext context) async {
    setState(() {
      isLoading = true;
    });

    final result = await Userapi.postProfileDetails(
        _nameController.text, _emailController.text, _mobileController.text);

    setState(() {
      if (result != null && result.containsKey("message")) {
        CustomSnackBar.show(context, '${result["message"]}');
        print("Success: ${result["message"]}");
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Dashboard()));
      } else if (result != null && result.containsKey("error")) {
        CustomSnackBar.show(context, '${result["error"]}');
        print("Error: ${result["error"]}");
      }
      isLoading = false;
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
                // Stack(
                //   children: [
                //     CircleAvatar(
                //       radius: 60,
                //       backgroundColor: const Color(0xff80C4E9),
                //       backgroundImage: _image != null
                //           ? FileImage(_image!)
                //           : (profile_image.isNotEmpty
                //           ? NetworkImage(profile_image)
                //           : null) as ImageProvider?,
                //       child: (_image == null && profile_image.isEmpty)
                //           ? Text(
                //         name.isNotEmpty
                //             ? name[0].toUpperCase()
                //             : "",
                //         style: const TextStyle(
                //             fontSize: 50, color: Color(0xffFFF6E9)),
                //       )
                //           : null,
                //     ),
                //     Positioned(
                //       bottom: 0,
                //       right: 0,
                //       child: GestureDetector(
                //         onTap: _pickImage,
                //         child: CircleAvatar(
                //           radius: 18,
                //           backgroundColor: Colors.grey,
                //           child: image_uploading
                //               ? CircularProgressIndicator(
                //             strokeWidth: 2,
                //             valueColor:
                //             AlwaysStoppedAnimation<Color>(Colors.white),
                //           )
                //               : const Icon(
                //             Icons.edit,
                //             color: Colors.white,
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                // const SizedBox(height: 30),
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
                                : const AssetImage('assets/person.png')
                                    as ImageProvider<Object>,
                        child: _image != null ||
                                (profile_image != null &&
                                    profile_image.isNotEmpty)
                            ? null
                            : Icon(Icons.person, size: 50, color: Colors.white),
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
                              color: primarycolor,
                              size: 20, // Size of the camera icon
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
                        decoration: InputDecoration(
                          labelText: 'Name',
                          labelStyle: TextStyle(
                              fontSize: 15,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          border: OutlineInputBorder(), // Add border
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2.0),
                          ),
                        ),
                        validator: _validateName,
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                              fontSize: 15,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          border: OutlineInputBorder(), // Add border
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2.0),
                          ),
                        ),
                        validator: _validateEmail,
                      ),
                      SizedBox(height: 16), // Space between fields
                      TextFormField(
                        controller: _mobileController,
                        decoration: InputDecoration(
                          labelText: 'Mobile Number',
                          labelStyle: TextStyle(
                              fontSize: 15,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          border: OutlineInputBorder(), // Add border
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2.0),
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: _validateMobile,
                      ),
                      SizedBox(height: 20),
                      // TextFormField(
                      //   controller: _sos1Controller,
                      //   decoration: InputDecoration(
                      //     labelText: 'SOS Mobile Number 1',
                      //     labelStyle: TextStyle(
                      //         fontSize: 15,
                      //         fontFamily: "Inter",
                      //         fontWeight: FontWeight.w400,
                      //         color: Colors.black),
                      //     floatingLabelBehavior: FloatingLabelBehavior.auto,
                      //     border: OutlineInputBorder(), // Add border
                      //     enabledBorder: OutlineInputBorder(
                      //       borderSide:
                      //           BorderSide(color: Colors.grey, width: 1.0),
                      //     ),
                      //     focusedBorder: OutlineInputBorder(
                      //       borderSide:
                      //           BorderSide(color: Colors.blue, width: 2.0),
                      //     ),
                      //   ),
                      //   keyboardType: TextInputType.phone,
                      //   validator: _validateMobileSos1,
                      // ),
                      // SizedBox(height: 20),
                      // TextFormField(
                      //   controller: _sos2Controller,
                      //   decoration: InputDecoration(
                      //     labelText: 'SOS Mobile Number 2',
                      //     labelStyle: TextStyle(
                      //         fontSize: 15,
                      //         fontFamily: "Inter",
                      //         fontWeight: FontWeight.w400,
                      //         color: Colors.black),
                      //     floatingLabelBehavior: FloatingLabelBehavior.auto,
                      //     border: OutlineInputBorder(), // Add border
                      //     enabledBorder: OutlineInputBorder(
                      //       borderSide:
                      //           BorderSide(color: Colors.grey, width: 1.0),
                      //     ),
                      //     focusedBorder: OutlineInputBorder(
                      //       borderSide:
                      //           BorderSide(color: Colors.blue, width: 2.0),
                      //     ),
                      //   ),
                      //   keyboardType: TextInputType.phone,
                      //   // validator: _validateMobileSos2,
                      // ),
                      // SizedBox(height: 20),
                      // TextFormField(
                      //   controller: _sos3Controller,
                      //   decoration: InputDecoration(
                      //     labelText: 'SOS Mobile Number 3',
                      //     labelStyle: TextStyle(
                      //         fontSize: 15,
                      //         fontFamily: "Inter",
                      //         fontWeight: FontWeight.w400,
                      //         color: Colors.black),
                      //     floatingLabelBehavior: FloatingLabelBehavior.auto,
                      //     border: OutlineInputBorder(), // Add border
                      //     enabledBorder: OutlineInputBorder(
                      //       borderSide:
                      //           BorderSide(color: Colors.grey, width: 1.0),
                      //     ),
                      //     focusedBorder: OutlineInputBorder(
                      //       borderSide:
                      //           BorderSide(color: Colors.blue, width: 2.0),
                      //     ),
                      //   ),
                      //   keyboardType: TextInputType.phone,
                      //   // validator: _validateMobileSos3,
                      // ),
                      // SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: ElevatedButton(
          onPressed: isLoading ? null : () => _submitForm(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: primarycolor, // Button Background Color
            padding: EdgeInsets.symmetric(vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 3, // Light shadow for better visibility
          ),
          child: isLoading
              ? SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Text(
                  "Save",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: "Inter",
                    fontWeight: FontWeight.w600,
                  ),
                ),
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
