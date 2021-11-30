import 'package:flutter/material.dart';
import 'package:maly_farmar/colors/colors.dart';
import 'package:maly_farmar/icons/custom_icons.dart';
import 'package:maly_farmar/providers/auth.dart';
import 'package:provider/src/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Palette.farmersGreen.shade50.withOpacity(0.9),
      ),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Transform.rotate(
                              angle: -0.3,
                              child: const Icon(
                                CustomIcons.arrow_up,
                                color: Palette.farmersGreen,
                                size: 60,
                              ),
                            ),
                            const Text(
                              "Klikněte zde pro nastavení osobních informací",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2 - 40,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Transform.rotate(
                              angle: 0.5,
                              child: const Icon(
                                CustomIcons.arrow_up,
                                color: Palette.farmersGreen,
                                size: 60,
                              ),
                            ),
                            const Text(
                              "Klikněte zde pro potvrzení objednávek",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3.75,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () => {
                            // TODO redo shared prefs
                          },
                          child: const Text("Chápu, jdeme na to!",
                              style: TextStyle(
                                fontSize: 20,
                              )))
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              "Klikněte zde pro zobrazení aktuální nabídky",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(
                              CustomIcons.arrow_down,
                              color: Palette.farmersGreen,
                              size: 60,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2 - 40,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          //mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Text(
                              "Klikněte zde pro zobrazení farmářů",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(
                              CustomIcons.arrow_down,
                              color: Palette.farmersGreen,
                              size: 60,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
