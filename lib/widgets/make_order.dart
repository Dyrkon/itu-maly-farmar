import 'package:flutter/material.dart';
import 'package:maly_farmar/models/offer.dart';
import 'package:maly_farmar/providers/orders.dart';
import 'package:maly_farmar/providers/user_provider.dart';
import 'package:maly_farmar/widgets/input_field_widget.dart';
import 'package:provider/provider.dart';
import '/models/order.dart';
import '/colors/colors.dart';

class MakeOrderWidget extends StatefulWidget {
  final Offer offer;

  const MakeOrderWidget(this.offer, {Key? key}) : super(key: key);

  @override
  State<MakeOrderWidget> createState() => _MakeOrderWidgetState();
}

class _MakeOrderWidgetState extends State<MakeOrderWidget> {
  final _amountController = TextEditingController();
  final orderTime = DateTime.now();
  var _date;
  bool _dateIsValid = false;

  Future<bool> _showDatePicker() async {
    _date = await showDatePicker(
        locale: Localizations.localeOf(context),
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 2),);

    if (_date != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var offer = widget.offer;
    var userID = Provider.of<UserProvider>(context).userID;

    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(8),
        width: size.width,
        height: size.height * 1 / 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 5,
            ),
            const Text(
              "Vaše objednávka",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Zvolte množství:",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 25,),
                    Text(
                      "Vyberte datum:",
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    inputField("Množství", _amountController, false,
                        size.width * 1 / 3, 30, true),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: size.width * 1 / 3,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: ElevatedButton(
                         onPressed: () async {
                            _dateIsValid = await _showDatePicker();
                           }
                         , child: const Text("Datum")),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10,),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Vaše rezervace bude předložena prodejci.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 16
                ),
              ),
            ),
            const SizedBox(height:15),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                  "Stav své rezervace můžete sledovat v seznamu objednávek.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                  fontSize: 16
                ),
              ),
            ),
            const Expanded(child: SizedBox.shrink()),
            SizedBox(
              width: size.width * 1 / 1.5,
              child: ElevatedButton(onPressed: () async {
                print(userID);
                if (userID != null && _dateIsValid) {
                  var newOrder = Order(orderTime.toString(), offer.id, Status.pending, int.parse(_amountController.text.trim()), orderTime, _date);
                  var returnVal = await Provider.of<Orders>(context, listen: false).pushOrder(userID, newOrder);

                  if (returnVal == false) {
                    // TODO toast
                  }
                  else {
                    Navigator.of(context).pop();
                  }
                }
                else
                  {
                    // TODO toast
                  }
              }, child: const Text("Potvrdit rezervaci")),
            ),
          ],
        ),
      ),
    );
  }
}
