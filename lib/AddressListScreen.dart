import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:neuromithra/AddAddressScreen.dart';
import 'package:neuromithra/services/userapi.dart';
import 'CustomAppBar.dart';
import 'Model/AddressListModel.dart';

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
    final response = await Userapi.getaddresslist();
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
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () async {
                var result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddAddressScreen(type: "add", id: "", hno: "", street: "", area: "", landmark: "", pincode: "",type_of_address: "0",)),
                );
                if(result==true){
                  setState(() {
                    GetAddressList();
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 24.0),
              ),
              child: Text(
                'Add Address',
                style: TextStyle(color: Colors.white),
              ),
            ),
            if(addresses.length>0)...[
              Expanded(
                child: ListView.builder(
                  itemCount: addresses.length,
                  itemBuilder: (context, index) {
                    var data = addresses[index];
                    return Dismissible(
                      key: Key(data.id.toString()),
                      background: Container(
                        color: Colors.green,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Icon(Icons.edit, color: Colors.white),
                      ),
                      secondaryBackground: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                      confirmDismiss: (direction) async {
                        if (direction == DismissDirection.endToStart) {
                          return await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Delete Address'),
                              content: Text('Are you sure you want to delete this address?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(false),
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      addresses.removeAt(index);
                                    });
                                    Navigator.of(context).pop(true);
                                  },
                                  child: Text('Delete'),
                                ),
                              ],
                            ),
                          );
                        } else if (direction == DismissDirection.startToEnd) {
                          var result= await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AddAddressScreen(type: "edit", id: data.id.toString()??"", hno: data.flatNo??"", street: data.street??"", area: data.area??"", landmark: data.landmark??"", pincode: data.pincode.toString()??"",type_of_address: data.typeOfAddress.toString()??"",)),
                          );
                          if(result==true){
                            setState(() {
                              GetAddressList();
                            });
                          }
                          return false; // Prevent dismiss
                        }
                        return false;
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width - 30, // Full width minus padding
                        child: Card(
                          margin: EdgeInsets.all(8.0),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.area??"",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  "${data.flatNo},${data.street},${data.landmark},${data.pincode}",
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ]else...[
              Center(
                child: Lottie.asset(
                  'assets/animations/nodata1.json',
                  height: 360,
                  width: 360,
                ),
              ),
            ]

          ],
        ),
      ),
    );
  }
}
