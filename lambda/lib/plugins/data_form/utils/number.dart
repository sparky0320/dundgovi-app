bool isNumeric(String s) {
  // ignore: unnecessary_null_comparison
  if (s == null) {
    return false;
  }
  // ignore: unnecessary_null_comparison
  return double.parse(s) != null;
}
