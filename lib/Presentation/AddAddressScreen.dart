import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neuromithra/Providers/AddressListProviders.dart';
import 'package:neuromithra/services/userapi.dart';
import 'package:provider/provider.dart';

import '../utils/Color_Constants.dart';

class AddAddressScreen extends StatefulWidget {
  final String type; // Type parameter to determine mode
  final String id; // Address ID for editing
  final String hno; // House/Flat Number
  final String street; // Street name
  final String area; // Area/Locality
  final String landmark; // Landmark
  final String pincode; // Pincode
  final String type_of_address; // Pincode

  AddAddressScreen({
    required this.type,
    required this.id,
    required this.hno,
    required this.street,
    required this.area,
    required this.landmark,
    required this.pincode,
    required this.type_of_address,
  });

  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isCurrentChecked = true;
  bool isPermanentChecked = false;
  // Controllers for Current Address
  final TextEditingController _hNoControllerCurrent = TextEditingController();
  final TextEditingController _streetControllerCurrent =
      TextEditingController();
  final TextEditingController _areaControllerCurrent = TextEditingController();
  final TextEditingController _landmarkControllerCurrent =
      TextEditingController();
  final TextEditingController _pincodeControllerCurrent =
      TextEditingController();

  // Controllers for Permanent Address
  final TextEditingController _hNoControllerPermanent = TextEditingController();
  final TextEditingController _streetControllerPermanent =
      TextEditingController();
  final TextEditingController _areaControllerPermanent =
      TextEditingController();
  final TextEditingController _landmarkControllerPermanent =
      TextEditingController();
  final TextEditingController _pincodeControllerPermanent =
      TextEditingController();

  bool _isSameAddress = false;
  bool _addPermanentAddress = false; // Optional permanent address toggle
  bool current_Loading = false;
  bool permanent_Loading = false;
  @override
  void initState() {
    super.initState();
    if (widget.type_of_address == "0") {
      _hNoControllerCurrent.text = widget.hno;
      _streetControllerCurrent.text = widget.street;
      _areaControllerCurrent.text = widget.area;
      _landmarkControllerCurrent.text = widget.landmark;
      _pincodeControllerCurrent.text = widget.pincode;
      isCurrentChecked = true;
    } else {
      _hNoControllerPermanent.text = widget.hno;
      _streetControllerPermanent.text = widget.street;
      _areaControllerPermanent.text = widget.area;
      _landmarkControllerPermanent.text = widget.landmark;
      _pincodeControllerPermanent.text = widget.pincode;
      isPermanentChecked = true;
      isCurrentChecked = false;
    }
  }

  Future<void> addAddress() async {
    var typeOfAddress = isCurrentChecked ? 0 : 1;
    Map<String, dynamic> data = {};
    if (typeOfAddress == 0) {
      data = {
        "Flat_no": _hNoControllerCurrent.text,
        "street": _streetControllerCurrent.text,
        "area": _areaControllerCurrent.text,
        "landmark": _landmarkControllerCurrent.text,
        "pincode": _pincodeControllerCurrent.text,
        "address_type": typeOfAddress,
      };
    } else {
      data = {
        "Flat_no": _hNoControllerCurrent.text,
        "street": _streetControllerCurrent.text,
        "area": _areaControllerCurrent.text,
        "landmark": _landmarkControllerCurrent.text,
        "pincode": _pincodeControllerCurrent.text,
        "address_type": typeOfAddress,
      };
    }
    Provider.of<AddressListProvider>(context,listen: false).addAddress(data);
  }

