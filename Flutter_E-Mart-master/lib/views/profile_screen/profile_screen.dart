import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/controllers/auth_controller.dart';
import 'package:emart_app/controllers/profile_controller.dart';
import 'package:emart_app/services/firestor_services.dart';
import 'package:emart_app/views/chat_screen/messaging_screen.dart';
import 'package:emart_app/views/orders_screen/orders_screen.dart';
import 'package:emart_app/views/profile_screen/components/details_card.dart';
import 'package:emart_app/views/profile_screen/edit_profile_screen.dart';
import 'package:emart_app/views/wishlist_screen/wishlist_screen.dart';
import 'package:emart_app/widget_common/bg_widget.dart';
import 'package:emart_app/widget_common/loading_indicator.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../auth_Screen/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    return bgWidget(
        child: Scaffold(
            body: StreamBuilder(
      stream: FireStoreService.getUser(currentUser!.uid),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(redColor),
            ),
          );
        } else {
          var data = snapshot.data!.docs[0];
          return SafeArea(
              child: Column(
            children: [
              //edit profile button
              // ignore: prefer_const_constructors
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    Icons.edit,
                    color: whiteColor,
                  ),
                ).onTap(() {
                  controller.nameController.text = data['name'];
                  Get.to(() => EditProfileScreen(data: data));
                }),
              ),
              //user details section

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    data['imageUrl'] == ''
                        ? Image.asset(
                            imgProfile2,
                            width: 80,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make()
                        : Image.network(
                            data['imageUrl'],
                            width: 80,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make(),
                    10.widthBox,
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "${data['name']}"
                            .text
                            .fontFamily(semibold)
                            .white
                            .make(),
                        "${data['email']}".text.white.make(),
                      ],
                    )),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          // ignore: prefer_const_constructors
                          side: const BorderSide(
                        color: whiteColor,
                      )),
                      onPressed: () async {
                        await Get.put(AuthController()).signoutMethod(context);
                        Get.offAll(() => const LoginScreen());
                      },
                      child: logout.text.fontFamily(semibold).white.make(),
                    )
                  ],
                ),
              ),
              20.heightBox,
              FutureBuilder(
                  future: FireStoreService.getCounts(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: loadingIndicator(),
                      );
                    } else {
                      var countData = snapshot.data;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          detailsCard(context.screenWidth / 3.3,
                              countData[0].toString(), "In Your Cart"),
                          detailsCard(context.screenWidth / 3.3,
                              countData[1].toString(), "In Your Wishlist"),
                          detailsCard(context.screenWidth / 3.3,
                              countData[2].toString(), "You Order"),
                        ],
                      );
                    }
                  }),

              //button section
              ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return const Divider(
                          color: lightGrey,
                        );
                      },
                      itemCount: profileButtonList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          onTap: () {
                            switch (index) {
                              case 0:
                                Get.to(() => const OrdersScreen());
                                break;
                              case 1:
                                Get.to(() => const WishlistScreen());
                                break;
                              case 2:
                                Get.to(() => const MessagesScreen());
                                break;
                            }
                          },
                          leading: Image.asset(
                            profileButtonIcon[index],
                            width: 22,
                          ),
                          title: "${profileButtonList[index]}"
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .make(),
                        );
                      })
                  .box
                  .white
                  .rounded
                  .margin(const EdgeInsets.all(12))
                  .shadowSm
                  .padding(const EdgeInsets.symmetric(horizontal: 16))
                  .make()
                  .box
                  .color(redColor)
                  .make(),
            ],
          ));
        }

        return Container();
      },
    )));
  }
}
