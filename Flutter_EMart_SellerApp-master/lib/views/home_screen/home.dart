import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/const/images.dart';
import 'package:emart_seller/controllers/home_controller.dart';
import 'package:emart_seller/views/auth_screen/widgets/text_style.dart';
import 'package:emart_seller/views/home_screen/home_screen.dart';
import 'package:emart_seller/views/orders_screen/orders_screen.dart';
import 'package:emart_seller/views/products_screen/product_screen.dart';
import 'package:emart_seller/views/profile_screen/profile_screen.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    var navScreens = [
      HomeScreen(),
      ProductsScreen(),
      OrdersScreen(),
      ProfileScreen()
    ];
    var bottomNavbar = [
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: dashboard),
      const BottomNavigationBarItem(
          icon: Icon(Icons.work_sharp), label: products),
      const BottomNavigationBarItem(icon: Icon(Icons.note_alt), label: orders),
      const BottomNavigationBarItem(icon: Icon(Icons.settings), label: setting)
    ];
    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
            currentIndex: controller.navIndex.value,
            onTap: (index) {
              controller.navIndex.value = index;
            },
            type: BottomNavigationBarType.fixed,
            unselectedItemColor: darkGrey,
            selectedItemColor: purpleColor,
            items: bottomNavbar),
      ),
      body: Obx(
        () => Column(
          children: [
            Expanded(
              child: navScreens.elementAt(controller.navIndex.value),
            )
          ],
        ),
      ),
    );
  }
}
