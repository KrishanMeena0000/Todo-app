import 'package:flutter/material.dart%20';

class AnimationProvider extends ChangeNotifier {
  Color? color;
  BorderRadius? radius;
  double? height;
  double? width;
  bool? hover;
  AnimationProvider({
    this.color,
    this.radius,
    this.height,
    this.hover,
    this.width,
  });
//   void animate(bool event) {
//     if (event) {
//       height = 70;
//       width = 100;
//       radius = BorderRadius.circular(10);
//       color = Colors.blue[300];
//       Future.delayed(Duration(milliseconds: 500));
//     } else {
//       height = 80;
//       width = 105;
//       radius = BorderRadius.circular(10);
//       color = Colors.green;
//       Future.delayed(Duration(milliseconds: 500));
//     }
//     notifyListeners();
//   }
}
