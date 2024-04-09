import 'package:ecf_studi2/users/model/order.dart';
import 'package:get/get.dart';

class OrderListeController extends GetxController {
  RxList<Order> _listeOrder = <Order>[].obs;

  List<Order> get listeOrder => _listeOrder.value;

  setList(List<Order> list) {
    _listeOrder.value = list;
  }
}
