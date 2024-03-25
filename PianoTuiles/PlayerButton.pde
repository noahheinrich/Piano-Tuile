class PlayerButton {
  String title;
  float x, y, width, height;

  PlayerButton(String title, float x, float y, float width, float height) {
    this.title = title;
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
  }

  boolean isClicked() {
    return mouseX >= x && mouseX <= x + width && mouseY >= y && mouseY <= y + height && mousePressed;
  }
}
