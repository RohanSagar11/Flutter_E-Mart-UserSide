import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/controllers/cart_controller.dart';
import 'package:emart_app/views/home_screen/home.dart';
import 'package:emart_app/widget_common/loading_indicator.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../../widget_common/our_button.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Obx(
      () => Scaffold(
        backgroundColor: whiteColor,
        bottomNavigationBar: SizedBox(
            height: 60,
            width: context.screenWidth,
            child: controller.placingOrder.value
                ? Center(
                    child: loadingIndicator(),
                  )
                : ourButton(
                    onPress: () async {
                      await controller.placeMyOrder(
                          orderPaymentMethod:
                              paymentMethods[controller.paymentIndex.value],
                          totalAmount: controller.totalP.value);
                      await controller.clearCart();
                      VxToast.show(context, msg: 'Order Placed Successfully');
                      Get.offAll(const Home());
                    },
                    color: redColor,
                    title: "Place My Order",
                    textColor: whiteColor,
                  )),
        appBar: AppBar(
          backgroundColor: whiteColor,
          title: "Choose Payment Method"
              .text
              .fontFamily(semibold)
              .color(darkFontGrey)
              .make(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Obx(
            () => Column(
              children: List.generate(paymentMethodsImg.length, (index) {
                return GestureDetector(
                  onTap: () {
                    controller.changePaymentIndex(index);
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        border: Border.all(
                            style: BorderStyle.solid,
                            color: controller.paymentIndex.value == index
                                ? redColor
                                : Colors.transparent,
                            width: 3),
                        borderRadius: BorderRadius.circular(12)),
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Image.asset(
                          paymentMethodsImg[index],
                          width: double.infinity,
                          height: 150,
                          colorBlendMode: controller.paymentIndex.value == index
                              ? BlendMode.darken
                              : BlendMode.color,
                          color: Colors.black.withOpacity(0.2),
                          fit: BoxFit.cover,
                        ),
                        controller.paymentIndex.value == index
                            ? Transform.scale(
                                scale: 1.3,
                                child: Checkbox(
                                  activeColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  value: true,
                                  onChanged: (value) {},
                                ),
                              )
                            : Container(),
                        Positioned(
                            bottom: 5,
                            left: 7,
                            child: paymentMethods[index]
                                .text
                                .size(15)
                                .white
                                .fontFamily(bold)
                                .make()),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
