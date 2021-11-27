import 'package:flutter/material.dart';
import '/icons/custom_icons.dart';
import '/models/order.dart';
import '/colors/colors.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class MakeOrderWidget extends StatefulWidget {
  @override
  State<MakeOrderWidget> createState() => _MakeOrderWidgetState();
}

class _MakeOrderWidgetState extends State<MakeOrderWidget> {
  var options = List.generate(50, (index) => "$index");

  void _showDatePicker() {
    showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(DateTime.now().year + 2));
  }

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
              // TODO style more
              const Text("Vyberte datum: "),
              ElevatedButton(
                  onPressed: _showDatePicker,
                  child: const Text("Datum"),
              )
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
