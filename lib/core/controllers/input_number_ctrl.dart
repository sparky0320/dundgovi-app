
// import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class InputNumberController extends GetxController {
  String? text;

  addNumber(int i,onChanged,onCompleted,maxLength) {
    text ??= "";
    if (text!.length >= maxLength!) return;

    text = text! + i.toString();
    if (onChanged != null) onChanged!(text);
    if (text!.length >= maxLength!) {
      if (onCompleted != null) {
        onCompleted!(text);
        return;
      }
    }
  }

  erase(onChanged) {
    if (text != null && text!.isNotEmpty) {
      text = text!.substring(0, text!.length - 1);
      if (onChanged != null) onChanged!(text);
    }
  }

  eraseAll() {
    print('erasel all -------------------- $text');
    text = '';
    update();
    print('text  -------------------- $text');
  }

}
