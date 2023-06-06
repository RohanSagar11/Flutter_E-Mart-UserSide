import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/services/firestor_services.dart';
import 'package:emart_app/views/chat_screen/chat_screen.dart';
import 'package:emart_app/widget_common/loading_indicator.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        title:
            "My Messages".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
          stream: FireStoreService.getAllMessages(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return "No Messages Yet!".text.color(darkFontGrey).makeCentered();
            } else {
              var data = snapshot.data!.docs;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          shadowColor: lightGrey,
                          elevation: 10.0,
                          child: ListTile(
                            onTap: () {
                              Get.to(
                                () => ChatScreen(),
                                arguments: [
                                  data[index]['friend_name'],
                                  data[index]['told'],
                                ],
                              );
                            },
                            leading: const CircleAvatar(
                              backgroundColor: redColor,
                              child: Icon(color: whiteColor, Icons.person),
                            ),
                            title: "${data[index]['friend_name']}"
                                .text
                                .color(darkFontGrey)
                                .fontFamily(semibold)
                                .make(),
                            subtitle: "${data[index]['last_msg']}"
                                .text
                                .color(darkFontGrey)
                                .fontFamily(semibold)
                                .make(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }
}
