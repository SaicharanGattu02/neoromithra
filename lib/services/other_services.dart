import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neuromithra/services/userapi.dart';

import '../Model/LoginModel.dart';
import '../utils/constants.dart';
import 'Preferances.dart';

getheader() async {
  final sessionid = await PreferenceService().getString("token");
  print(sessionid);
  String Token = "Bearer ${sessionid}";
  Map<String, String> a = {
    authorization: Token.toString(),
    'Content-Type': 'application/json'
  };
  return a;
}

getheader2() async {
  final sessionid = await PreferenceService().getString("token");
  print(sessionid);
  String Token = "Bearer ${sessionid}";
  Map<String, String> a = {
    authorization: Token.toString(),
    'Content-Type': 'application/x-www-form-urlencoded'
  };
  return a;
}

getheader1() async {
  final sessionid = await PreferenceService().getString("token");
  print(sessionid);
  String Token = "Bearer ${sessionid}";
  Map<String, String> a = {authorization: Token.toString()};
  return a;
}

CheckHeaderValidity() async {
  String timestamp =
      DateTime.now().millisecondsSinceEpoch.toString().substring(0, 10);
  LoginModel response = LoginModel();
  final token = await PreferenceService().getString("token");
  final validityTimestamp =
      await PreferenceService().getString("access_expiry_timestamp");
  var status = true;
  if (int.parse(validityTimestamp!) <= int.parse(timestamp)) {
    await Userapi.UpdateRefreshToken().then((data) => {
          if (data != null)
            {
              response = data,
              if (response.accessToken != "")
                {
                  PreferenceService()
                      .saveString("access_token", response.accessToken ?? ""),
                  PreferenceService().saveString("access_expiry_timestamp",
                      response.expiresIn.toString() ?? ""),
                  status = true,
                }
              else
                {
                  status = false,
                }
            }
        });
  } else {
    status = true;
  }
  return status;
}

class NoInternetWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/nointernet.png",
              width: 47,
              height: 47,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 48),
              child: Text(
                "Connect to the Internet",
                style: TextStyle(
                    color: Color(0xFF000000),
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 13),
              child: Text(
                "You are Offline. Please Check Your Connection",
                style: TextStyle(
                    color: Color(0xFF000000),
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ),
            GestureDetector(
              onTap: () {
                (context as Element).reassemble();
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 38),
                child: Container(
                  width: 240,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xFF2DB3FF),
                  ),
                  child: const Center(
                    child: Text(
                      "Retry",
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
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
}