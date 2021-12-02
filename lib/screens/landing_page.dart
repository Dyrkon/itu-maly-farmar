import 'package:flutter/material.dart';
import 'package:maly_farmar/colors/colors.dart';
import 'package:maly_farmar/icons/custom_icons.dart';
import 'package:maly_farmar/providers/auth.dart';
import 'package:provider/src/provider.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  static const routeName = "/landing-page";

  @override
  Widget build(BuildContext context) {
    Color textColor = Colors.black87;

    return Container(
          padding: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Palette.farmersGreen.shade50.withOpacity(0.9),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
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
                                "Klikněte zde\npro nastavení osobních informací",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  overflow: TextOverflow.fade,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
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
                                "Klikněte zde\npro potvrzení objednávek",
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  overflow: TextOverflow.fade,
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
                  Flexible(
                    child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Chápu, jdeme na to!",
                            style: TextStyle(
                              fontSize: 20,
                            ))),
                  ),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Text(
                                "Klikněte zde\npro zobrazení farmářů",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  overflow: TextOverflow.fade,
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
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Text(
                                "Klikněte zde\npro zobrazení aktuální nabídky",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  overflow: TextOverflow.fade,
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
              )
            ],
          ),
    );
  }
}
