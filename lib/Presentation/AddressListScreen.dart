import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:neuromithra/Presentation/AddAddressScreen.dart';
import 'package:neuromithra/Providers/AddressListProviders.dart';
import 'package:neuromithra/services/userapi.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../Components/Shimmers.dart';
import '../utils/Color_Constants.dart';
import 'CustomAppBar.dart';
import '../Model/AddressListModel.dart';

class AddressListScreen extends StatefulWidget {
  @override
  _AddressListScreenState createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<AddressListProvider>(context, listen: false).getAddressList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Address List',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: "general_sans",
                  color: primarycolor,
                  fontSize: 18)),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton.filled(
            icon: Icon(Icons.arrow_back, color: primarycolor),
            onPressed: () => Navigator.pop(context),
            style: IconButton.styleFrom(
              backgroundColor: Color(0xFFECFAFA), // Filled color
            ),
          ),
          actions: [
            SizedBox(
              height: 30,
              child: OutlinedButton.icon(
                onPressed: () async {
                  // context.push("/add_address?type=add&id=");
                  context.push("/select_location?type=add&id=");
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: primarycolor, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                ),
                icon: Icon(Icons.add, color: primarycolor),
                label: Text(
                  'Add',
                  style: TextStyle(
                    color: primarycolor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: "general_sans",
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            )
          ],
        ),
        body: Consumer<AddressListProvider>(
          builder: (context, addressListProvider, child) {
            if (addressListProvider.isLoading) {
              // Show shimmer while loading
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                child: ListView.builder(
                  itemCount: 10,
                  padding: EdgeInsets.only(top: 10),
                  itemBuilder: (_, __) => addressShimmerCard(context),
                ),
              );
            }
            if (addressListProvider.addresses.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/noaddress.png",
                        width: 220,
                        height: 220,
                      ),
                      SizedBox(height: 16),
                      Text(
                        "No addresses found",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: "general_sans",
                          color: Colors.grey[800],
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Tap the button below to add your first address.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontFamily: "general_sans",
                        ),
                      ),
                      SizedBox(height: 20),
                      OutlinedButton.icon(
                        onPressed: () {
                          context.push("/select_location?type=add&id=");
                        },
                        icon: Icon(Icons.add_location_alt, color: primarycolor),
                        label: Text(
                          "Add Address",
                          style: TextStyle(
                            color: primarycolor,
                            fontWeight: FontWeight.w600,
                            fontFamily: "general_sans",
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: primarycolor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }

            // If data exists
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: ListView.separated(
                itemCount: addressListProvider.addresses.length,
                separatorBuilder: (_, __) => SizedBox(height: 12),
                itemBuilder: (context, index) {
                  var data = addressListProvider.addresses[index];

                  return Card(
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Top row: Address type + action buttons
                          Row(
                            children: [
                              Icon(Icons.location_on, color: Colors.red, size: 22),
                              SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  data.typeOfAddress == 0 ? "Current Address" : "Permanent Address",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    fontFamily: "general_sans",
                                    color: Colors.blueGrey[800],
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton.filled(
                                    onPressed: () async {
                                      context.push("/select_location?type=edit&id=${data.id}");
                                    },
                                    icon: Icon(Icons.edit, size: 18),
                                    style: IconButton.styleFrom(
                                      backgroundColor:
                                      primarycolor.withOpacity(0.1),
                                      foregroundColor: primarycolor,
                                      padding: EdgeInsets.all(8),
                                      minimumSize: Size(36, 36),
                                    ),
                                    tooltip: 'Edit',
                                  ),
                                  SizedBox(width: 8),
                                  IconButton.filled(
                                    onPressed: () async {
                                      final confirm = await showDialog<bool>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                            title: Text(
                                              'Delete Address',
                                              style: TextStyle(
                                                fontFamily: "general_sans",
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18,
                                              ),
                                            ),
                                            content: Text(
                                              'Are you sure you want to delete this address?',
                                              style: TextStyle(
                                                fontFamily: "general_sans",
                                                fontWeight: FontWeight.w600,
                                                color: Colors.grey,
                                                fontSize: 15,
                                              ),
                                            ),
                                            actions: [
                                              OutlinedButton(
                                                onPressed: () => Navigator.of(context).pop(false),
                                                style: OutlinedButton.styleFrom(
                                                  side: BorderSide(color: Colors.grey),
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                ),
                                                child: Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                    fontFamily: "general_sans",
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.grey[800],
                                                  ),
                                                ),
                                              ),
                                              ElevatedButton(
                                                onPressed: () => Navigator.of(context).pop(true),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.red,
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                ),
                                                child: Text(
                                                  'Delete',
                                                  style: TextStyle(
                                                    fontFamily: "general_sans",
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );

                                      if (confirm == true) {
                                        // Call delete method from provider
                                        await addressListProvider.deleteAddress(data.id);
                                      }
                                    },
                                    icon: Icon(Icons.delete, size: 18),
                                    style: IconButton.styleFrom(
                                      backgroundColor:
                                      Colors.red.shade50,
                                      foregroundColor: Colors.red,
                                      padding: EdgeInsets.all(8),
                                      minimumSize: Size(36, 36),
                                    ),
                                    tooltip: 'Delete',
                                  ),
                                ],
                              ),
                            ],
                          ),

                          SizedBox(height: 8),

                          /// Address Line
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons. home_outlined, color:primarycolor, size: 20),
                              SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  "${data.flatNo}, ${data.street}, ${data.landmark}, ${data.area}",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black87,
                                    fontFamily: "general_sans",
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 6),

                          /// Pincode
                          Row(
                            children: [
                              Icon(Icons.pin_drop_outlined, color:primarycolor, size: 20),
                              SizedBox(width: 6),
                              Text(
                                data.pincode.toString(),
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                  fontFamily: "general_sans",
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            );
          },
        ));
  }

  Widget addressShimmerCard(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 15),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 📍 Location row
          Row(
            children: [
              shimmerCircle(20, context),
              SizedBox(width: 8),
              shimmerText(120, 14, context),
            ],
          ),
          SizedBox(height: 12),

          // 🏠 Address details row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              shimmerCircle(20, context),
              SizedBox(width: 8),
              Expanded(child: shimmerText(double.infinity, 14, context)),
            ],
          ),
          SizedBox(height: 12),

          // 📌 Pincode row
          Row(
            children: [
              shimmerCircle(20, context),
              SizedBox(width: 8),
              shimmerText(80, 14, context),
            ],
          ),
        ],
      ),
    );
  }
}
