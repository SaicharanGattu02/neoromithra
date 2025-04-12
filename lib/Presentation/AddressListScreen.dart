import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:neuromithra/Presentation/AddAddressScreen.dart';
import 'package:neuromithra/services/userapi.dart';
import 'CustomAppBar.dart';
import '../Model/AddressListModel.dart';

class AddressListScreen extends StatefulWidget {
  @override
  _AddressListScreenState createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {
  bool is_loading=true;
  @override
  void initState() {
    super.initState();
    GetAddressList();
  }
  List<Address> addresses=[];
  Future<void> GetAddressList() async {
    final response = await Userapi.getAddressList();
    setState(() {
      if (response?.status==true) {
        is_loading=false;
        addresses=response?.address??[];
      }else{
        is_loading=false;
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( 'Address List',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: "Inter",
                color: Color(0xff3EA4D2),
                fontSize: 18)),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton.filled(
          icon: Icon(Icons.arrow_back, color: Color(0xff3EA4D2)), // Icon color
          onPressed: () => Navigator.pop(context),
          style: IconButton.styleFrom(
            backgroundColor: Color(0xFFECFAFA), // Filled color
          ),
        ),
      ),
      body: (is_loading)?Center(child: CircularProgressIndicator(color: Colors.blue,)):
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () async {
                  var result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddAddressScreen(
                        type: "add",
                        id: "",
                        hno: "",
                        street: "",
                        area: "",
                        landmark: "",
                        pincode: "",
                        type_of_address: "0",
                      ),
                    ),
                  );
                  if (result == true) {
                    setState(() {
                      GetAddressList();
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF3EA4D2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  elevation: 2,
                ),
                icon: Icon(Icons.add, color: Colors.white),
                label: Text(
                  'Add Address',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600,fontFamily: "Poppins"),
                ),
              ),
            ),

            SizedBox(height: 15),

            // Address List
            if (addresses.isNotEmpty) ...[
              Expanded(
                child: ListView.builder(
                  itemCount: addresses.length,
                  itemBuilder: (context, index) {
                    var data = addresses[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Location Icon + Area
                            Row(
                              children: [
                                Icon(Icons.location_on, color: Colors.red, size: 22),
                                SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    data.area ?? "Unknown Area",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      fontFamily: "Inter",
                                      color: Colors.blueGrey[800],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.0),

                            // Address Details
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.home, color: Colors.blueAccent, size: 20),
                                SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    "${data.flatNo}, ${data.street}, ${data.landmark}",
                                    style: TextStyle(fontSize: 15.0, color: Colors.black87, fontFamily: "Inter",),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 6.0),

                            // Pincode with Icon
                            Row(
                              children: [
                                Icon(Icons.pin_drop, color: Colors.green, size: 20),
                                SizedBox(width: 6),
                                Text(
                                  data.pincode.toString(),
                                  style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: Colors.black87, fontFamily: "Inter",),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ] else ...[
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/animations/nodata1.json',
                      height: 280,
                      width: 280,
                    ),
                    SizedBox(height: 15),
                    Text(
                      "No addresses found",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.blueGrey),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
