import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


final spinkits = Spinkits1();

class Spinkits1 {
  Widget getSpinningLinespinkit() {
    return SizedBox(
      height: 20,
      width: 55,
      child: SpinKitSpinningLines(
        color: Color(0xff27BDBE),
      ),
    );
  }
}

class StringUtils {
  /// Capitalizes the first letter of a string while keeping the rest unchanged.
  static String capitalizeFirstLetter(String? text) {
    if (text == null || text.isEmpty) return '';
    return text[0].toUpperCase() + text.substring(1);
  }
}
