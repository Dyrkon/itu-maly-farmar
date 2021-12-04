import 'package:flutter/material.dart';
import '../colors/colors.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';

Widget inputField(String text, TextEditingController controller, bool obstruct, double? customWidth, double? customHeight, bool numeric) {
  return Container(
    width: customWidth,
    height: customHeight,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
      border: Border.all(color: Palette.farmersGreen),
    ),
    margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Material(
      child: TextField(
        controller: controller,
        onSubmitted: (val) {
          // TODO add shift focus
          controller.text = val;
        },
        obscureText: obstruct,
        decoration: InputDecoration(
          labelText: text,
          labelStyle: const TextStyle(
            color: Colors.black54,
            fontSize: 16,
          ),
          border: InputBorder.none,
        ),
        keyboardType: numeric ? TextInputType.number : null,
      ),
    ),
  );
}
