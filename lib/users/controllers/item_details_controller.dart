import 'package:get/get.dart';

class ItemDetailsController extends GetxController {
  final RxInt _quantityItem = 1.obs;

  int get quantity => _quantityItem.value;

  void setQuantityItem(int quantityOfItem) {
    _quantityItem.value = quantityOfItem;
  }
}