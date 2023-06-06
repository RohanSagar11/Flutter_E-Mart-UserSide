import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/views/auth_screen/widgets/text_style.dart';

Widget customTextfield({label, hint, controller, isDesc = false}) {
  return TextFormField(
    
    style: TextStyle(color: white),
    maxLines: isDesc ? 4 : 1,
    decoration: InputDecoration(
        isDense: true,
        label: normalText(text: label),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: white),
        ),
        hintText: hint,
        hintStyle: const TextStyle(color: darkGrey)),
  );
}
