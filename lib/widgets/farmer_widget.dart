import 'package:flutter/material.dart';

class farmerWidget extends StatelessWidget {
  farmerWidget({Key? key}) : super(key: key);

  //farmerWidget({Key key, this.name, this.amount, this.pricPerUnit, this.unit, this.profilePicture})

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
          children: <Widget>[
           Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(image: new AssetImage("../../assets/images/profile_picture_test.png"), fit: BoxFit.cover,),
          ),
            Column(
              children: [
               Container(child: const Text("Vojtěch Novák")),
               Container(child: const Text("60ks"))
              ]
              ,
              ),
              Column(children: [const Text("4Kč/ks")])
          ],
        ),
      );
    }
}
