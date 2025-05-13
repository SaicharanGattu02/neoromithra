import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neuromithra/Providers/AddressListProviders.dart';
import 'package:neuromithra/services/userapi.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/SuccessModel.dart';
import '../utils/Color_Constants.dart';
import '../utils/constants.dart';

class AddAddressScreen extends StatefulWidget {
  final String type;
  final String id;
  AddAddressScreen({super.key, required this.type, required this.id});

  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isCurrentChecked = false;
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

  bool current_Loading = false;
  bool permanent_Loading = false;
  String latlongs ="";


  @override
  void initState() {
    super.initState();

    loadLocationDataFromPreferences();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.id != null && widget.id.toString().isNotEmpty) {
        final addressProvider = Provider.of<AddressListProvider>(context, listen: false);

        addressProvider.getAddressDetails(widget.id).then((_) {
            final address = addressProvider.addressesDetails;
            setState(() {
              if (address?.typeOfAddress == 0) {
                isCurrentChecked = true;
                _hNoControllerCurrent.text = address?.flatNo??"";
                _streetControllerCurrent.text = address?.street??"";
                _landmarkControllerCurrent.text = address?.landmark??"";
              } else {
                isPermanentChecked = true;
                _hNoControllerPermanent.text = address?.flatNo??"";
                _streetControllerPermanent.text = address?.street??"";
                _landmarkControllerPermanent.text = address?.landmark??"";
              }
            });

        }).catchError((e) {
          print('Error fetching data: $e');
        });
      }else{
        isCurrentChecked = true;
      }
    });
  }

  Future<void> loadLocationDataFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    final locationName = prefs.getString('location_name') ?? '';
    latlongs = prefs.getString('latlongs') ?? '';
    final area = prefs.getString('area') ?? '';
    final city = prefs.getString('city') ?? '';
    final pincode = prefs.getString('pincode') ?? '';

    // Populate your TextEditingControllers
    setState(() {
      _areaControllerPermanent.text = locationName;
      _pincodeControllerPermanent.text = pincode;

      _areaControllerCurrent.text = locationName;
      _pincodeControllerCurrent.text = pincode;
    });
  }

  Future<void> _submitAddress() async {
    try {
      final addressProvider = Provider.of<AddressListProvider>(context, listen: false);
      Map<String, dynamic> data;

      if (isCurrentChecked) {
        data = {
          "flat_no": _hNoControllerCurrent.text,
          "street": _streetControllerCurrent.text,
          "area": _areaControllerCurrent.text,
          "landmark": _landmarkControllerCurrent.text,
          "pincode": _pincodeControllerCurrent.text,
          "type_of_address": 0,
          "location_access": latlongs,
        };
      } else {
        data = {
          "flat_no": _hNoControllerPermanent.text,
          "street": _streetControllerPermanent.text,
          "area": _areaControllerPermanent.text,
          "landmark": _landmarkControllerPermanent.text,
          "pincode": _pincodeControllerPermanent.text,
          "type_of_address": 1,
          "location_access": latlongs,
        };
      }
      SuccessModel? res;
      if (widget.type == "add") {
         res = await addressProvider.addAddress(data);
      } else {
         res = await addressProvider.editAddress(data, widget.id);
      }
      if(res?.status==true){
        context.pop();
        showAnimatedTopSnackBar(
            context, 'Address ${widget.type == "add" ? "added" : "updated"} successfully');
      }else{
        showAnimatedTopSnackBar(
            context, '${res?.message}');
      }
    } catch (e) {
      print("Address submission failed: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text((widget.type == "add") ? 'Add Address' : "Edit Address",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: "general_sans",
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
      body: Consumer<AddressListProvider>(
        builder: (context, addressProvider, child) {
          return Container(
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
                              visualDensity: VisualDensity.compact,
                              value: isCurrentChecked,
                              activeColor: primarycolor,
                              onChanged: (bool? value) {
                                setState(() {
                                  isCurrentChecked = true;
                                  isPermanentChecked = false;
                                });
                              },
                            ),
                            Text('Current',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "general_sans")),
                          ],
                        ),
                        SizedBox(width: 20), // Spacing between checkboxes
                        Row(
                          children: [
                            Checkbox(
                              visualDensity: VisualDensity.compact,
                              value: isPermanentChecked,
                              activeColor: primarycolor,
                              onChanged: (bool? value) {
                                setState(() {
                                  isPermanentChecked = true;
                                  isCurrentChecked = false;
                                });
                              },
                            ),
                            Text('Permanent',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "general_sans")),
                          ],
                        ),
                      ],
                    ),
                    if (isCurrentChecked) ...[
                      SizedBox(height: 25),
                      Text("Current Address",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: "general_sans")),
                      SizedBox(height: 16),
                      _buildTextField(
                          _hNoControllerCurrent, 'H.No/Flat No', true),
                      SizedBox(height: 16),
                      _buildTextField(_streetControllerCurrent, 'Street', true),
                      SizedBox(height: 16),
                      _buildTextField(
                          _areaControllerCurrent, 'Area/Locality', true),
                      SizedBox(height: 16),
                      _buildTextField(
                          _landmarkControllerCurrent, 'Landmark', true),
                      SizedBox(height: 16),
                      _buildTextField(
                          _pincodeControllerCurrent, 'Pincode', true,
                          isNumeric: true),
                      SizedBox(height: 100),
                      SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              addressProvider.isLoading ? null:_submitAddress();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primarycolor,
                            foregroundColor: primarycolor,
                            disabledForegroundColor: primarycolor,
                            disabledBackgroundColor: primarycolor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: addressProvider.isLoading
                              ? CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 1,
                                )
                              : Text(
                                  'Submit',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontFamily: "general_sans",
                                  ),
                                ),
                        ),
                      )
                    ],
                    if (isPermanentChecked) ...[
                      SizedBox(height: 25),
                      Text("Permanent Address",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              fontFamily: "general_sans")),
                      SizedBox(height: 16),
                      _buildTextField(_hNoControllerPermanent, 'H.No/Flat No',
                          isPermanentChecked),
                      SizedBox(height: 16),
                      _buildTextField(_streetControllerPermanent, 'Street',
                          isPermanentChecked),
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
                      SizedBox(height: 100),
                      SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              addressProvider.isLoading ? null:_submitAddress();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primarycolor,
                            foregroundColor: primarycolor,
                            disabledForegroundColor: primarycolor,
                            disabledBackgroundColor: primarycolor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child:addressProvider.isLoading
                              ? CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 1,
                                )
                              : Text(
                                  'Submit',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontFamily: "general_sans",
                                  ),
                                ),
                        ),
                      )
                    ],
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, bool isRequired,
      {bool isNumeric = false}) {
    return TextFormField(
      controller: controller,
      cursorColor: Colors.black,
      style: TextStyle(
          fontFamily: "general_sans",
          fontWeight: FontWeight.w500,
          fontSize: 17,
          color: Colors.black),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        labelText: label,
        labelStyle: TextStyle(
            fontFamily: "general_sans",
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Colors.black),
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
}
