import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/widget_common/our_button.dart';
import 'package:flutter/services.dart';

Widget exitDialog(context) {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: redColor,
          title: "Exit E-Mart ?"
              .text
              .fontFamily(bold)
              .size(18)
              .color(whiteColor)
              .make(),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        20.heightBox,
        "Are you sure you want to exit?"
            .text
            .color(darkFontGrey)
            .size(16)
            .make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ourButton(
                color: redColor,
                onPress: () {
                  SystemNavigator.pop();
                },
                textColor: whiteColor,
                title: "Yes"),
            ourButton(
                color: redColor,
                onPress: () {
                  Navigator.pop(context);
                },
                textColor: whiteColor,
                title: "No"),
          ],
        )
      ],
    ).box.color(lightGrey).padding(const EdgeInsets.all(12)).roundedSM.make(),
  );
}
