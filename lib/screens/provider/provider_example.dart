import 'package:flutter/material.dart';
import 'package:flutter_examples/screens/provider/classes/counter.dart';
import 'package:flutter_examples/screens/provider/classes/slider.dart';
import 'package:provider/provider.dart';

class ProviderExampleScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProviderExampleScreenState();
  }
}

class ProviderExampleScreenState extends State<ProviderExampleScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Implement build
    return  Scaffold(
            appBar: AppBar(
              title: Text("Provider Example"),
            ),
            body: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 12),
                  height: 80,
                  color: Colors.lightBlue,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          onPressed: () =>
                              context.read<CounterProv>().increment(),
                          icon: Icon(Icons.add_circle_outline, size: 45)),
                      Text(context.watch<CounterProv>().count.toString(),
                          style: TextStyle(fontSize: 20)),
                      IconButton(
                          onPressed: () =>
                              context.read<CounterProv>().decrement(),
                          icon: Icon(Icons.remove_circle_outline, size: 45))
                    ],
                  ),
                ),


                Container(
                  margin: EdgeInsets.symmetric(vertical: 12),
                  height: 80,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.orange,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(context.watch<SliderProv>().sliderValue.toString(),
                          style: TextStyle(fontSize: 20)),
                      Slider(
                          value: context.watch<SliderProv>().sliderValue,
                          max: 100,
                          min: 0,
                          onChanged: (value) =>
                              context.read<SliderProv>().changeValue(value))
                    ],
                  ),
                ),

                ///Future Provider
                Text("Future Provider",
                    style: TextStyle(fontSize: 20)),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 12),
                  height: 80,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.lightGreen,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${context.watch<String?>()}",
                          style: TextStyle(fontSize: 20)),
                    ],
                  ),
                ),

                ///Stream Provider
                Text("Stream Provider",
                    style: TextStyle(fontSize: 20)),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 12),
                  height: 80,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.teal,
                  child:  Center(
                    child: Consumer<int>(
                      builder: (context, int streamValues, child) {
                        return Text("$streamValues",
                            style: TextStyle(fontSize: 20));
                      },
                    ),
                  ),
                )
              ],
            ));
  }
}
