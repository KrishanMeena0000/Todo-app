import 'package:flutter/material.dart%20';
import 'package:login/provider/slidebarprovider.dart';
import 'package:provider/provider.dart';

// class CountExample extends StatefulWidget {
//   const CountExample({Key? key}) : super(key: key);

//   @override
//   State<StatefulWidget> createState() => _CountExampleState();
// }

// class _CountExampleState extends State<CountExample> {
//   @override
//   Widget build(BuildContext context) {
//     final countProvider = Provider.of<CountProvider>(context, listen: false);
//     print("build");
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Count Example"),
//       ),
//       body: Center(child: Consumer<CountProvider>(
//         builder: (context, value, child) {
//           return Text(
//             value.count.toString(),
//             style: TextStyle(fontSize: 50),
//           );
//         },
//       )),
//       floatingActionButton: FloatingActionButton(
//         onPressed: (() => countProvider.setCount()),
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
class ColorOpacity extends StatefulWidget {
  const ColorOpacity({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ColorOpacity();
}

class _ColorOpacity extends State<ColorOpacity> {
  // get floatingActionButton => null;

  @override
  Widget build(BuildContext context) {
    print("build");
    final opacityProvider =
        Provider.of<OpacityProvider>(context, listen: false);
    final countProvider = Provider.of<CountProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(title: Text("")),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.amber.withOpacity(opacityProvider.opacity),
          child: Column(
            children: [
              Consumer<OpacityProvider>(
                builder: (context, value, child) {
                  print("one");
                  return Container(
                      // height: double.infinity,
                      // width: double.infinity,
                      height: 500,
                      width: double.infinity,
                      color: const Color.fromARGB(255, 255, 7, 7)
                          .withOpacity(opacityProvider.opacity),
                      child: Container(
                          alignment: Alignment.topCenter,
                          child: Slider(
                              min: 0,
                              max: 1,
                              value: opacityProvider.opacity,
                              onChanged: ((val) =>
                                  opacityProvider.setValue(val)))));
                },
              ),
              Consumer<CountProvider>(
                builder: (context, value, child) {
                  print("two");
                  return Text(
                    value.count.toString(),
                    style: TextStyle(fontSize: 50),
                  );
                },
              ),
              ElevatedButton(
                onPressed: (() => countProvider.setCount()),
                child: Icon(Icons.add),
              )
            ],
          ),
        ));
  }
}
