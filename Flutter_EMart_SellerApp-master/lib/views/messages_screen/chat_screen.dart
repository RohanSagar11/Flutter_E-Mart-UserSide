import 'package:emart_seller/const/const.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../auth_screen/widgets/text_style.dart';
import '../components/chat_bubble.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: boldText(text: "Chats", size: 16.0, color: purpleColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: 20,
                    itemBuilder: ((context, index) {
                      return senderBubble2(
                          axis1: CrossAxisAlignment.end,
                          axis: CrossAxisAlignment.start);
                    }))),
            10.heightBox,
            SizedBox(
              height: 56,
              child: Row(children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      isDense: true,
                      hintText: "Enter Message",
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: darkGrey)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: purpleColor)),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.send,
                      size: 30.0,
                      color: purpleColor,
                    ))
              ]),
            )
          ],
        ),
      ),
    );
  }
}
