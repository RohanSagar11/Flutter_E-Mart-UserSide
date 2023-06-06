import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/services/firestor_services.dart';
import 'package:emart_app/widget_common/loading_indicator.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../category_screen/item_details.dart';

class SearchScreen extends StatelessWidget {
  final String title;
  const SearchScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: title.text.color(darkFontGrey).make(),
          shadowColor: Colors.transparent,
        ),
        body: FutureBuilder(
            future: FireStoreService.searchProducts(title),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: loadingIndicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                    child: "No Products found".text.color(darkFontGrey).make());
              } else {
                var data = snapshot.data!.docs;
                var filtered = data
                    .where(
                      (element) => element['p_name']
                          .toString()
                          .toLowerCase()
                          .contains(title.toLowerCase()),
                    )
                    .toList();
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            mainAxisExtent: 300),
                    children: filtered
                        .mapIndexed((currentValue, index) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  data[index]['p_imgs'][0],
                                  height: 200,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                                const Spacer(),
                                "${filtered[index]['p_name']}"
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                                10.heightBox,
                                "${filtered[index]['p_price']}"
                                    .text
                                    .color(redColor)
                                    .fontFamily(bold)
                                    .size(16)
                                    .make()
                              ],
                            )
                                .box
                                .color(whiteColor)
                                .margin(
                                    const EdgeInsets.symmetric(horizontal: 4))
                                .roundedSM
                                .outerShadowMd
                                .padding(const EdgeInsets.all(12))
                                .make()
                                .onTap(() {
                              Get.to(() => ItemDetails(
                                    title: "${filtered[index]['p_name']}",
                                    data: filtered[index],
                                  ));
                            }))
                        .toList(),
                  ),
                );
              }
            }));
  }
}
