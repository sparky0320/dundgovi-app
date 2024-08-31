import 'package:intl/intl.dart';

final formatter = new NumberFormat("#,###");
final Formatter = new NumberFormat("#.#");
final FormatterInt = new NumberFormat("#.#");
final formatterFloat = new NumberFormat("#,###.#");

String number(dynamic value) {
  if (value != null) {
    if (value.runtimeType == String) {
      return formatter.format(int.parse(value));
    }
    return formatter.format(value);
  } else {
    return "0";
  }
}

String numberInt(dynamic value) {
  if (value != null) {
    if (value.runtimeType == String) {
      return FormatterInt.format(int.parse(value));
    }
    return FormatterInt.format(value);
  } else {
    return "0";
  }
}

String huvi(dynamic value) {
  if (value != null) {
    if (value.runtimeType == String) {
      return Formatter.format(int.parse(value));
    }
    return Formatter.format(value);
  } else {
    return "0";
  }
}

String float(dynamic value) {
  if (value != null) {
    if (value.runtimeType == String) {
      return formatterFloat.format(double.parse(value));
    }
    return formatterFloat.format(value);
  } else {
    return "0";
  }
}

double getDouble(value) {
  if (value != null) {
    if (value.runtimeType == String) {
      return double.parse(value);
    }
    if (value.runtimeType == double) {
      return value;
    }
    if (value.runtimeType == int) {
      return double.parse(value.toString());
    }
    return 0.0;
  } else {
    return 0.0;
  }
}

// Negative number format for negative number.
String negativeFormatNumber(number) {
  String numberInText = "";
  int counter = 0;
  for (int i = (number.length - 2); i >= 0; i--) {
    counter++;
    String str = number[i];
    if ((counter % 3) != 0 && i != 0) {
      numberInText = "$str$numberInText";
    } else if (i == 0) {
      numberInText = "$str$numberInText";
    } else if (number[i + 1] == ".") {
      numberInText = "$str$numberInText";
    } else {
      numberInText = "$str,$numberInText";
    }
  }
  return numberInText;
}

// Number format for negative number.
String formatNumber(number) {
  String numberInText = "";
  int counter = 0;
  for (int i = (number.length - 1); i >= 0; i--) {
    counter++;
    String str = number[i];
    if ((counter % 3) != 0 && i != 0) {
      numberInText = "$str$numberInText";
    } else if (i == 0) {
      numberInText = "$str$numberInText";
    } else if (number[i + 1] == ".") {
      numberInText = "$str$numberInText";
    } else {
      numberInText = ",$str$numberInText";
    }
  }
  return numberInText;
}
