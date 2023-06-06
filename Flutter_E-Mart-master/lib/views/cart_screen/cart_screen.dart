import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/cart_controller.dart';
import 'package:emart_app/services/firestor_services.dart';
import 'package:emart_app/views/cart_screen/shipping_screen.dart';
import 'package:emart_app/widget_common/loading_indicator.dart';
import 'package:emart_app/widget_common/our_button.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
        bottomNavigationBar: SizedBox(
            height: 60,
            width: context.screenWidth,
            child: ourButton(
              onPress: () {
                Get.to(() => const ShippingDetails());
              },
              color: redColor,
              title: "Proceed to Shipping",
              textColor: whiteColor,
            )),
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: redColor,
          iconTheme: const IconThemeData(color: whiteColor),
          title: "Shopping Cart"
              .text
              .color(whiteColor)
              .fontFamily(semibold)
              .make(),
        ),
        body: StreamBuilder(
            stream: FireStoreService.getCart(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: loadingIndicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: "Cart is Empty".text.color(darkFontGrey).make(),
                );
              } else {
                var data = snapshot.data!.docs;
                controller.calculate(data);
                controller.productSnapshot = data;
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Expanded(
                            child: ListView.builder(
                                itemCount: data.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    leading: Image.network(
                                      "${data[index]['img']}",
                                      width: 80,
                                      fit: BoxFit.cover,
                                    ),
                                    title:
                                        "${data[index]['title']}                      X ${data[index]['qty']}"
                                            .text
                                            .fontFamily(semibold)
                                            .size(16)
                                            .make(),
                                    subtitle: "${data[index]['tprice']}"
                                        .numCurrency
                                        .text
                                        .color(redColor)
                                        .fontFamily(semibold)
                                        .make(),
                                    trailing: const Icon(
                                      Icons.delete,
                                      color: redColor,
                                    ).onTap(() {
                                      FireStoreService.deleteDocument(
                                          data[index].id);
                                    }),
                                  );
                                })),
                        10.heightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            "Total Price "
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .make(),
                            Obx(
                              () => "${controller.totalP.value}"
                                  .numCurrency
                                  .text
                                  .fontFamily(semibold)
                                  .color(redColor)
                                  .make(),
                            ),
                          ],
                        )
                            .box
                            .padding(const EdgeInsets.all(12))
                            .color(lightGolden)
                            .width(context.screenWidth - 60)
                            .roundedSM
                            .make(),
                        10.heightBox,
                      ],
                    ));
              }
            }));
  }
}
