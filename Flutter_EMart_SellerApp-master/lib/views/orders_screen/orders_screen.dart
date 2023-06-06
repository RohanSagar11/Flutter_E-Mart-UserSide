import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controllers/orders_controller.dart';
import 'package:emart_seller/services/store_services.dart';
import 'package:emart_seller/views/auth_screen/widgets/appbar_widget.dart';
import 'package:emart_seller/views/auth_screen/widgets/loading_indicator.dart';
import 'package:emart_seller/views/orders_screen/order_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

import '../../const/images.dart';
import '../auth_screen/widgets/text_style.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(OrdersController());
    return Scaffold(
      appBar: appbarWidget(orders),
      body: StreamBuilder(
          stream: StoreServices.getOrders(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loadingIndicator();
            } else {
              var data = snapshot.data!.docs;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: List.generate(data.length, (index) {
                      var time = data[index]['order_date'].toDate();
                      return ListTile(
                        trailing: boldText(
                            text: "\$ ${data[index]['total_amount']}",
                            color: purpleColor,
                            size: 16.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        onTap: () {
                          Get.to(() => OrderDetils(
                                data: data[index],
                              ));
                        },
                        tileColor: textfieldGrey,
                        title: boldText(
                          text: "${data[index]['order_code']}",
                          color: purpleColor,
                        ),
                        subtitle: Column(
                          children: [
                            10.heightBox,
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_month,
                                  color: fontGrey,
                                ),
                                10.widthBox,
                                boldText(
                                    text: intl.DateFormat.yMEd().format(
                                      time,
                                    ),
                                    color: fontGrey),
                              ],
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.payment,
                                  color: fontGrey,
                                ),
                                10.widthBox,
                                boldText(text: unpaid, color: red),
                              ],
                            )
                          ],
                        ),
                      ).box.margin(const EdgeInsets.only(bottom: 4)).make();
                    }),
                  ),
                ),
              );
            }
          }),
      //
    );
  }
}
