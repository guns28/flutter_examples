import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_examples/screens/provider/classes/counter.dart';
import 'package:flutter_examples/screens/provider_list/models/product.dart';
import 'package:flutter_examples/screens/provider_list/photo_hero.dart';
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
    timeDilation = 2.0;
    var itemCount = 0;

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
                    ],
                  ),
                  PhotoHero(
                    photo: item.image,
                    width: 140,
                      height: 180,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute<void>(
                          builder: (BuildContext context) {
                            return Scaffold(
                              appBar: AppBar(
                                elevation: 0,
                                toolbarHeight: 120,
                                title: Text(item.name,
                                    textAlign: TextAlign.center,
                                    style:  GoogleFonts.aBeeZee(
                                        textStyle: TextStyle(
                                            fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white
                                        ))),
                              ),
                              body: Container(
                                // The blue background emphasizes that it's a new route.
                                color: item.backgroundColor,
                                padding: const EdgeInsets.all(16.0),
                                alignment: Alignment.topCenter,
                                child:Column(
                                  children: [
                                    PhotoHero(
                                      photo: item.image,
                                      width: 300.0,
                                      height: 300.0,
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      }, key: Key("key"),
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      "Start from \$${item.price}.00",
                                      style:  GoogleFonts.aBeeZee(
                                          textStyle:TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        IconButton(
                                            onPressed: () =>
                                                context.read<CounterProv>().decrement(),
                                            icon: Icon(Icons.remove_circle_outline, size: 45)),
                                        Text(context.watch<CounterProv>().count.toString(),
                                            style: TextStyle(fontSize: 26, color: Colors.white)),
                                        IconButton(
                                            onPressed: () =>
                                                context.read<CounterProv>().increment(),
                                            icon: Icon(Icons.add_circle_outline, size: 45)),

                                      ],
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        itemCount = Provider.of<CounterProv>(context, listen: false).count;
                                        print(itemCount);
                                        var cart = context.read<CartModel>();
                                        for(var i = 1;i <= itemCount;i++ ){
                                          cart.add(item);
                                        }
                                        context.read<CounterProv>().reset();
                                      },
                                      style: ButtonStyle(
                                        overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                                          if (states.contains(MaterialState.pressed)) {
                                            return Theme.of(context).primaryColor;
                                          }
                                          return null; // Defer to the widget's default.
                                        }),
                                      ),
                                      child: Text('ADD TO CART', style: TextStyle(color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                )
                              ),
                            );
                          }
                      ));
                    }, key: Key("key"),
                  )
                ],
              ),
            ],
          )
      ),
    );
  }
}
