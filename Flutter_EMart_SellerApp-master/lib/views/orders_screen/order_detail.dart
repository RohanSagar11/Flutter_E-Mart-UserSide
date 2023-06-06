import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controllers/orders_controller.dart';
import 'package:emart_seller/views/auth_screen/widgets/text_style.dart';
import 'package:emart_seller/views/orders_screen/components/order_place_details.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

import '../auth_screen/widgets/our_button.dart';

class OrderDetils extends StatefulWidget {
  final dynamic data;
  const OrderDetils({super.key, this.data});

  @override
  State<OrderDetils> createState() => _OrderDetilsState();
}

class _OrderDetilsState extends State<OrderDetils> {
  var controller = Get.find<OrdersController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getOrders(widget.data);
    controller.confirm.value = widget.data['order_confirmed'];
    controller.ondelivery.value = widget.data['order_on_delivery'];
    controller.delivered.value = widget.data['order_delivered'];
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: boldText(text: "Order Details", color: fontGrey, size: 16.0),
        ),
        bottomNavigationBar: SizedBox(
          height: 60,
          width: context.screenWidth,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Visibility(
              visible: !controller.confirm.value,
              child: ourButton(
                  color: Colors.green,
                  onPress: () {
                    controller.confirm(true);
                    controller.changeStatus(
                        title: "order_confirmed",
                        status: true,
                        docId: widget.data.id);
                  },
                  title: "Confirm Order"),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                //order delivery status section
                Visibility(
                  visible: controller.confirm.value,
                  child: Column(
                    children: [
                      10.heightBox,
                      boldText(
                          text: "Order Status -:", color: fontGrey, size: 16.0),
                      SwitchListTile(
                        activeColor: purpleColor,
                        value: true,
                        onChanged: (Value) {},
                        title: boldText(text: "Order Placed", color: fontGrey),
                      ),
                      SwitchListTile(
                        activeColor: purpleColor,
                        value: controller.confirm.value,
                        onChanged: (Value) {
                          controller.confirm.value = Value;
                        },
                        title: boldText(text: "Confirmed", color: fontGrey),
                      ),
                      SwitchListTile(
                        activeColor: purpleColor,
                        value: controller.ondelivery.value,
                        onChanged: (Value) {
                          controller.ondelivery.value = Value;
                          controller.changeStatus(
                              title: "order_on_delivery",
                              status: Value,
                              docId: widget.data.id);
                        },
                        title: boldText(text: "On Delivery", color: fontGrey),
                      ),
                      SwitchListTile(
                        activeColor: purpleColor,
                        value: controller.delivered.value,
                        onChanged: (Value) {
                          controller.delivered.value = Value;
                          controller.changeStatus(
                              title: "order_delivered",
                              status: Value,
                              docId: widget.data.id);
                        },
                        title: boldText(text: "Deliivered", color: fontGrey),
                      ),
                    ],
                  )
                      .box
                      .outerShadowMd
                      .border(color: lightGrey)
                      .padding(const EdgeInsets.all(8.0))
                      .roundedSM
                      .white
                      .make(),
                ),

                //order details section
                Column(
                  children: [
                    orderPlaceDetails(
                      d1: "${widget.data['order_code']}",
                      d2: "${widget.data['shipping_method']}",
                      title1: "Order Code",
                      title2: "Shipping Method",
                    ),
                    orderPlaceDetails(
                      d1: intl.DateFormat.yMEd().format(
                        widget.data['order_date'].toDate(),
                      ),
                      d2: "${widget.data['payment_method']}",
                      title1: "Order Date",
                      title2: "Payment Method",
                    ),
                    orderPlaceDetails(
                      d1: "Unpaid",
                      d2: "Order Placed",
                      title1: "Payment Status",
                      title2: "Delivery Status",
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Shipping Address"
                                  .text
                                  .color(purpleColor)
                                  .semiBold
                                  .make(),
                              "Name: ${widget.data['order_by_name']}"
                                  .text
                                  .color(Colors.grey)
                                  .make(),
                              "Email: ${widget.data['order_by_email']}"
                                  .text
                                  .color(Colors.grey)
                                  .make(),
                              "Address: ${widget.data['order_by_address']}"
                                  .text
                                  .color(Colors.grey)
                                  .make(),
                              "City: ${widget.data['order_by_city']}"
                                  .text
                                  .color(Colors.grey)
                                  .make(),
                              "State: ${widget.data['order_by_state']}"
                                  .text
                                  .color(Colors.grey)
                                  .make(),
                              "Phone: ${widget.data['order_by_phone']}"
                                  .text
                                  .color(Colors.grey)
                                  .make(),
                              "Postal Code: ${widget.data['order_by_postal']}"
                                  .text
                                  .color(Colors.grey)
                                  .make(),
                            ],
                          ),
                          SizedBox(
                            width: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                boldText(
                                    text: "Total Amount,", color: purpleColor),
                                boldText(
                                    text: "\$ ${widget.data['total_amount']}",
                                    color: purpleColor,
                                    size: 16.0),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
                    .box
                    .outerShadowMd
                    .border(color: lightGrey)
                    .roundedSM
                    .white
                    .make(),
                const Divider(),
                10.heightBox,
                boldText(text: "Ordered Product", color: darkGrey, size: 16.0),
                10.heightBox,
                ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: List.generate(controller.orders.length, (index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        orderPlaceDetails(
                            title1: "${controller.orders[index]['title']}",
                            title2: "\$ ${controller.orders[index]['tprice']}",
                            d1: "${controller.orders[index]['qty']}x",
                            d2: "Refundable"),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                            width: 30,
                            height: 10,
                            color: Color(controller.orders[index]['color']),
                          ),
                        ),
                        const Divider(
                          color: Colors.white,
                        ),
                      ],
                    );
                  }).toList(),
                ).box.outerShadowMd.white.make(),
                20.heightBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
