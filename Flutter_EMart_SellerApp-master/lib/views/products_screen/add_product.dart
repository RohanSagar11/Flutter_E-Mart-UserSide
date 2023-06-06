import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/views/auth_screen/widgets/custom_text_field.dart';
import 'package:emart_seller/views/auth_screen/widgets/text_style.dart';
import 'package:emart_seller/views/products_screen/components/product_dropdown.dart';
import 'package:emart_seller/views/products_screen/components/product_images.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: white),
        title: boldText(text: "Add Product", color: white, size: 16.0),
        actions: [
          TextButton(
              onPressed: () {}, child: boldText(text: save, color: white))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customTextfield(hint: "eg. BMW", label: "Product Name"),
              10.heightBox,
              customTextfield(
                  hint: "eg. Nice Product", label: "Description", isDesc: true),
              10.heightBox,
              customTextfield(hint: "eg. \$100.0", label: "Price"),
              10.heightBox,
              customTextfield(hint: "eg. \$100.0", label: "Price"),
              10.heightBox,
              customTextfield(hint: "eg. 20", label: "Quantity"),
              10.heightBox,
              productDropDown(),
              10.heightBox,
              productDropDown(),
              10.heightBox,
              const Divider(
                color: white,
              ),
              boldText(text: "Choose Product Images"),
              10.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                    3,
                    (index) =>
                        productImages(label: "${index + 1}", onPress: () {})),
              ),
              10.heightBox,
              Center(
                child: normalText(
                    text: "First image will be your display image",
                    color: lightGrey),
              ),
              10.heightBox,
              const Divider(
                color: white,
              ),
              boldText(text: "Choose Product colors"),
              10.heightBox,
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: List.generate(
                    10,
                    (index) => Stack(alignment: Alignment.center, children: [
                          VxBox()
                              .color(Vx.randomPrimaryColor)
                              .roundedFull
                              .size(40, 40)
                              .make(),
                          const Icon(
                            Icons.done,
                            color: white,
                          ),
                        ])),
              )
            ],
          ),
        ),
      ),
    );
  }
}
