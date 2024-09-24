import 'package:e_comarance_app/model/item.dart';
import 'package:flutter/material.dart';

class Cart with ChangeNotifier {
  int total = 0;
  List selectitems = [];
  delete(Items value) {
    total -= value.price.toInt();
    selectitems.remove(value);
    notifyListeners();
  }

  add(Items value) {
    total += value.price.toInt();
    selectitems.add(value);
    notifyListeners();
  }
}
