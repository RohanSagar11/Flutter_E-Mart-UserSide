import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/views/auth_screen/widgets/custom_text_field.dart';
import 'package:emart_seller/controllers/profile_controller.dart';
import 'package:emart_seller/views/auth_screen/widgets/loading_indicator.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../auth_screen/widgets/text_style.dart';

class ShopSettings extends StatelessWidget {
  const ShopSettings({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return Obx(
      () => Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: white),
          title: boldText(text: setting, size: 16.0),
          actions: [
            controller.isloading.value
                ? loadingIndicator(circleColor: white)
                : TextButton(
                    onPressed: () async {
                      controller.isloading(true);
                      await controller.updateShop(
                          shopname: controller.shopnameController.text,
                          shopaddress: controller.shopaddressController.text,
                          shopmobile: controller.shopmobileController.text,
                          shopwebsite: controller.shopwebsiteController.text,
                          shopdesc: controller.shopDescController.text);
                      VxToast.show(context, msg: "Shop Updated");
                    },
                    child: normalText(text: save)),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              10.heightBox,
              customTextfield(
                  label: shopname,
                  hint: nameHint,
                  controller: controller.shopnameController.text),
              10.heightBox,
              customTextfield(
                  label: address,
                  hint: shopAddressHint,
                  controller: controller.shopaddressController.text),
              10.heightBox,
              customTextfield(
                  label: mobile,
                  hint: shopMobileHint,
                  controller: controller.shopmobileController.text),
              10.heightBox,
              customTextfield(
                  label: website,
                  hint: shopWebsiteHint,
                  controller: controller.shopwebsiteController.text),
              10.heightBox,
              customTextfield(
                  label: descroption,
                  hint: shopDescHint,
                  isDesc: true,
                  controller: controller.shopDescController),
            ],
          ),
        ),
      ),
    );
  }
}
