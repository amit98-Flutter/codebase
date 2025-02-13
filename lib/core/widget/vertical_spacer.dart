import 'package:flutter/cupertino.dart';


class VerticalSpacer extends StatelessWidget {
  const VerticalSpacer({super.key,required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}