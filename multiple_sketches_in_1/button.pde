class Button {

  final int COLOR_STATE0 = color(255, 80, 10);
  final int COLOR_STATE1 = color(10, 220, 80);

  int buttonX, buttonY, buttonWidth, buttonHeight;
  boolean overButton, buttonOn;
  String buttonLabel;

  Button(int tempbuttonX, int tempbuttonY, int tempbuttonWidth, int tempbuttonHeight, String tempbuttonLabel) {
    buttonX = tempbuttonX;
    buttonY = tempbuttonY;
    buttonWidth = tempbuttonWidth;
    buttonHeight = tempbuttonHeight;
    buttonLabel = tempbuttonLabel;
  }

  void buttonDisplay() {
    if (buttonOn)
      fill(COLOR_STATE0);
    else
      fill(COLOR_STATE1);
    if (isOver(mouseX, mouseY)) {
      stroke(0);
      strokeWeight(2);
    } else {
      noStroke();
    }
    rect(buttonX, buttonY, buttonWidth, buttonHeight);
    fill( 0);//black for text
    textAlign(CENTER);
    text( buttonLabel, buttonX + buttonWidth/2, buttonY + (buttonHeight/2));
  }

  boolean isOver(int x, int y) {
    return x > buttonX && x < buttonX+buttonWidth && y > buttonY && y < buttonY+buttonHeight;
  }

  boolean hasClicked() {
    boolean changeState = isOver(mouseX, mouseY);
    if (changeState) {
      buttonOn = !buttonOn;
    }
    return changeState;
  }
}
