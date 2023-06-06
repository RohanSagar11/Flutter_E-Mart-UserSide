import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/const/images.dart';
import 'package:emart_seller/controllers/auth_controller.dart';
import 'package:emart_seller/views/auth_screen/widgets/custom_text_field.dart';
import 'package:emart_seller/views/auth_screen/widgets/our_button.dart';
import 'package:emart_seller/views/auth_screen/widgets/text_style.dart';
import 'package:emart_seller/views/home_screen/home.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AutheController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: "E-Mart Seller".text.make(),
      ),
      backgroundColor: purpleColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              30.heightBox,
              Center(child: boldText(text: welcome, size: 18.0)),
              20.heightBox,
              Center(
                child: Image.asset(
                  icLogo,
                  width: 70,
                  height: 70,
                )
                    .box
                    .border(color: white)
                    .padding(const EdgeInsets.all(8))
                    .rounded
                    .make(),
              ),
              20.heightBox,
              Center(child: boldText(text: appname, size: 20.0)),
              40.heightBox,
              Obx(
                () => Column(
                  children: [
                    TextFormField(
                      controller: controller.emaileController,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.email,
                            color: purpleColor,
                          ),
                          border: InputBorder.none,
                          hintText: emailHint),
                    ),
                    10.heightBox,
                    TextFormField(
                      obscureText: true,
                      controller: controller.passwordeController,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock,
                            color: purpleColor,
                          ),
                          border: InputBorder.none,
                          hintText: passwordHint),
                    ),
                    10.heightBox,
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {},
                          child: normalText(
                              text: forgotPassword, color: purpleColor)),
                    ),
                    10.heightBox,
                    SizedBox(
                        width: context.screenWidth - 100,
                        child: controller.isloading.value
                            ? const Center(
                              child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(purpleColor),
                                ),
                            )
                            : ourButton(
                                title: login,
                                onPress: () async {
                                  // Get.to(() => const Home());
                                  controller.isloading(true);
                                  await controller
                                      .loginiMethod(context: context)
                                      .then((value) {
                                    if (value != null) {
                                      VxToast.show(context, msg: "Logged In");
                                      controller.isloading(false);
                                      Get.offAll(() => const Home());
                                    } else {
                                      controller.isloading(false);
                                    }
                                  });
                                }))
                  ],
                )
                    .box
                    .white
                    .rounded
                    .outerShadowMd
                    .padding(const EdgeInsets.all(8))
                    .make(),
              ),
              10.heightBox,
              Center(child: normalText(text: anyProblem, color: Colors.grey)),
              const Spacer(),
              Center(child: boldText(text: credit)),
              20.heightBox
            ],
          ),
        ),
      ),
    );
  }
}
