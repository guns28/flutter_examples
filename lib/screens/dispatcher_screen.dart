import 'package:flutter/material.dart';
import 'package:flutter_examples/screens/provider/classes/counter.dart';
import 'package:flutter_examples/screens/provider/classes/future.dart';
import 'package:flutter_examples/screens/provider/classes/slider.dart';
import 'package:flutter_examples/screens/provider/classes/stream.dart';
import 'package:flutter_examples/screens/provider/provider_example.dart';
import 'package:flutter_examples/screens/provider_list/provider_list.dart';
import 'package:provider/provider.dart';

class DispatcherScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DispatcherScreenState();
  }
}

class DispatcherScreenState extends State<DispatcherScreen> {

  var listItems = ["Provider", "Provider List"];

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: Implement build
    return Scaffold(
      body: ListView.builder(
        padding: EdgeInsets.only(top: 40),
        itemCount: listItems.length,
        shrinkWrap: true,
        key: const ValueKey('dispatcher_list'),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: (){

              switch (index) {
                case 0 : {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>  MultiProvider(
                              providers: [

                                ChangeNotifierProvider(create: (_) => SliderProv()),
                                FutureProvider(
                                    create: (_) => FutureProv().getFutureValue(),
                                    initialData: "Loading..."),
                                StreamProvider(create:(_) => StreamProv().streamValues, initialData: 0)
                              ],
                              child: ProviderExampleScreen() )
                      )
                  );
                }
                break;
                case 1 : {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => ProviderListScreen())
                      ); //
                }
                break;

              }



            },child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: Text(listItems[index],
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                )
            ),
          ),
          );
        },
      )
    );
  }
}
