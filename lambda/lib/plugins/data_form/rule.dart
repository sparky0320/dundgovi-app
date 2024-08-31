import 'utils/form_field_validator.dart';

dynamic getRule(String type, {String msg = ""}) {
  switch (type) {
    case "required":
      {
        return FormBuilderValidators.required(
            // ignore: unnecessary_null_comparison
            errorText: msg != null ? msg : 'Талбарыг бөглөнө үү!');
      }
    case "email":
      {
        return FormBuilderValidators.email(
            errorText: msg != '' ? msg : 'Имэйл хаягаа зөв оруулна уу!');
      }
    default:
      {
        return null;
      }
  }
}
