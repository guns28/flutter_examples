import 'package:flutter/cupertino.dart';

class SliderProv with ChangeNotifier {
  double _value = 0;

  double get sliderValue => _value;

  void changeValue(double val) {
    _value = val;
    notifyListeners();
  }
}