class ScoreDisplay {
  String message = "";
  float x, y;
  color fillColor; // Utilisez le type color de Processing
  int framesLeft = 0; // Combien de frames avant que le message disparaisse

  ScoreDisplay(float x, float y) {
    this.x = x;
    this.y = y;
  }

  void update(String message, color fillColor, int frames) {
    this.message = message;
    this.fillColor = fillColor;
    this.framesLeft = frames;
  }

  void draw() {
    if (framesLeft > 0) {
      fill(fillColor);
      textSize(32);
      textAlign(CENTER, BOTTOM);
      text(message, x, y);
      framesLeft--;
    }
  }
}
