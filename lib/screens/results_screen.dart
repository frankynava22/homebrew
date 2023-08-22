import 'package:flutter/material.dart';
import '../utils/coffee_tools.dart';
import 'choose_device_screen.dart';

class ResultsScreen extends StatelessWidget {
  final String coffeeMaker;
  final int cups;

  ResultsScreen(this.coffeeMaker, this.cups); // Coffee maker and cups data

  @override
  Widget build(BuildContext context) {
    //coffee calculations are located here
    double waterWeight = CoffeeTools.calculateWaterWeight(cups);
    double coffeeWeight = CoffeeTools.calculateCoffeeWeight(coffeeMaker, cups);

    //UI rounds not functions
    int coffeeWeightRounded = coffeeWeight.round(); // Rounded coffee weight
    int waterWeightRounded = waterWeight.round(); // Rounded water weight

    String grindType =
        coffeeMaker == "French Press" ? "coarse" : "medium"; // Set grind type

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Text('<',
              style: TextStyle(fontSize: 40, color: Color(0xFF4C748B))),
          onPressed: () =>
              Navigator.of(context).pop(), // Return to previous screen
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Uniform padding
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(20.0), // Padding for container
                  decoration: BoxDecoration(
                    color: Color(0xFFF3F3F3),
                    borderRadius: BorderRadius.circular(10), // Rounded border
                    border:
                        Border.all(color: Color(0xFF4C748B)), // Border color
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Recommended',
                          style: TextStyle(
                              color: Color(0xFF4C748B),
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Kollektif')),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 5, bottom: 20), // Line padding
                        child: Container(
                            height: 1,
                            width: MediaQuery.of(context).size.width * 0.8,
                            color: Color(0xFF4C748B)), // Separator line ----
                      ),
                      Text('${coffeeWeightRounded}g - $grindType ground coffee',
                          style: TextStyle(
                              color: Color(0xFF4C748B),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Kollektif')), // Coffee info
                      Text('${waterWeightRounded}g - water',
                          style: TextStyle(
                              color: Color(0xFF4C748B),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              fontFamily: 'Kollektif')), // Water info
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20), // Padding for text
                        child: Text('Enjoy your delicious coffee.',
                            style: TextStyle(
                                color: Color(0xFF4C748B),
                                fontSize: 10,
                                fontStyle: FontStyle.italic,
                                fontFamily: 'Montserrat')), // Enjoy message
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  // Navigate to ChooseDeviceScreen
                  context,
                  MaterialPageRoute(builder: (context) => ChooseDeviceScreen()),
                  (Route<dynamic> route) => false,
                );
              },
              child: Text('Done'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) =>
                        states.contains(MaterialState.disabled)
                            ? Color(0xFFE2E2E2)
                            : Color(0xFF4C748B)), // Background color
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))), // Shape
                side: MaterialStateProperty.resolveWith<BorderSide>(
                    (Set<MaterialState> states) => BorderSide(
                        width: 2,
                        color: states.contains(MaterialState.disabled)
                            ? Color(0xFFE2E2E2)
                            : Color(0xFF4C748B))), // Side
                minimumSize: MaterialStateProperty.all<Size>(
                    Size(320, 50)), // Minimum size
              ),
            ),
          ],
        ),
      ),
    );
  }
}
