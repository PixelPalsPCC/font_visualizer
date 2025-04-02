IntDict variables;

void setup() {

  size(600, 400);

  // Integers within this dictionary are used multiple times in mutliple methods
  variables = new IntDict();

  // Available fonts are a 0 based index
  variables.set("currentFontNum", 0);

  // In case in the future the button sizes should be changed
  variables.set("buttonWidth", 40);
  variables.set("buttonHeight", 40);

  // Loading the font list, then setting the totalFonts variable to the length of the list
  String[] fontList = PFont.list();
  variables.set ("totalFonts", fontList.length);
  println("Total fonts: " + variables.get("totalFonts"));

  fill(0);
  textAlign(CENTER);
  textSize(30);
  text("Total Fonts: \n" + variables.get("totalFonts"), 300, 30);

  /*
   Creation of the button visuals.
   pushMatrix(); and translate(); are changing where the program's 0,0 coordinates are,
   then popMatrix(); reverts the coordinates back to the default location.
   */
  pushMatrix();
  translate((width / 2) - (variables.get("buttonWidth") / 2), height - 10);

  // Not sure if it's good practice, but I find int easier to read than calling on a dictionary.
  int buttonWidth = variables.get("buttonWidth");
  int buttonHeight = variables.get("buttonHeight");

  textSize(20);

  // +1 button
  fill(208, 255, 211);
  rect(buttonWidth, -buttonHeight, buttonWidth, buttonHeight);
  fill(0);
  text("+1", 20 + buttonWidth, -13);

  // -1 button
  fill(255, 208, 208);
  rect(-buttonWidth, -buttonHeight, buttonWidth, buttonHeight);
  fill(0);
  text("-1", -20, -13);

  // +10 button
  fill(156, 255, 163);
  rect(buttonWidth * 2, -buttonHeight, buttonWidth, buttonHeight);
  fill(0);
  text("+10", 20 + (buttonWidth * 2), -13);

  // -10 button
  fill(255, 156, 156);
  rect(-buttonWidth * 2, -buttonHeight, buttonWidth, buttonHeight);
  fill(0);
  text("-10", -20 - buttonWidth, -13);

  // +100 button
  fill(102, 255, 97);
  rect(buttonWidth * 3, -buttonHeight, buttonWidth, buttonHeight);
  fill(0);
  text("+100", 20 + (buttonWidth * 3), -13);

  // -100 button
  fill(255, 97, 97);
  rect(-buttonWidth * 3, -buttonHeight, buttonWidth, buttonHeight);
  fill(0);
  text("-100", -20 - (buttonWidth * 2), -13);

  // Random button
  fill(104, 81, 189);
  rect(0, -buttonHeight, buttonWidth, buttonHeight);
  fill(255);
  text("r", buttonWidth / 2, -13);

  popMatrix();

  // Splitting code that will run often into its own function, remembering the fontList array
  drawVisuals(fontList);
}

void drawVisuals(String[] fontList) {

  // The font generation. This code is copied to every time the function is called on with drawVisuals(fontList);
  fill(255);
  rect(-1, 80, width + 1, height - 130);

  textFont(createFont(fontList[variables.get("currentFontNum")], 128));
  fill(0);
  textSize(20);
  text(fontList[variables.get("currentFontNum")] + "\n Font #" + variables.get("currentFontNum"), 300, 200);

  println("Current font is " + fontList[variables.get("currentFontNum")] + ", which is font #" + variables.get("currentFontNum"));
}

// From what I've learned, your program must have a draw function to keep it running, even if it's empty.
void draw() {
}

/*
This is the code that controls the buttons.
 Each if condition narrows down which button is being pressed.
 When the mouse is pressed, it checks if, in this order:
 1. The mouse position is at the right height to be where the buttons are located
 2. Which button the width is far to the right to be
 3. Where the button ends, so (for example) clicking on +100 doesn't also trigger +10 & +1
 4. If clicking the button will still be within the bounds of the amount of fonts available. If it exceeds the maximum or is below the minimum, the function will not run. If it did, the program would freeze.
 If all the conditions are met, the function goes through, and generates the visual of the font.
 Note that many of these nested if statements could be converted into AND (&&) gates but it would make it harder to read
 */
