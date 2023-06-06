import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/const.dart';
import 'package:get/get.dart';

class OrdersController extends GetxController {
  var confirm = false.obs;
  var ondelivery = false.obs;
  var delivered = false.obs;
  var orders = [];
  getOrders(data) {
    orders.clear();
    for (var item in data['orders']) {
      if (item['vendor_id'] == currentUser!.uid) {
        orders.add(item);
      }
    }
  }

  changeStatus({title,status, docId}) async {
    var store = firestore.collection(ordersCollection).doc(docId);
    await store.set({
      title: status


    }, SetOptions(merge: true));
  }
}
