import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/const/images.dart';
import 'package:emart_seller/services/store_services.dart';
import 'package:emart_seller/views/auth_screen/widgets/appbar_widget.dart';
import 'package:emart_seller/views/auth_screen/widgets/dashboard_button.dart';
import 'package:emart_seller/views/auth_screen/widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart' as intl;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: appbarWidget(dashboard),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  dashboardButton(context,
                      title: products, count: "60", icon: icProducts),
                  dashboardButton(context,
                      title: orders, count: "15", icon: icOrders),
                ],
              ),
              10.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  dashboardButton(context,
                      title: rating, count: "60", icon: icStar),
                  dashboardButton(
                    context,
                    title: totalsales,
                    count: "15",
                    icon: icStar,
                  )
                ],
              ),
              10.heightBox,
              const Divider(),
              10.heightBox,
              boldText(text: popular, color: darkGrey, size: 16.0),
              20.heightBox,
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  children: List.generate(
                    15,
                    (index) => ListTile(
                      onTap: () {},
                      leading: Image.asset(
                        imgProduct,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      title: boldText(
                          text: "Product title", color: fontGrey, size: 14.0),
                      subtitle: normalText(text: "\$40.0", color: darkGrey),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
