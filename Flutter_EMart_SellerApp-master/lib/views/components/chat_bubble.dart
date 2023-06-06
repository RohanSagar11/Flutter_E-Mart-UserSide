import 'package:emart_seller/const/const.dart';
import 'package:intl/intl.dart' as intl;

Widget senderBubble1() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: const BoxDecoration(
            color: purpleColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          "helloo........................".text.size(16).white.make(),
          10.heightBox,
          "23:00 PM".text.color(Colors.white.withOpacity(0.5)).make(),
        ]),
      ),
    ],
  );
}

Widget senderBubble2({axis, axis1}) {
  return Column(
    crossAxisAlignment: axis,
    children: [
      Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: const BoxDecoration(
            color: Colors.deepOrange,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        child: Column(crossAxisAlignment: axis1, children: [
          "hel...............................".text.size(16).white.make(),
          10.heightBox,
          "23:00 PM".text.color(Colors.white.withOpacity(0.5)).make(),
        ]),
      ),
    ],
  );
}
