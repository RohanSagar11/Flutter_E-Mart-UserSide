import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/cart_controller.dart';
import 'package:emart_app/views/cart_screen/payment_method.dart';
import 'package:emart_app/widget_common/custom_textfield.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../../widget_common/our_button.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      bottomNavigationBar: SizedBox(
          height: 60,
          width: context.screenWidth,
          child: ourButton(
            onPress: () {
              if (controller.addressController.text.length > 10) {
                Get.to(() => const PaymentMethods());
                VxToast.show(context, msg: "Address Provided");
              } else {
                VxToast.show(context, msg: "Please fill the details");
              }
            },
            color: redColor,
            title: "Continue",
            textColor: whiteColor,
          )),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: redColor,
        iconTheme: const IconThemeData(color: whiteColor),
        title:
            "Shipping Info".text.color(whiteColor).fontFamily(semibold).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(children: [
          customTextField(
              hint: "Address",
              isPass: false,
              title: "Address",
              controller: controller.addressController),
          customTextField(
              hint: "City",
              isPass: false,
              title: "City",
              controller: controller.cityController),
          customTextField(
              hint: "State",
              isPass: false,
              title: "State",
              controller: controller.stateController),
          customTextField(
              hint: "Postal Code",
              isPass: false,
              title: "Postal Code",
              controller: controller.postalController),
          customTextField(
              hint: "Phone",
              isPass: false,
              title: "Phone",
              controller: controller.phoneController),
        ]),
      ),
    );
  }
}
