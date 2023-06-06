import 'dart:io';

import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controllers/profile_controller.dart';
import 'package:emart_seller/views/auth_screen/widgets/custom_text_field.dart';
import 'package:emart_seller/views/auth_screen/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../../const/colors.dart';
import '../../const/images.dart';
import '../../const/strings.dart';
import '../auth_screen/widgets/text_style.dart';

class EditProfileScreen extends StatefulWidget {
  final String? username;
  const EditProfileScreen({super.key, this.username});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var controller = Get.find<ProfileController>();
  @override
  void initState() {
    controller.nameController.text = widget.username!;
    super.initState();
  }

  Widget build(BuildContext context) {
    
    return Obx(
      () => Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: white),
          title: boldText(text: "Edit Profile", size: 16.0),
          actions: [
            controller.isloading.value
                ? loadingIndicator(
                    circleColor: white,
                  )
                : TextButton(
                    onPressed: () async {
                      controller.isloading(true);

                      //if image is not selected
                      if (controller.profileImgPath.value.isNotEmpty) {
                        await controller.uploadProfileImage();
                      } else {
                        controller.profileImageLink =
                            controller.snapshotData['imageUrl'];
                      }
                      //if old password matches
                      if (controller.snapshotData['password'] ==
                          controller.oldpassController.text) {
                        await controller.changeAuthPassword(
                            controller.snapshotData['email'],
                            controller.oldpassController.text,
                            controller.newpassController.text);
                        await controller.updateProfile(
                            name: controller.nameController.text,
                            password: controller.newpassController.text,
                            imgUrl: controller.profileImageLink);
                        VxToast.show(context, msg: "Updated");
                      } else if (controller
                              .oldpassController.text.isEmptyOrNull &&
                          controller.newpassController.text.isEmptyOrNull) {
                        await controller.updateProfile(
                            name: controller.nameController.text,
                            password: controller.snapshotData['password'],
                            imgUrl: controller.profileImageLink);
                        VxToast.show(context, msg: "Updated");
                      } else {
                        VxToast.show(context, msg: "Some Error Occured");
                        controller.isloading(false);
                      }
                    },
                    child: normalText(text: save))
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                controller.snapshotData['imageUrl'] == '' &&
                        controller.profileImgPath.isEmpty
                    ? Image.asset(
                        imgProduct,
                        width: 150,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make()
                    : controller.snapshotData['imageUrl'] != '' &&
                            controller.profileImgPath.isEmpty
                        ? Image.network(
                            controller.snapshotData['imageUrl'],
                            width: 150,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make()
                        : Image.file(
                            File(controller.profileImgPath.value),
                            width: 150,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make(),
                10.heightBox,
                ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: white),
                    onPressed: () {
                      controller.changeImage(context);
                    },
                    child: normalText(text: changeImage, color: fontGrey)),
                10.heightBox,
                const Divider(
                  color: white,
                ),
                10.heightBox,
                10.heightBox,
                customTextfield(
                    label: name,
                    hint: "Rohan Devs",
                    controller: controller.nameController),
                30.heightBox,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: boldText(text: "Change your Password")),
                ),
                10.heightBox,
                customTextfield(
                    label: password,
                    hint: passwordHint,
                    controller: controller.oldpassController),
                10.heightBox,
                customTextfield(
                    label: confrimPass,
                    hint: passwordHint,
                    controller: controller.newpassController),
                10.heightBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
