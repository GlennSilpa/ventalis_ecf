import 'package:get/get.dart';

class ItemDetailsController extends GetxController
{
  final RxInt _quantityItem = 1.obs;

  int get quantity => _quantityItem.value;

  setQuantityItem(int quantityOfItem)
{
  _quantityItem.value = quantityOfItem;
}

}