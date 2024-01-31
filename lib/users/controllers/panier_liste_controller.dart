import 'dart:ffi';

import 'package:ecf_studi2/users/model/panier.dart';
import 'package:get/get.dart';

class PanierListeController extends GetxController
{
  RxList<Panier> _listePanier = <Panier>[].obs;
  RxList<int> _selectedItemList = <int>[].obs;
  RxBool _isSelectedAll = false.obs;
  RxDouble _total = 0.0.obs; 

  List<Panier> get listePanier => _listePanier.value;
  List<int> get selectedItem => _selectedItemList.value;
  bool get isSelectedAll => _isSelectedAll.value;
  double get total => _total.value;

  setList(List<Panier> list)
  {
    _listePanier.value = list;
  }

  addSelectedItem(int itemSelectedID)
  {
    _selectedItemList.value.add(itemSelectedID);
    update();
  }

   deleteSelectedItem(int itemSelectedID)
  {
    _selectedItemList.value.add(itemSelectedID);
    update();
  }

  setIsSelectedAllItem(int itemSelectedID)
  {
    _isSelectedAll.value = !_isSelectedAll.value;  
  }

clearAllSelectedItem()
  {
    _selectedItemList.value.clear();
    update();  
  }

setTotal(double overallTotal)
  {
    _total.value = overallTotal;  
  }
}