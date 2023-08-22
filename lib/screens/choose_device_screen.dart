import 'package:flutter/material.dart';
import 'package:homebrew/screens/num_cups_screen.dart';

class ChooseDeviceScreen extends StatefulWidget {
  @override
  _ChooseDeviceScreenState createState() => _ChooseDeviceScreenState();
}

class _ChooseDeviceScreenState extends State<ChooseDeviceScreen> {
  bool frenchPressPressed = false; // Track French Press selection
  bool dripMachinePressed = false; // track Drip Machine selecton

  // Toggle coffee maker selection
  void chooseCoffeeMaker(bool isFrenchPress) {
    setState(() {
      frenchPressPressed = isFrenchPress;
      dripMachinePressed = !isFrenchPress;
    });
  }

  // Check if continue allowed
  bool get continueButtonStatus => frenchPressPressed || dripMachinePressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F3F3), // Background color
      appBar: null,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "What coffee maker are you using?", // Question text
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF4C748B),
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20), // Spacing
            Container(
              width: 280, // Box width
              child: Column(
                children: [
                  _buildOptionRow(frenchPressPressed,
                      "French Press"), // French Press option
                  _buildOptionRow(dripMachinePressed,
                      "Drip Machine"), // Drip Machine option
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: continueButtonStatus // Continue button logic function
                  ? () {
                      String choice =
                          frenchPressPressed ? "French Press" : "Drip Machine";
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              NumCups(choice), // Navigation to next screen
                        ),
                      );
                    }
                  : null,
              child: Text(
                "Continue", // Continue button text
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: continueButtonStatus ? null : Color(0xFF757474),
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) =>
                      states.contains(MaterialState.disabled)
                          ? Color(0xFFE2E2E2)
                          : Color(0xFF4C748B), // Button color
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Button shape
                  ),
                ),
                side: MaterialStateProperty.resolveWith<BorderSide>(
                  (Set<MaterialState> states) => BorderSide(
                    width: 2,
                    color: states.contains(MaterialState.disabled)
                        ? Color(0xFFE2E2E2)
                        : Color(0xFF4C748B), //border color
                  ),
                ),
                minimumSize: MaterialStateProperty.all<Size>(
                    Size(320, 50)), // Button size
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build option row
  Widget _buildOptionRow(bool isSelected, String text) {
    return GestureDetector(
      onTap: () => chooseCoffeeMaker(text == "French Press"),
      child: Container(
        height: 50, // Hight options
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF4C748B)), // Border color
          borderRadius: text == "French Press"
              ? BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                )
              : BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10), // Birder radius
                ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16), // Left padding for text
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF4C748B), // Text style
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (isSelected)
              Padding(
                padding:
                    EdgeInsets.only(right: 16), // Right padding for checkmark
                child: Icon(Icons.check,
                    color: Color(
                        0xFF4C748B)), // Checkmark logo for right side of options
              ),
          ],
        ),
      ),
    );
  }
}
