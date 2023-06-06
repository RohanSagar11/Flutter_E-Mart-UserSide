import 'package:emart_seller/const/const.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../const/images.dart';
import '../auth_screen/widgets/text_style.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: boldText(text: "Product Title", color: fontGrey, size: 16.0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              VxSwiper.builder(
                  autoPlay: true,
                  height: 350,
                  itemCount: 3,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1.0,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      imgProduct,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    );
                  }),
              10.heightBox,
              //title and details section
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    boldText(
                        text: "Product title", color: fontGrey, size: 16.0),
                    10.heightBox,
                    //rating
                    VxRating(
                      isSelectable: false,
                      value: 3.0,
                      onRatingUpdate: (value) {},
                      normalColor: textfieldGrey,
                      selectionColor: golden,
                      count: 5,
                      maxRating: 5,
                      size: 25,
                    ),
                    10.heightBox,
                    boldText(text: "\$ 900.0", color: red, size: 18.0),
                    20.heightBox,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 100,
                              child: boldText(
                                  text: "Category : ", color: fontGrey),
                            ),
                            Row(children: [
                              normalText(text: "Women Dress", color: darkGrey)
                            ]),
                          ],
                        ),
                        //quantity secion
                        30.heightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 100,
                              child: boldText(
                                  text: "Sub Category : ", color: fontGrey),
                            ),
                            normalText(text: "Cars", color: fontGrey),
                          ],
                        ),
                        20.heightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 100,
                              child: boldText(text: "Color :", color: fontGrey),
                            ),
                            Row(
                              children: List.generate(
                                3,
                                (index) => VxBox()
                                    .size(40, 40)
                                    .roundedFull
                                    .color(Vx.randomColor)
                                    .margin(const EdgeInsets.symmetric(
                                        horizontal: 4))
                                    .make()
                                    .onTap(() {}),
                              ),
                            ),
                          ],
                        ),
                        //quantity secion
                        20.heightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 100,
                              child: boldText(
                                  text: "Quantity : ", color: fontGrey),
                            ),
                            normalText(text: "20 Items", color: fontGrey),
                          ],
                        )
                        //total row
                      ],
                    ).box.white.padding(const EdgeInsets.all(8)).make(),
                    const Divider(
                      thickness: 2.0,
                    ),
                    10.heightBox,
                    boldText(text: "Description", color: fontGrey, size: 18.0),
                    10.heightBox,
                    normalText(
                        text: "Description of this item, ", color: fontGrey)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
