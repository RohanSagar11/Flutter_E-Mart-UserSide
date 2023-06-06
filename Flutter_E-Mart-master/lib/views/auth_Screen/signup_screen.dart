import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../widget_common/applogo_widget.dart';
import '../../widget_common/bg_widget.dart';
import '../../widget_common/custom_textfield.dart';
import '../../widget_common/our_button.dart';
import '../home_screen/home.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());
  //text controllers

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(
        () => Center(
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              applogoWidget(),
              "Join the $appname".text.fontFamily(bold).white.size(18).make(),
              15.heightBox,
              Column(
                children: [
                  customTextField(
                      hint: nameHint,
                      title: name,
                      controller: nameController,
                      isPass: false),
                  customTextField(
                      hint: emailHint,
                      title: email,
                      controller: emailController,
                      isPass: false),
                  customTextField(
                      hint: passwordhint,
                      title: password,
                      controller: passwordController,
                      isPass: true),
                  customTextField(
                      hint: passwordhint,
                      title: retypePassword,
                      controller: passwordRetypeController,
                      isPass: true),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: forgetPass.text.make(),
                    ),
                  ),
                ],
              )
                  .box
                  .white
                  .rounded
                  .padding(const EdgeInsets.all(16))
                  .width(context.screenWidth - 70)
                  .shadowSm
                  .make(),
              Row(
                children: [
                  Checkbox(
                    activeColor: redColor,
                    checkColor: whiteColor,
                    value: isCheck,
                    onChanged: (newValue) {
                      setState(() {
                        isCheck = newValue;
                      });
                    },
                  ),
                  Expanded(
                    child: RichText(
                        text: const TextSpan(children: [
                      TextSpan(
                          text: "I agree to the",
                          style: TextStyle(
                            fontFamily: regular,
                            color: fontGrey,
                          )),
                      TextSpan(
                          text: termsandCond,
                          style: TextStyle(
                            fontFamily: regular,
                            color: redColor,
                          )),
                      TextSpan(
                          text: " & ",
                          style: TextStyle(
                            fontFamily: regular,
                            color: fontGrey,
                          )),
                      TextSpan(
                          text: privacyPoliy,
                          style: TextStyle(
                            fontFamily: regular,
                            color: redColor,
                          )),
                    ])),
                  ),
                  10.widthBox
                ],
              ),
              5.heightBox,
              controller.isloading.value
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    )
                  : ourButton(
                          onPress: () async {
                            if (isCheck != false) {
                              controller.isloading(true);
                              try {
                                await controller
                                    .signupMethod(
                                        context: context,
                                        email: emailController.text,
                                        password: passwordController.text)
                                    .then((value) {
                                  return controller.storeUserData(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text);
                                }).then((value) {
                                  VxToast.show(context, msg: loggedin);
                                  Get.offAll(() => const Home());
                                });
                              } catch (e) {
                                auth.signOut();
                                VxToast.show(context, msg: e.toString());
                                controller.isloading(false);
                              }
                            }
                          },
                          color: isCheck == true ? redColor : lightGrey,
                          textColor: whiteColor,
                          title: signup)
                      .box
                      .width(context.screenWidth - 50)
                      .make(),
              10.heightBox,
              RichText(
                  text: const TextSpan(children: [
                TextSpan(
                    text: alreadyhaveaccount,
                    style: TextStyle(
                      fontFamily: bold,
                      color: fontGrey,
                    )),
                TextSpan(
                    text: login,
                    style: TextStyle(
                      fontFamily: bold,
                      color: redColor,
                    ))
              ])).onTap(() {
                Get.back();
              })
            ],
          ),
        ),
      ),
    ));
  }
}
