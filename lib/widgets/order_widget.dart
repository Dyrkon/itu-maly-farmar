import 'package:flutter/material.dart';
import 'package:maly_farmar/icons/custom_icons.dart';
import 'package:maly_farmar/models/order.dart';
import 'package:maly_farmar/models/product.dart';
import 'package:maly_farmar/models/user.dart';
import 'package:maly_farmar/providers/products.dart';
import 'package:maly_farmar/providers/tabs.dart';
import 'package:maly_farmar/providers/user_provider.dart';
import 'package:provider/provider.dart';
import '../colors/colors.dart';

class OrderWidget extends StatefulWidget {
  final Order order;
  final deny;
  final confirm;

  const OrderWidget(this.order, this.deny, this.confirm, {Key? key})
      : super(key: key);

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {

  Widget productPictureBuilder(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.hasData || snapshot.hasError) {
      return Container(
        width: MediaQuery.of(context).size.height * 1 / 10,
        height: MediaQuery.of(context).size.height * 1 / 10,
        decoration: BoxDecoration(
          borderRadius:
              const BorderRadius.horizontal(left: Radius.circular(10)),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              snapshot.data ??
                  "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse4.mm.bing.net%2Fth%3Fid%3DOIP.MMYJL8WjVmwsUZvNP1pdJgHaHT%26pid%3DApi&f=1",
            ),
          ),
        ),
      );
    } else {
      return Container(
        width: MediaQuery.of(context).size.height * 1 / 9,
        height: MediaQuery.of(context).size.height * 1 / 9,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.horizontal(left: Radius.circular(10)),
        ),
        child: const CircularProgressIndicator(),
      );
    }
  }

  Widget productsDetailsBuilder(BuildContext context, AsyncSnapshot snapshot, Order order) {

    if (snapshot.hasData) {
      Product product = snapshot.data;
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            product.productName,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Text(
            "Množství:",
            style: TextStyle(fontSize: 16),
          ),
          Text(
            order.orderedAmount.toString() + " " + product.unit,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      );
    }
    else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          Text(
            "...",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            "Množství:",
            style: TextStyle(fontSize: 16),
          ),
          Text(
            "... ...",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      );
    }
  }

  Widget userNameBuilder(BuildContext context, AsyncSnapshot snapshot) {
    if (snapshot.hasData) {
      UserProfile user = snapshot.data;
      return Text(
        user.fullName,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      );
    } else if (snapshot.hasError) {
      return const Center(
        child: Text(
          'Nastala chyba',
          style: TextStyle(fontSize: 18),
        ),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var order = widget.order;
    bool isConfirmed = order.status == Status.confirmedBySeller;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          color: isConfirmed ? Palette.farmersGreen.shade200 : Colors.grey[200],
          borderRadius: BorderRadius.circular(10)),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 1 / 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
           FutureBuilder(
            future:
                Provider.of<Products>(context).getProductImage(order.productID),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              return productPictureBuilder(context, snapshot);
            },
          ),
          Row(
            children: [
              const SizedBox(
                width: 5,
              ),
             FutureBuilder(
                future: Provider.of<Products>(context).getProduct(order.productID),
                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    return productsDetailsBuilder(context, snapshot, order);
                  }
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FutureBuilder(
                      future: Provider.of<UserProvider>(context).getUserFromProductID(order.productID),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        return userNameBuilder(context, snapshot);
                      }),
                  const Text(
                    "Datum vyzvednutí",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    order.pickupTime.day.toString() +
                        ". " +
                        order.pickupTime.month.toString() +
                        ".",
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Provider.of<Tabs>(context).isFarmer && !isConfirmed
                  ? SizedBox(
                      width: 20,
                      child: IconButton(
                        onPressed: () {
                          widget.deny(order.orderID);
                        },
                        icon: const Icon(
                          CustomIcons.times,
                          size: 20,
                          color: Colors.red,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              SizedBox(
                  width: Provider.of<Tabs>(context).isFarmer
                      ? 10
                      : 0 //isConfirmed ? 0 : 10,
                  ),
              (isConfirmed && !Provider.of<Tabs>(context).isFarmer) ||
                      (!isConfirmed && Provider.of<Tabs>(context).isFarmer)
                  ? SizedBox(
                      width: 20,
                      child: IconButton(
                        onPressed: () {
                          widget.confirm(order.orderID);
                        },
                        icon: const Icon(CustomIcons.check),
                        color: Colors.green[600],
                        iconSize: 20,
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
          const SizedBox(
            width: 5,
          ),
        ],
      ),
    );
  }
}
