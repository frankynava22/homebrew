class CoffeeTools {
  // Constant for water weight/ounce in g
  static const double waterWeightPerOunce = 28.25; // 177.42g

  //how we find the weight of the coffee
  static double calculateCoffeeWeight(String coffeeDevice, int numCups) {
    double ratio;
    if (coffeeDevice == "French Press") {
      ratio = 14.0; // 1/14 ratio for French Press
    } else {
      ratio = 17.0; // 1/17 ratio for Drip Machine
    }
    double ounces = cupsToOunces(numCups);
    double waterWeight = ounces * waterWeightPerOunce;
    return waterWeight / ratio;
  }

  //how we calculate weight of water
  static double calculateWaterWeight(int cups) {
    double ounces = cupsToOunces(cups);
    return ounces * waterWeightPerOunce;
  }

  // Input: number of cups (positive integer)
  // Output: number of ounces in a cup
  //modified to double
  static double cupsToOunces(int cups) {
    if (cups <= 0) {
      throw ArgumentError();
    }
    return cups * 6.0;
  }

  // Input: positive integer for amount of cups
  // Output: enabled button for inputting valid entry
  static bool isValidCupsInput(String text) {
    int value = int.tryParse(text) ?? 0;
    return value > 0;
  }
}