  Future<void> editAddress() async {
    var typeOfAddress = isCurrentChecked ? 0 : 1;
    Map<String, dynamic> data = {};
    if (typeOfAddress == 0) {
      data = {
        "Flat_no": _hNoControllerCurrent.text,
        "street": _streetControllerCurrent.text,
        "area": _areaControllerCurrent.text,
        "landmark": _landmarkControllerCurrent.text,
        "pincode": _pincodeControllerCurrent.text,
        "address_type": typeOfAddress,
      };
    } else {
      data = {
        "Flat_no": _hNoControllerCurrent.text,
        "street": _streetControllerCurrent.text,
        "area": _areaControllerCurrent.text,
        "landmark": _landmarkControllerCurrent.text,
        "pincode": _pincodeControllerCurrent.text,
        "address_type": typeOfAddress,
      };
    }
    Provider.of<AddressListProvider>(context,listen: false).EditAddress(data,widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text((widget.type == "add") ? 'Add Address' : "Edit Address",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: "Inter",
                color: primarycolor,
                fontSize: 18)),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton.filled(
          icon: Icon(Icons.arrow_back, color: primarycolor), // Icon color
          onPressed: () => context.pop(),
          style: IconButton.styleFrom(
            backgroundColor: Color(0xFFECFAFA), // Filled color
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: isCurrentChecked,
                          activeColor: primarycolor,
                          onChanged: (bool? value) {
                            setState(() {
                              isCurrentChecked = true;
                              isPermanentChecked = false;
                            });
                          },
                        ),
                        Text('Current'),
                      ],
                    ),
                    SizedBox(width: 20), // Spacing between checkboxes
                    Row(
                      children: [
                        Checkbox(
                          value: isPermanentChecked,
                          activeColor: primarycolor,
                          onChanged: (bool? value) {
                            setState(() {
                              isPermanentChecked = true;
                              isCurrentChecked = false;
                            });
                          },
                        ),
                        Text('Permanent'),
                      ],
                    ),
                  ],
                ),
                if (isCurrentChecked) ...[
                  Text("Current Address",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Inter")),
                  SizedBox(height: 16),
                  _buildTextField(_hNoControllerCurrent, 'H.No/Flat No', true),
                  SizedBox(height: 16),
                  _buildTextField(_streetControllerCurrent, 'Street', true),
                  SizedBox(height: 16),
                  _buildTextField(
                      _areaControllerCurrent, 'Area/Locality', true),
                  SizedBox(height: 16),
                  _buildTextField(_landmarkControllerCurrent, 'Landmark', true),
                  SizedBox(height: 16),
                  _buildTextField(_pincodeControllerCurrent, 'Pincode', true,
                      isNumeric: true),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (current_Loading) return;
                        setState(() {
                          current_Loading = true;
                          if (widget.type == "add") {
                            addAddress();
                          } else {
                            editAddress();
                          }
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primarycolor,
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: (current_Loading)
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text('Submit',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontFamily: "Poppins")),
                  ),
                ],
                SizedBox(height: 25),
                if (isPermanentChecked) ...[
                  Text("Permanent Address",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Inter")),
                  SizedBox(height: 16),
                  _buildTextField(_hNoControllerPermanent, 'H.No/Flat No',
                      isPermanentChecked),
                  SizedBox(height: 16),
                  _buildTextField(
                      _streetControllerPermanent, 'Street', isPermanentChecked),
                  SizedBox(height: 16),
                  _buildTextField(_areaControllerPermanent, 'Area/Locality',
                      isPermanentChecked),
                  SizedBox(height: 16),
                  _buildTextField(_landmarkControllerPermanent, 'Landmark',
                      isPermanentChecked),
                  SizedBox(height: 16),
                  _buildTextField(_pincodeControllerPermanent, 'Pincode',
                      isPermanentChecked,
                      isNumeric: true),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (permanent_Loading) return;
                        setState(() {
                          permanent_Loading = true;
                          if (widget.type == "add") {
                            addAddress();
                          } else {
                            editAddress();
                          }
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: (permanent_Loading)
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text('Submit',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontFamily: "Inter")),
                  ),
                ],
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, bool isRequired,
      {bool isNumeric = false}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
            fontFamily: "Inter",
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.black),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.2),
            borderRadius: BorderRadius.circular(10.0)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.2),
            borderRadius: BorderRadius.circular(10.0)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.2),
            borderRadius: BorderRadius.circular(10.0)),
      ),
      keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
      validator: (value) {
        if (isRequired && (value == null || value.isEmpty)) {
          return 'Please enter $label';
        }
        if (label == 'Pincode' && value != null && value.isNotEmpty) {
          if (!RegExp(r'^\d{6}$').hasMatch(value)) {
            return 'Please enter a valid 6-digit pincode';
          }
        }
        return null;
      },
    );
  }

  void _clearFields() {
    _hNoControllerPermanent.clear();
    _streetControllerPermanent.clear();
    _areaControllerPermanent.clear();
    _landmarkControllerPermanent.clear();
    _pincodeControllerPermanent.clear();
    // setState(() {
    //   _isSameAddress = false;
    //   _addPermanentAddress = false; // Reset the toggle
    // });
  }
}
