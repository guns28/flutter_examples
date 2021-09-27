
import 'package:flutter/foundation.dart';
import 'product.dart';

class CartModel extends ChangeNotifier {
  late ProductModel _products;
  final List<int> _itemIds = [];

  ProductModel get product => _products;

  set products(ProductModel newProducts) {
    _products = newProducts;
    notifyListeners();
  }

  List<Item> get items => _itemIds.map((id) => _products.getById(id)).toList();

  int get totalPrice =>
      items.fold(0, (total, current) => total + current.price);

  void add(Item item) {
    _itemIds.add(item.id);
    notifyListeners();
  }

  void remove(Item item) {
    _itemIds.remove(item.id);
    notifyListeners();
  }
}
