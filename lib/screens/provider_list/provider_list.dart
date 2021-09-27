import 'package:flutter/material.dart';
import 'package:flutter_examples/screens/provider_list/models/product.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'cart_screen.dart';
import 'models/cart.dart';

class ProviderListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          toolbarHeight: 120,
          centerTitle: false,
          backgroundColor: Colors.white,
          title: Text('Lays\nShips',
            style:  GoogleFonts.aBeeZee(
                textStyle: TextStyle(
            fontSize: 36, fontWeight: FontWeight.bold, color: Colors.black
          ))),
          floating: true,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyCart()),
                  );
                },
                icon: Icon(Icons.shopping_cart_outlined, color: Colors.blue,size: 30,))
          ],
        ),
      SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return  _MyListItem(ProductModel.fruitsNames[index], index);
            },
            childCount: ProductModel.fruitsNames.length, // 1000 list items
          ),
        ),
      ],
    ));
  }
}

class _MyListItem extends StatelessWidget {
  final Item item;
  final int index;
  const _MyListItem(this.item, this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var item = context.select<ProductModel, Item>(
      // Here, we are only interested in the item at [index]. We don't care
      // about any other change.
      (catalog) => catalog.getByPosition(index),
    );

    return Card(
      margin: EdgeInsets.all(12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      color: item.backgroundColor,
      elevation: 5,
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),

          alignment: Alignment.center,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Start from \$${item.price}.00",
                        style:  GoogleFonts.aBeeZee(
                            textStyle:TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(height: 8),
                      Text(
                        item.name,
                        style:  GoogleFonts.aBeeZee(
                            textStyle:TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                      _AddButton(item: item)
                    ],
                  ),
                  Image.asset(item.image, height: 180, width: 140,)
                ],
              ),
            ],
          )
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final Item item;

  const _AddButton({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // The context.select() method will let you listen to changes to
    // a *part* of a model. You define a function that "selects" (i.e. returns)
    // the part you're interested in, and the provider package will not rebuild
    // this widget unless that particular part of the model changes.
    //
    // This can lead to significant performance improvements.
    var isInCart = context.select<CartModel, bool>(
      // Here, we are only interested whether [item] is inside the cart.
      (test) => test.items.contains(item),
    );

    return Container(
      child: TextButton(
        onPressed: isInCart
            ? null
            : () {
          // If the item is not in cart, we let the user add it.
          // We are using context.read() here because the callback
          // is executed whenever the user taps the button. In other
          // words, it is executed outside the build method.
          var cart = context.read<CartModel>();
          cart.add(item);
        },
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
            if (states.contains(MaterialState.pressed)) {
              return Theme.of(context).primaryColor;
            }
            return null; // Defer to the widget's default.
          }),
        ),
        child: isInCart
            ? const Icon(Icons.check, semanticLabel: 'ADDED')
            : const Text('ADD', style: TextStyle(color: Colors.black),),
      ),
    );
  }
}
