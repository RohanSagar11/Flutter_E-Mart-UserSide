import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/product_controller.dart';
import 'package:emart_app/services/firestor_services.dart';
import 'package:emart_app/views/category_screen/item_details.dart';
import 'package:emart_app/widget_common/bg_widget.dart';
import 'package:emart_app/widget_common/loading_indicator.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class CategoryDetails extends StatefulWidget {
  final String? title;
  const CategoryDetails({Key? key, required this.title}) : super(key: key);

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  var controller = Get.put(ProductController());
  dynamic productMethod;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switchCategore(widget.title);
  }

  switchCategore(title) {
    if (controller.subcat.contains(title)) {
      productMethod = FireStoreService.getSubCategoryProducts(title);
    } else {
      productMethod = FireStoreService.getProducts(title);
    }
  }

  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          shadowColor: Colors.transparent,
          title: widget.title!.text.fontFamily(bold).white.make(),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                    controller.subcat.length,
                    (index) => "${controller.subcat[index]}"
                            .text
                            .size(12)
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .makeCentered()
                            .box
                            .white
                            .size(120, 60)
                            .margin(const EdgeInsets.symmetric(horizontal: 4))
                            .rounded
                            .make()
                            .onTap(() {
                          switchCategore("${controller.subcat[index]}");
                          setState(() {});
                        })),
              ),
            ),
            20.heightBox,
            StreamBuilder(
              stream: productMethod,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Expanded(
                    child: Center(
                      child: loadingIndicator().color(whiteColor)
                    ),
                  );
                } else if (snapshot.data!.docs.isEmpty) {
                  return Expanded(
                    child: "No Products Found!".text.color(darkFontGrey).makeCentered(),
                  );
                } else {
                  var data = snapshot.data!.docs;
                  return Expanded(
                      child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: data.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisExtent: 250,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8),
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  data[index]['p_imgs'][0],
                                  height: 150,
                                  width: 200,
                                  fit: BoxFit.cover,
                                ),
                                5.heightBox,
                                "${data[index]['p_name']}"
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                                10.heightBox,
                                "${data[index]['p_price']}"
                                    .numCurrency
                                    .text
                                    .color(redColor)
                                    .fontFamily(bold)
                                    .size(16)
                                    .make()
                              ],
                            )
                                .box
                                .white
                                .margin(
                                    const EdgeInsets.symmetric(horizontal: 4))
                                .roundedSM
                                .outerShadowSm
                                .padding(const EdgeInsets.all(12))
                                .make()
                                .onTap(() {
                              controller.checkifFav(data[index]);
                              Get.to(() => ItemDetails(
                                  title: "${data[index]['p_name']}",
                                  data: data[index]));
                            });
                          }));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
