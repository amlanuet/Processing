class Button {

  final int COLOR_STATE0 = color(170, 246, 131);
  final int COLOR_STATE1 = color(10, 220, 80);

  int buttonX, buttonY, buttonWidth, buttonHeight;
  boolean overButton, buttonOn;
  String buttonLabel;
  PApplet buttonParent;

  Button(int tempbuttonX, int tempbuttonY, int tempbuttonWidth, int tempbuttonHeight, String tempbuttonLabel, PApplet parent) {
    buttonX = tempbuttonX;
    buttonY = tempbuttonY;
    buttonWidth = tempbuttonWidth;
    buttonHeight = tempbuttonHeight;
    buttonLabel = tempbuttonLabel;
    buttonParent = parent;
  }

  void buttonDisplay() {
    buttonParent.fill(COLOR_STATE0);
    if (isOver(buttonParent.mouseX, buttonParent.mouseY)) {
      buttonParent.stroke(0);
      buttonParent.strokeWeight(2);
    } else {
      buttonParent.noStroke();
    }
    buttonParent.rect(buttonX, buttonY, buttonWidth, buttonHeight);
    buttonParent.fill( 0);//black for text
    buttonParent.textAlign(CENTER);
    buttonParent.text( buttonLabel, buttonX + buttonWidth/2, buttonY + (buttonHeight/2));
  }

  boolean isOver(int x, int y) {
    return x > buttonX && x < buttonX+buttonWidth && y > buttonY && y < buttonY+buttonHeight;
  }

  boolean hasClicked() {
    boolean changeState = isOver(buttonParent.mouseX, buttonParent.mouseY);
    if (changeState) {
      buttonOn = !buttonOn;
    }
    return changeState;
  }
}
