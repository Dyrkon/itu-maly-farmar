import 'package:flutter/material.dart';
import '/icons/custom_icons.dart';
import '/models/order.dart';
import '/colors/colors.dart';

class MakeOrderWidget extends StatelessWidget {
  var options = List.generate(50, (index) => "$index");


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const Text("Vaše objednávka"),
          Row(
            children: [
              const Text("Vyberte množství: "),
              DropdownButton(
                value: options[0],
                items: options.map((var option) {
                  return DropdownMenuItem(
                    child: Text(option),
                    value: int.parse(option),
                  );
                }).toList(),
                onChanged: (Object? value) {},
              ),
            ],
          ),
          Row(
            children: [
              Text("Vyberte datum: "),
              // TODO add calendar picker
            ],
          ),
          const Text("Vaše rezervace bude předložena prodejci"),
          const Text("Stav své rezervace můžete sledovat v seznamu objednávek"),
          ElevatedButton(
              onPressed: () => {},
              child: const Text("Potvrdit rezervaci"),
          )
        ],
      ),
    );
  }
}
