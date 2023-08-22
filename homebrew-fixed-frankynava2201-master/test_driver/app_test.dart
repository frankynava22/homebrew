// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  FlutterDriver driver;

  // Connect to the Flutter driver before running any tests.
  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  // Close the connection to the driver after the tests have completed.
  tearDownAll(() async {
    if (driver != null) {
      driver.close();
    }
  });
  group('Happy Paths', () {
    /*
      Given I am on the Coffee Device Selection Screen
      When I tap "French Press"
      And I tap "Continue"
      And I enter "5"
      And I tap "Continue"
      Then I should see "61g - course ground coffee"
      And I should see "848g - water"
    */
    test("should give recommendation for French Press", () async {
      //find French press
      final findFrenchPress = find.text("French Press");
      //find the button
      final findContinueButton = find.text("Continue");

      //click french press
      await driver.tap(findFrenchPress);
      //click continue to move to cup screen
      await driver.tap(findContinueButton);

      //expect to be on cup screen
      expect(await driver.getText(find.text("How many cups would you like?")),
          "How many cups would you like?");

      //find TextField with key
      final textField = find.byValueKey('numCups');

      //tap textbox
      await driver.tap(textField);

      await driver.enterText('5', timeout: Duration(seconds: 1));

      //find continue button
      final cupContinueButton = find.text("Continue");

      //tap the button
      await driver.tap(cupContinueButton);

      expect(await driver.getText(find.text("61g - coarse ground coffee")),
          "61g - coarse ground coffee");

      expect(await driver.getText(find.text("848g - water")), "848g - water");

      //go bck to beginning
      final findDoneButton = find.text("Done");

      await driver.waitFor(findDoneButton);

      //tap the button
      await driver.tap(findDoneButton);
    });

    /*
        Given I am on the Coffee Device Selection Screen
        When I tap "Drip Machine"
        And I tap "Continue"
        And I enter "5"
        And I tap "Continue"
        Then I should see "50g - medium ground coffee"
        And I should see "848g - water"
      */
    test("should give recommendation for Drip Machine", () async {
      //find drip machine
      final findDripMachine = find.text("Drip Machine");
      //find the button
      final findContinueButton = find.text("Continue");

      //click drip machine
      await driver.tap(findDripMachine);
      //click continue to move to cup screen
      await driver.tap(findContinueButton);

      //expect to be on cup screen
      expect(await driver.getText(find.text("How many cups would you like?")),
          "How many cups would you like?");

      //find TextField with key
      final textField = find.byValueKey('numCups');

      //tap textbox
      await driver.tap(textField);

      await driver.enterText('5', timeout: Duration(seconds: 1));

      //find continue button
      final cupContinueButton = find.text("Continue");

      //tap the button
      await driver.tap(cupContinueButton);

      expect(await driver.getText(find.text("50g - medium ground coffee")),
          "50g - medium ground coffee");

      expect(await driver.getText(find.text("848g - water")), "848g - water");

      //go bck to beginning
      final findDoneButton = find.text("Done");
      //tap the button
      await driver.tap(findDoneButton);
    });
  });

  group('Sad Paths', () {
    /*
          Given I am on the Coffee Device Selection Screen
          When I press "Continue"
          Then I expect to still be on the Coffee Device Selection Screen
        */
    test("should not advance from Choose Device Screen without a selection",
        () async {
      // press the "Continue" button
      final continueButton = find.text("Continue");
      await driver.tap(continueButton);

      // validate that we are still on the same screen with txt
      expect(
          await driver.getText(find.text("What coffee maker are you using?")),
          "What coffee maker are you using?");
    });

    /*
            Given I chose "French Press" on the Coffee Device Selection Screen
            And I advanced to the Choose Cups Screen
            When I press "Continue"
            Then I expect to still be on the Choose Cups Screen
          */
    test("should not advance from Choose Cups Screen without cups", () async {
      // Choose "French Press"
      final frenchPressOption = find.text("French Press");
      await driver.tap(frenchPressOption);

      //press the "Continue" button to go to Choose Cups Screen
      final continueButton = find.text("Continue");
      await driver.tap(continueButton);

      // press the "Continue" button without selecting cups
      await driver.tap(continueButton);

      // validate that we are still on the same screen with text
      expect(await driver.getText(find.text("How many cups would you like?")),
          "How many cups would you like?");

      // go back to beginning
      await driver.tap(find.text('<')); // Go back to the beginning
    });

    /*
            Given I chose "French Press" on the Coffee Device Selection Screen
            And I advanced to the Choose Cups Screen
            When I enter "-1"
            And I press "Continue"
            Then I expect to still be on the Choose Cups Screen
          */
    test("should not advance from Choose Cups Screen with negative cup amount",
        () async {
      // Choose "French Press"
      final frenchPressOption = find.text("French Press");
      await driver.tap(frenchPressOption);

      // press the "Continue" button to go to Choose Cups Screen
      final continueButton = find.text("Continue");
      await driver.tap(continueButton);

      final textField = find.byValueKey('numCups');

      //tap textbox
      await driver.tap(textField);

      //type a into text box
      await driver.enterText('-1', timeout: Duration(seconds: 1));

      // press the "Continue" button without selecting cups
      await driver.tap(continueButton);

      // validate that we are still on the same screen with text
      expect(await driver.getText(find.text("How many cups would you like?")),
          "How many cups would you like?");

      await driver.tap(find.text('<'));
    });

    //   /*
    //         Given I chose "French Press" on the Coffee Device Selection Screen
    //         And I advanced to the Choose Cups Screen
    //         When I enter "a"
    //         And I press "Continue"
    //         Then I expect to still be on the Choose Cups Screen
    //       */
    test(
        "should not advance from Choose Cups Screen with letter for cup amount",
        () async {
      //find French press
      final findFrenchPress = find.text("French Press");
      //find the button
      final findContinueButton = find.text("Continue");

      //click french press
      await driver.tap(findFrenchPress);
      //click continue to move to cup screen
      await driver.tap(findContinueButton);

      //expect to be on cup screen
      expect(await driver.getText(find.text("How many cups would you like?")),
          "How many cups would you like?");

      //find TextField with key
      final textField = find.byValueKey('numCups');

      //tap textbox
      await driver.tap(textField);

      //type a into text box
      await driver.enterText('a', timeout: Duration(seconds: 1));

      //find continue button
      final cupContinueButton = find.text("Continue");

      //tap the button
      await driver.tap(cupContinueButton);

      //expect to be on same cup screen again
      expect(await driver.getText(find.text("How many cups would you like?")),
          "How many cups would you like?");

      // go back to beginning
      await driver.tap(find.text('<'));
    });

    /*
          Given I chose "Drip Machine" on the Coffee Device Selection Screen
          And I advanced to the Choose Cups Screen
          When I press "Continue"
          Then I expect to still be on the Choose Cups Screen
        */
    test("should not advance from Choose Cups Screen without cups", () async {
      //find Drip machine
      final findDripMachine = find.text("Drip Machine");
      //find the button
      final findContinueButton = find.text("Continue");

      //click drip machine
      await driver.tap(findDripMachine);
      //click continue to move to cup screen
      await driver.tap(findContinueButton);

      //expect to be on cup screen
      expect(await driver.getText(find.text("How many cups would you like?")),
          "How many cups would you like?");

      //find continue button
      final cupContinueButton = find.text("Continue");

      //tap the button
      await driver.tap(cupContinueButton);

      //expect to be on same cup screen again
      expect(await driver.getText(find.text("How many cups would you like?")),
          "How many cups would you like?");

      // go back to beginning
      await driver.tap(find.text('<'));

      //validate we are at the start again
      expect(
          await driver.getText(find.text("What coffee maker are you using?")),
          "What coffee maker are you using?");
    });

    //   /*
    //       Given I chose "Drip Machine" on the Coffee Device Selection Screen
    //       And I advanced to the Choose Cups Screen
    //       When I enter "-1"
    //       And I press "Continue"
    //       Then I expect to still be on the Choose Cups Screen
    //     */
    test("should not advance from Choose Cups Screen with negative cup amount",
        () async {
      //find Drip Machine
      final findDripMachine = find.text("Drip Machine");
      //find the button
      final findContinueButton = find.text("Continue");

      //click Drip Machine
      await driver.tap(findDripMachine);
      //click continue to move to cup screen
      await driver.tap(findContinueButton);

      //expect to be on cup screen
      expect(await driver.getText(find.text("How many cups would you like?")),
          "How many cups would you like?");

      //find TextField with key
      final textField = find.byValueKey('numCups');

      //tap textbox
      await driver.tap(textField);

      //type -1 into text box
      await driver.enterText('-1', timeout: Duration(seconds: 1));

      //find continue button
      final cupContinueButton = find.text("Continue");

      //tap the button
      await driver.tap(cupContinueButton);

      //expect to be on same cup screen again
      expect(await driver.getText(find.text("How many cups would you like?")),
          "How many cups would you like?");

      // go back to beginning
      await driver.tap(find.text('<'));

      //validate we are at the start again
      expect(
          await driver.getText(find.text("What coffee maker are you using?")),
          "What coffee maker are you using?");
    });

    //   /*
    //       Given I chose "Drip Machine" on the Coffee Device Selection Screen
    //       And I advanced to the Choose Cups Screen
    //       When I enter "a"
    //       And I press "Continue"
    //       Then I expect to still be on the Choose Cups Screen
    //     */
    test(
        "should not advance from Choose Cups Screen with letter for cup amount",
        () async {
      //find Drip Machine
      final findDripMachine = find.text("Drip Machine");
      //find the button
      final findContinueButton = find.text("Continue");

      //click Drip Machine
      await driver.tap(findDripMachine);
      //click continue to move to cup screen
      await driver.tap(findContinueButton);

      //expect to be on cup screen
      expect(await driver.getText(find.text("How many cups would you like?")),
          "How many cups would you like?");

      //find TextField with key
      final textField = find.byValueKey('numCups');

      //tap textbox
      await driver.tap(textField);

      //type 'a' into text box
      await driver.enterText('a', timeout: Duration(seconds: 1));

      //find continue button
      final cupContinueButton = find.text("Continue");

      //tap the button
      await driver.tap(cupContinueButton);

      //expect to be on same cup screen again
      expect(await driver.getText(find.text("How many cups would you like?")),
          "How many cups would you like?");

      // go back to beginning
      await driver.tap(find.text('<'));

      //validate we are at the start again
      expect(
          await driver.getText(find.text("What coffee maker are you using?")),
          "What coffee maker are you using?");
    });
  });

  group('Back Button', () {
    //drip machine back button
    test("works when selecting Drip Machine", () async {
      //find Drip Machine
      final findDripMachine = find.text("Drip Machine");
      //find the button
      final findContinueButton = find.text("Continue");

      //click Drip Machine
      await driver.tap(findDripMachine);
      //click continue to move to cup screen
      await driver.tap(findContinueButton);

      //expect to be on cup screen
      expect(await driver.getText(find.text("How many cups would you like?")),
          "How many cups would you like?");

      // go back to beginning
      await driver.tap(find.text('<'));

      //validate we are at the start again
      expect(
          await driver.getText(find.text("What coffee maker are you using?")),
          "What coffee maker are you using?");
    });

    test("works when selecting French Press", () async {
      //find french press
      final findFrenchPress = find.text("French Press");
      //find the button
      final findContinueButton = find.text("Continue");

      //click french press
      await driver.tap(findFrenchPress);
      //click continue to move to cup screen
      await driver.tap(findContinueButton);

      //expect to be on cup screen
      expect(await driver.getText(find.text("How many cups would you like?")),
          "How many cups would you like?");

      // go back to beginning
      await driver.tap(find.text('<'));

      //validate we are at the start again
      expect(
          await driver.getText(find.text("What coffee maker are you using?")),
          "What coffee maker are you using?");
    });

    test("works when in the result screen for French Press", () async {
      //find French press
      final findFrenchPress = find.text("French Press");
      //find the button
      final findContinueButton = find.text("Continue");

      //click french press
      await driver.tap(findFrenchPress);
      //click continue to move to cup screen
      await driver.tap(findContinueButton);

      //expect to be on cup screen
      expect(await driver.getText(find.text("How many cups would you like?")),
          "How many cups would you like?");

      //find TextField with key
      final textField = find.byValueKey('numCups');

      //tap textbox
      await driver.tap(textField);

      await driver.enterText('5', timeout: Duration(seconds: 1));

      //find continue button
      final cupContinueButton = find.text("Continue");

      //tap the button
      await driver.tap(cupContinueButton);

      expect(await driver.getText(find.text("61g - coarse ground coffee")),
          "61g - coarse ground coffee");

      expect(await driver.getText(find.text("848g - water")), "848g - water");

      // go back
      await driver.tap(find.text('<'));
      // go back to beginning
      await driver.tap(find.text('<'));

      //validate we are at the start again
      expect(
          await driver.getText(find.text("What coffee maker are you using?")),
          "What coffee maker are you using?");
    });

    test("works when in the result screen for Drip Machine", () async {
      //find French press
      final findDripMachine = find.text("Drip Machine");
      //find the button
      final findContinueButton = find.text("Continue");

      //click drip machine
      await driver.tap(findDripMachine);
      //click continue to move to cup screen
      await driver.tap(findContinueButton);

      //expect to be on cup screen
      expect(await driver.getText(find.text("How many cups would you like?")),
          "How many cups would you like?");

      //find TextField with key
      final textField = find.byValueKey('numCups');

      //tap textbox
      await driver.tap(textField);

      await driver.enterText('5', timeout: Duration(seconds: 1));

      //find continue button
      final cupContinueButton = find.text("Continue");

      //tap the button
      await driver.tap(cupContinueButton);

      expect(await driver.getText(find.text("50g - medium ground coffee")),
          "50g - medium ground coffee");

      expect(await driver.getText(find.text("848g - water")), "848g - water");

      // go back
      await driver.tap(find.text('<'));
      // go back to beginning
      await driver.tap(find.text('<'));

      //validate we are at the start again
      expect(
          await driver.getText(find.text("What coffee maker are you using?")),
          "What coffee maker are you using?");
    });
  });
}
