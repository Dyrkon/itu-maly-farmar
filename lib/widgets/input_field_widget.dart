import 'package:flutter/material.dart';
import '../colors/colors.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';

Widget inputField(String text, padding,
    TextEditingController controller, bool obstruct, context) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
      border: Border.all(color: Palette.farmersGreen),
    ),
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: TextField(
      controller: controller,
      onSubmitted: (val) {
        if (Provider.of<Auth>(context, listen: false).isValid(val, context, controller) == false) {
          return;
        }
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
    ),
  );
}