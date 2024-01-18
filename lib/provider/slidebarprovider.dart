import 'package:flutter/material.dart%20';

class OpacityProvider with ChangeNotifier {
  // ignore: prefer_final_fields

  double _opacity = 1.0;
  double get opacity => _opacity;
  void setValue(double val) {
    _opacity = val;
    notifyListeners();
  }
}

class CountProvider with ChangeNotifier {
  // ignore: prefer_final_fields

  int _count = 0;
  int get count => _count;
  void setCount() {
    _count++;
    notifyListeners();
  }
}
