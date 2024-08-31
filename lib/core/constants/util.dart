import 'package:flutter/material.dart';
import 'package:move_to_earn/core/constants/values.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Util {
  static Color fromHex(String hexString) {
    if ((hexString == "")) {
      return Colors.black;
    }
    final buffer = StringBuffer();
    if (hexString.startsWith("rgba(")) {
      hexString = hexString.substring(
          hexString.indexOf("(") + 1, hexString.lastIndexOf(")"));
      List<String> ls = hexString.split(",");
      return Color.fromRGBO(
          int.parse(ls[0]), int.parse(ls[1]), int.parse(ls[2]), 1);
    } else {
      if (hexString.startsWith("#")) {
        hexString = hexString.substring(1, hexString.length);
      }
      if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
      buffer.write(hexString);
      return Color(int.parse(buffer.toString(), radix: 16));
    }
  }

  static reserveFormat(amount) {
    var reserved = amount.substring(0, amount.length).replaceAll(',', '');
    var intParsed = int.parse(reserved);
    return intParsed;
  }

  static reserveFormatNumber(amount) {
    var reserved = amount.substring(2, amount.length).replaceAll(',', '');
    var intParsed = int.parse(reserved);
    return intParsed;
  }

  static reserveFormatNumberDouble(amount) {
    var reserved = amount.substring(2, amount.length).replaceAll(',', '');
    var intParsed = double.parse(reserved);
    return intParsed;
  }

  static Future<String> initVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    versionCode = version + "+" + buildNumber;
    print(versionCode);
    // device = await getDeviceInfo();
    return versionCode;
  }

  static String abbreviateNumber(int number) {
    if (number < 1000) {
      return number.toString();
    } else if (number < 1000000) {
      double num = number / 1000.0;
      return num.toStringAsFixed(num.truncateToDouble() == num ? 0 : 1) + 'K';
    } else {
      double num = number / 1000000.0;
      return num.toStringAsFixed(num.truncateToDouble() == num ? 0 : 1) + 'M';
    }
  }

  static Map<String, dynamic> convertNestedJson(Map<String, dynamic> nestedJson,
      [String prefix = ""]) {
    Map<String, dynamic> flatJson = {};

    nestedJson.forEach((String key, dynamic value) {
      if (value is Map<String, dynamic>) {
        flatJson.addAll(convertNestedJson(value, "$prefix$key."));
      } else {
        flatJson["$key"] = value;
      }
    });
    return flatJson;
  }
}
