import 'package:emart_seller/const/const.dart';

Widget ourButton({title, color = purpleColor, onPress}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          backgroundColor: purpleColor, padding: const EdgeInsets.all(12)),
      onPressed: onPress,
      child: "$title".text.size(16).semiBold.make());
}
