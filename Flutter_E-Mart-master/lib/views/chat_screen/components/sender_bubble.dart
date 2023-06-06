import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:intl/intl.dart' as intl;

Widget senderBubble1(DocumentSnapshot data) {
  var t =
      data['created_on'] == null ? DateTime.now() : data['created_on'].toDate();
  var time = intl.DateFormat("h:mma").format(t);
  return Container(
    padding: const EdgeInsets.all(8),
    margin: const EdgeInsets.only(bottom: 8),
    decoration: const BoxDecoration(
        color: redColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      "${data['msg']}".text.size(16).white.make(),
      10.heightBox,
      time.text.color(whiteColor.withOpacity(0.5)).make(),
    ]),
  );
}

Widget senderBubble2(DocumentSnapshot data) {
  var t =
      data['created_on'] == null ? DateTime.now() : data['created_on'].toDate();
  var time = intl.DateFormat("h:mma").format(t);
  return Container(
    padding: const EdgeInsets.all(8),
    margin: const EdgeInsets.only(bottom: 8),
    decoration: const BoxDecoration(
        color: Colors.deepOrange,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20))),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      "${data['msg']}".text.size(16).white.make(),
      10.heightBox,
      time.text.color(whiteColor.withOpacity(0.5)).make(),
    ]),
  );
}
