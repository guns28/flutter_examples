
import 'package:flutter/material.dart';
import 'package:flutter_examples/global/assets.dart';

class ProductModel {

  static List<Item> fruitsNames = [
    Item(0, "Lays Honey \nBarbecue", Assets.laysBarbecue, 3, Color(0xFF78c1ff)),
    Item(1, "Lays Cheddar \n& Sour Cream", Assets.laysCheddar, 6, Color(0xFF5099f4)),
    Item(2, "Lays Classic", Assets.laysClassic, 4, Color(0xFF468fea)),
    Item(3, "Lays Kpa6", Assets.laysKpa6, 8, Color(0xFF2871cc)),
    Item(4, "Lays Salt \n& Vinegar", Assets.laysSalt, 9, Color(0xFF003f9a)),
    Item(5, "Lays Sour Cream \n& onion", Assets.laysSourCream, 12, Color(0xFF78c1ff))
  ];

  ///used to get the items in cart as we only store the item id when adding
  Item getById(int id) => fruitsNames.firstWhere((item) => item.id == id);

  Item getByPosition(int position) {
    return getById(position);
  }
}

@immutable
class Item {
  final int id;
  final String name;
  final int price;
  final String image;
  final Color backgroundColor;

  Item(this.id, this.name, this.image, this.price, this.backgroundColor);

  @override
  int get hashCode => id;

  @override
  bool operator == (Object other) => other is Item && other.id == id;
}