void mousePressed() {

  int heightButtonBottom = height - (variables.get("buttonWidth") / 4);
  int widthButtonCenter = (width / 2) + (variables.get("buttonWidth") / 2);

  String[] fontList = PFont.list();

  if (mouseY >= heightButtonBottom - variables.get("buttonHeight") && mouseY <= heightButtonBottom) {

    // +1 button
    if (mouseX >= widthButtonCenter) {

      if (mouseX <= widthButtonCenter + variables.get("buttonWidth")) {

        if (variables.get("currentFontNum") < variables.get("totalFonts") - 1) {

          variables.set("currentFontNum", variables.get("currentFontNum") + 1);
        } else {
          println("Could not add +1, array out of bounds");
        }
      }
    }

    // +10 button
    if (mouseX >= widthButtonCenter + variables.get("buttonWidth")) {

      if (mouseX <= widthButtonCenter + (variables.get("buttonWidth") * 2)) {

        if (variables.get("currentFontNum") < variables.get("totalFonts") - 10) {

          variables.set("currentFontNum", variables.get("currentFontNum") + 10);
        } else {
          println("Could not add +10, array out of bounds");
        }
      }
    }

    // +100 button
    if (mouseX >= widthButtonCenter + (variables.get("buttonWidth") * 2)) {

      if (mouseX <= widthButtonCenter + (variables.get("buttonWidth") * 3)) {

        if (variables.get("currentFontNum") < variables.get("totalFonts") - 100) {

          variables.set("currentFontNum", variables.get("currentFontNum") + 100);
        } else {
          println("Could not add +100, array out of bounds");
        }
      }
    }

    // -1 button
    if (mouseX <= widthButtonCenter - variables.get("buttonWidth")) {

      if (mouseX >= widthButtonCenter - (variables.get("buttonWidth") * 2)) {

        if (variables.get("currentFontNum") > 0) {

          variables.set("currentFontNum", variables.get("currentFontNum") - 1);
        } else {
          println("Could not sub -1, array out of bounds");
        }
      }
    }

    // -10 button
    if (mouseX <= widthButtonCenter - (variables.get("buttonWidth") * 2)) {

      if (mouseX >= widthButtonCenter - (variables.get("buttonWidth") * 3)) {

        if (variables.get("currentFontNum") - 9 > 0) {

          variables.set("currentFontNum", variables.get("currentFontNum") - 10);
        } else {
          println("Could not sub -10, array out of bounds");
        }
      }
    }

    // -100 button
    if (mouseX <= widthButtonCenter - (variables.get("buttonWidth") * 3)) {

      if (mouseX >= widthButtonCenter - (variables.get("buttonWidth") * 4)) {

        if (variables.get("currentFontNum") - 99 > 0) {

          variables.set("currentFontNum", variables.get("currentFontNum") - 100);
        } else {
          println("Could not sub -100, array out of bounds");
        }
      }
    }

    // Random font button
    if (mouseX <= widthButtonCenter) {

      if (mouseX >= widthButtonCenter - variables.get("buttonWidth")) {

        variables.set("currentFontNum", int(random(variables.get("totalFonts"))));
      }
    }
  }

  drawVisuals(fontList);
}

// Alternatively, you can adjust the font by 1 with the up and down arrow keys.
void keyPressed() {

  if (key == CODED) {

    String[] fontList = PFont.list();

    if (keyCode == UP) {

      if (variables.get("currentFontNum") < variables.get("totalFonts") - 1) {

        variables.set("currentFontNum", variables.get("currentFontNum") + 1);
      } else {
        println("Could not add +1, array out of bounds");
      }
    } else if (keyCode == DOWN) {

      if (variables.get("currentFontNum") > 0) {

        variables.set("currentFontNum", variables.get("currentFontNum") - 1);
      } else {
        println("Could not sub -1, array out of bounds");
      }
    }

    drawVisuals(fontList);
  }
}
