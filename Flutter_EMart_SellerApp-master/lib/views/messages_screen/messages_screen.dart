import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/services/store_services.dart';
import 'package:emart_seller/views/auth_screen/widgets/loading_indicator.dart';
import 'package:emart_seller/views/auth_screen/widgets/text_style.dart';
import 'package:emart_seller/views/messages_screen/chat_screen.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart' as intl;
import 'package:get/get.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: boldText(text: messages, size: 16.0, color: fontGrey),
      ),
      body: StreamBuilder(
          stream: StoreServices.getMessages(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loadingIndicator();
            } else {
              var data = snapshot.data!.docs;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: List.generate(data.length, (index) {
                        var t = data[index]['created_on'] == null
                            ? DateTime.now()
                            : data[index]['created_on'].toDate();
                        var time = intl.DateFormat("h:mma").format(t);
                        return ListTile(
                          onTap: () {
                            Get.to(() => const ChatScreen());
                          },
                          trailing: normalText(text: time, color: darkGrey),
                          subtitle: normalText(
                              text: "Last Message....", color: darkGrey),
                          title: boldText(
                              text: "${data[index]['sender_name']}",
                              color: purpleColor),
                          leading: const CircleAvatar(
                            backgroundColor: purpleColor,
                            child: Icon(
                              Icons.person,
                              color: white,
                            ),
                          ),
                        );
                      }),
                    )),
              );
            }
          }),
      // body: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: SingleChildScrollView(
      //       physics: const BouncingScrollPhysics(),
      //       child: Column(
      //         children: List.generate(
      //           20,
      //           (index) => ListTile(
      //             onTap: () {
      //               Get.to(() => const ChatScreen());
      //             },
      //             trailing: normalText(text: "10:45 PM", color: darkGrey),
      //             subtitle:
      //                 normalText(text: "Last Message....", color: darkGrey),
      //             title: boldText(text: "Rohan", color: purpleColor),
      //             leading: const CircleAvatar(
      //               backgroundColor: purpleColor,
      //               child: Icon(
      //                 Icons.person,
      //                 color: white,
      //               ),
      //             ),
      //           ),
      //         ),
      //       )),
      // ),
    );
  }
}
