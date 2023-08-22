import 'package:flutter/material.dart';
import 'results_screen.dart';
import '../utils/coffee_tools.dart';

class NumCups extends StatefulWidget {
  final String coffeeMaker; // Selected coffee maker

  NumCups(this.coffeeMaker);

  @override
  _NumCupsState createState() => _NumCupsState(); // Creating state
}

class _NumCupsState extends State<NumCups> {
  final TextEditingController _controller = TextEditingController();
  bool validInput = false; // Valid input flag

  // Handles text status
  void textStatus(String text) {
    setState(() {
      validInput =
          CoffeeTools.isValidCupsInput(text); // Check validity coffee_tools
    });
  }

  @override
  // Clean up resources
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Text('<',
              style: TextStyle(fontSize: 40, color: Color(0xFF4C748B))),
          onPressed: () => Navigator.of(context).pop(), // back to prev
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding all sides
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'How many cups would you like?', //text for cups
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF4C748B), // Text color
                fontSize: 18,
                fontWeight: FontWeight.normal, // Regular weight
              ),
            ),
            SizedBox(height: 20), // Spacing
            TextField(
              key: ValueKey('numCups'),
              controller: _controller,
              keyboardType: TextInputType.number, // Numeric input
              onChanged: textStatus,
              textAlign: TextAlign.center, // Text align
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xFFF3F3F3),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20), // Rounded border
                  borderSide: BorderSide(color: Color(0xFF4C748B)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20), // Same here
                  borderSide: BorderSide(color: Color(0xFF4C748B)),
                ),
              ),
              style: TextStyle(
                color: Color(0xFF4C748B), // Text color
              ),
            ),
            SizedBox(height: 20), // Spcing
            ElevatedButton(
              onPressed: validInput
                  ? () {
                      // Push user choices
                      int numberOfCups =
                          int.parse(_controller.text); // Parse cups
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultsScreen(
                              widget.coffeeMaker,
                              numberOfCups), // Navigate to results
                        ),
                      );
                    }
                  : null,
              child: Text('Continue'),
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
                        : Color(0xFF4C748B),
                  ),
                ),
                minimumSize: MaterialStateProperty.all<Size>(Size(320, 50)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
