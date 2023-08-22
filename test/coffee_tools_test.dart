import 'package:homebrew/utils/coffee_tools.dart';
import 'package:test/test.dart';

void main() {
  group("cupsToOunces", () {
    test('calculates ounces on 1 cup', () {
      var ounces = CoffeeTools.cupsToOunces(1);
      expect(ounces, 6);
    });

    test('calculates ounces on positive number of cups', () {
      var ounces = CoffeeTools.cupsToOunces(4);
      expect(ounces, 24);
    });

    test('throws ArgumentError on zero', () {
      expect(() => CoffeeTools.cupsToOunces(0), throwsArgumentError);
    });

    test('throws ArgumentError on negative number', () {
      expect(() => CoffeeTools.cupsToOunces(0), throwsArgumentError);
    });
  });

  group("Coffee Device Calculations", () {
    // Testing cups to ounces conversion
    test('Conversion from cups to ounces for 3 cups', () {
      var ounces = CoffeeTools.cupsToOunces(3);
      expect(ounces, 18.0);
    });

    // Testing coffee weight calculation for French Press
    test('Coffee weight for French Press with 3 cups', () {
      var weight = CoffeeTools.calculateCoffeeWeight("French Press", 3);
      expect(weight, 3 * 6.0 * 28.25 / 14.0);
    });

    // Testing coffee weight calculation for Drip Machine
    test('Coffee weight for Drip Machine with 3 cups', () {
      var weight = CoffeeTools.calculateCoffeeWeight("Drip Machine", 3);
      expect(weight, 3 * 6.0 * 28.25 / 17.0);
    });

    // Testing water weight calculation
    test('Water weight for 3 cups', () {
      var weight = CoffeeTools.calculateWaterWeight(3);
      expect(weight, 3 * 6.0 * 28.25);
    });

    test('French Press 2 cups', () {
      var coffeeWeight = CoffeeTools.calculateCoffeeWeight("French Press", 2);
      expect(coffeeWeight, 24.214285714285715);

      var waterWeight = CoffeeTools.calculateWaterWeight(2);
      expect(waterWeight, 339.0);
    });

    test('Drip Machine 2 cups', () {
      var coffeeWeight = CoffeeTools.calculateCoffeeWeight("Drip Machine", 2);
      expect(coffeeWeight, 19.941176470588236);

      var waterWeight = CoffeeTools.calculateWaterWeight(2);
      expect(waterWeight, 339.0);
    });

    test('French Press 5 cups', () {
      var coffeeWeight = CoffeeTools.calculateCoffeeWeight("French Press", 5);
      expect(coffeeWeight, 60.535714285714285);

      var waterWeight = CoffeeTools.calculateWaterWeight(5);
      expect(waterWeight, 847.5);
    });

    test('Drip Machine 5 cups', () {
      var coffeeWeight = CoffeeTools.calculateCoffeeWeight("Drip Machine", 5);
      expect(coffeeWeight, 49.85294117647059);
      var waterWeight = CoffeeTools.calculateWaterWeight(5);
      expect(waterWeight, 847.5);
    });
  });

  group("Coffee Cups Inputs", () {
    // Testing input validation
    test('Valid input with a positive number', () {
      expect(CoffeeTools.isValidCupsInput("5"), true);
    });

    test('Invalid input with a negative number', () {
      expect(CoffeeTools.isValidCupsInput("-1"), false);
    });

    test('Invalid input with a special character', () {
      expect(CoffeeTools.isValidCupsInput("/"), false);
    });

    test('Invalid input with a non-numeric value', () {
      expect(CoffeeTools.isValidCupsInput("abc"), false);
    });

    test('Invalid input with zero', () {
      expect(CoffeeTools.isValidCupsInput("0"), false);
    });
  });
}
