class TilePattern {
  float time; // Temps en secondes depuis le début de la musique
  int[] columns; // Colonnes où les tuiles apparaîtront
  
  TilePattern(float time, int[] columns) {
    this.time = time;
    this.columns = columns;
  }
}

ArrayList<TilePattern> sequence = new ArrayList<TilePattern>();
