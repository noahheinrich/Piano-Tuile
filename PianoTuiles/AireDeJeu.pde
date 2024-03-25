// import des librairies
import ddf.minim.*;
import java.util.HashSet;
import javax.swing.JOptionPane;
import java.util.ArrayList;


// définition des variables pour les sons
Minim minim;
AudioPlayer rap;
AudioPlayer pop;
AudioPlayer rock;
AudioPlayer classique;

// définition des variables pour l'animation du coeur
SpriteAnim heart1;
SpriteAnim heart2;
SpriteAnim heart3;
SpriteAnim heart4;
SpriteAnim heart5;
SpriteAnim heart6;

// définition des variables pour les polices et les images
PFont kaviron;
PImage backgroundImg;
PImage pink_tile_1p, blue_tile_1p, gold_tile_1p;
PImage button, blue_button, pink_button, gold_button;

// joueur 1
ArrayList<Tile> tiles1 = new ArrayList<Tile>();
int combo1 = 0;
int score1 = 0;

// joueur 2
ArrayList<Tile> tiles2 = new ArrayList<Tile>();
int combo2 = 0;
int score2 = 0;

int nbPlayers = 1;

// variables pour le jeu
float tileWidth;
float tileHeight;
int speed = 15;
int rodHeight = 750;

boolean isTilePressed = false;
boolean isDuoMode = false;

// variables pour le gameState
final int MODE = 0;
final int TITLE = 1;
final int GAME = 2;
final int END = 3;
final int SCORE = 4;

int gameState = MODE;

// variables pour le score du ROCK
String[] Rolines;
String Roline1, Roline2, Roline3, Roline4, Roline5;

String[] Roparts1, Roparts2, Roparts3, Roparts4, Roparts5;
int Ronumber1, Ronumber2, Ronumber3, Ronumber4, Ronumber5;

// variables pour le score du RAP
String[] Ralines;
String Raline1, Raline2, Raline3, Raline4, Raline5;

String[] Raparts1, Raparts2, Raparts3, Raparts4, Raparts5;
int Ranumber1, Ranumber2, Ranumber3, Ranumber4, Ranumber5;

// variables pour le score de la POP
String[] plines;
String pline1, pline2, pline3, pline4, pline5;

String[] pparts1, pparts2, pparts3, pparts4, pparts5;
int pnumber1, pnumber2, pnumber3, pnumber4, pnumber5;

// variables pour le score du CLASSIQUE
String[] clines;
String cline1, cline2, cline3, cline4, cline5;

String[] cparts1, cparts2, cparts3, cparts4, cparts5;
int cnumber1, cnumber2, cnumber3, cnumber4, cnumber5;

// variable pour récupérer le nom de joueur si jamais il rentre dans le top score
String userInput = "";

int scoreSelection;

// variables pour la séléction de la musique et du mode avec les flèches et la touche entrée
boolean enterPressed = false;
boolean enterPressed_ = false;
int currentSelection = 0;

// variables pour la vie
int maxHealth;
int health;

float songStartTime;
int sequenceIndex = 0;
float delayAfterLastTile;
float endSequenceTime = 0;

String lastScoreMessage = "";

// variables pour les boutons
ScoreDisplay[] scoreDisplays = new ScoreDisplay[4];
SequenceButton[] sequenceButtons = new SequenceButton[4];
PlayerButton[] playerButtons = new PlayerButton[2];

void setup() {
  fullScreen();
  maxHealth = 6;
  health = maxHealth;
  
  for (int i = 0; i < scoreDisplays.length; i++) {
    scoreDisplays[i] = new ScoreDisplay((i + 0.5) * tileWidth, rodHeight - 50);
  }

  // Initialisation des musiques
  minim = new Minim(this);
  rap = minim.loadFile("rap.mp3");
  pop = minim.loadFile("pop.mp3");
  rock = minim.loadFile("rock.mp3");
  classique = minim.loadFile("classique.mp3");
  LoadFile();
  
  // Initialisation des images
  backgroundImg = loadImage("data/Ecran_Fin.jpg");
  pink_tile_1p = loadImage("data/Tuile_J1.jpg");
  blue_tile_1p = loadImage("data/Tuile_J2.jpg");
  gold_tile_1p = loadImage("data/Tuile_Gold.jpg");
  button = loadImage("data/Bouton_inactif.png");
  blue_button = loadImage("data/Bouton_J1.png");
  pink_button = loadImage("data/Bouton_J2.png");
  gold_button = loadImage("data/Bouton_gold.png");
  
  // Initialisation des polices
  kaviron = loadFont("KavironRegular-48.vlw");
  textFont(kaviron,48);
  
  // Initialisation des animations
  heart1 = new SpriteAnim("coeur.png",2,50);
  heart2 = new SpriteAnim("coeur.png",2,40);
  heart3 = new SpriteAnim("coeur.png",2,30);
  heart4 = new SpriteAnim("coeur.png",2,20);
  heart5 = new SpriteAnim("coeur.png",2,10);
  heart6 = new SpriteAnim("coeur.png",2,5);
}

void LoadFile(){
  Rolines = loadStrings("scorero.txt");
  Ralines = loadStrings("scorera.txt");
  plines = loadStrings("scorep.txt");
  clines = loadStrings("scorec.txt");
  
  // Parcourt le tableau de chaînes et attribue chaque ligne à une variable
  if (Rolines.length >= 5) {
    Roline1 = Rolines[0];
    Roline2 = Rolines[1];
    Roline3 = Rolines[2];
    Roline4 = Rolines[3];
    Roline5 = Rolines[4];
    
    Roparts1 = split(Roline1, ':');
    Roparts2 = split(Roline2, ':');
    Roparts3 = split(Roline3, ':');
    Roparts4 = split(Roline4, ':');
    Roparts5 = split(Roline5, ':');
    
    Ronumber1 = int(trim(Roparts1[1]));
    Ronumber2 = int(trim(Roparts2[1]));
    Ronumber3 = int(trim(Roparts3[1]));
    Ronumber4 = int(trim(Roparts4[1]));
    Ronumber5 = int(trim(Roparts5[1]));
    
    // Affiche les variables
    //println("Ligne 1: " + Roline1);
    //println("Ligne 2: " + Roline2);
    //println("Ligne 3: " + Roline3);
  }else {
    println("Le fichier ne contient pas suffisamment de lignes.");
  }
 if (Ralines.length >= 5) {
    Raline1 = Ralines[0];
    Raline2 = Ralines[1];
    Raline3 = Ralines[2];
    Raline4 = Ralines[3];
    Raline5 = Ralines[4];
    
    Raparts1 = split(Raline1, ':');
    Raparts2 = split(Raline2, ':');
    Raparts3 = split(Raline3, ':');
    Raparts4 = split(Raline4, ':');
    Raparts5 = split(Raline5, ':');
    
    Ranumber1 = int(trim(Raparts1[1]));
    Ranumber2 = int(trim(Raparts2[1]));
    Ranumber3 = int(trim(Raparts3[1]));
    Ranumber4 = int(trim(Raparts4[1]));
    Ranumber5 = int(trim(Raparts5[1]));
    
    // Affiche les variables
    //println("Ligne 1: " + Roline1);
    //println("Ligne 2: " + Roline2);
    //println("Ligne 3: " + Roline3);
  }else {
    println("Le fichier ne contient pas suffisamment de lignes.");
  }
  if (plines.length >= 5) {
    pline1 = plines[0];
    pline2 = plines[1];
    pline3 = plines[2];
    pline4 = plines[3];
    pline5 = plines[4];
    
    pparts1 = split(pline1, ':');
    pparts2 = split(pline2, ':');
    pparts3 = split(pline3, ':');
    pparts4 = split(pline4, ':');
    pparts5 = split(pline5, ':');
    
    pnumber1 = int(trim(pparts1[1]));
    pnumber2 = int(trim(pparts2[1]));
    pnumber3 = int(trim(pparts3[1]));
    pnumber4 = int(trim(pparts4[1]));
    pnumber5 = int(trim(pparts5[1]));
    
    // Affiche les variables
    //println("Ligne 1: " + Roline1);
    //println("Ligne 2: " + Roline2);
    //println("Ligne 3: " + Roline3);
  }else {
    println("Le fichier ne contient pas suffisamment de lignes.");
  }
  if (clines.length >= 5) {
    cline1 = clines[0];
    cline2 = clines[1];
    cline3 = clines[2];
    cline4 = clines[3];
    cline5 = clines[4];
    
    cparts1 = split(cline1, ':');
    cparts2 = split(cline2, ':');
    cparts3 = split(cline3, ':');
    cparts4 = split(cline4, ':');
    cparts5 = split(cline5, ':');
    
    cnumber1 = int(trim(cparts1[1]));
    cnumber2 = int(trim(cparts2[1]));
    cnumber3 = int(trim(cparts3[1]));
    cnumber4 = int(trim(cparts4[1]));
    cnumber5 = int(trim(cparts5[1]));
    
    // Affiche les variables
    //println("Ligne 1: " + Roline1);
    //println("Ligne 2: " + Roline2);
    //println("Ligne 3: " + Roline3);
  }else {
    println("Le fichier ne contient pas suffisamment de lignes.");
  } 
}

void setupSequenceClas() {
  if (classique != null){
    classique.play();
  }
  delayAfterLastTile = 5.0;
  // Exemple : Générer des tuiles dans la 1ère et 3ème colonnes à 1.0s, puis dans la 2ème et 4ème à 2.5s
  sequence.add(new TilePattern(1.0, new int[]{0, 2}));
  sequence.add(new TilePattern(2.5, new int[]{1, 3}));
  sequence.add(new TilePattern(3.0, new int[]{0})); 
  sequence.add(new TilePattern(3.5, new int[]{1})); 
  sequence.add(new TilePattern(4.0, new int[]{2})); 
  sequence.add(new TilePattern(4.5, new int[]{3})); 
  sequence.add(new TilePattern(5.0, new int[]{0, 1})); 
  sequence.add(new TilePattern(5.5, new int[]{2, 3})); 
  sequence.add(new TilePattern(6.0, new int[]{1, 2})); 
  sequence.add(new TilePattern(6.5, new int[]{0, 3})); 
  sequence.add(new TilePattern(7.0, new int[]{0, 2})); 
  sequence.add(new TilePattern(7.5, new int[]{1, 3})); 
  sequence.add(new TilePattern(8.0, new int[]{0, 1, 2})); 
  sequence.add(new TilePattern(8.5, new int[]{1, 2, 3})); 
  sequence.add(new TilePattern(9.0, new int[]{0, 2, 3})); 
  sequence.add(new TilePattern(9.5, new int[]{0, 1, 3})); 
  sequence.add(new TilePattern(10.0, new int[]{0, 1, 2, 3})); 
  sequence.add(new TilePattern(11.0, new int[]{0, 1})); 
  sequence.add(new TilePattern(11.5, new int[]{2, 3})); 
  sequence.add(new TilePattern(12.0, new int[]{1, 2})); 
  sequence.add(new TilePattern(12.5, new int[]{0, 3})); 
  sequence.add(new TilePattern(13.0, new int[]{0, 2})); 
  sequence.add(new TilePattern(13.5, new int[]{1, 3})); 
  sequence.add(new TilePattern(14.0, new int[]{0, 1, 2})); 
  sequence.add(new TilePattern(14.5, new int[]{1, 2, 3})); 
  sequence.add(new TilePattern(15.0, new int[]{0, 2, 3})); 
  sequence.add(new TilePattern(15.5, new int[]{0, 1, 3})); 
  sequence.add(new TilePattern(16.0, new int[]{0, 1, 2, 3})); 
  sequence.add(new TilePattern(16.5, new int[]{1, 3})); 
  sequence.add(new TilePattern(17.0, new int[]{0, 1, 2})); 
  sequence.add(new TilePattern(17.5, new int[]{1, 2, 3})); 
  sequence.add(new TilePattern(18.0, new int[]{0, 2, 3})); 
  sequence.add(new TilePattern(18.5, new int[]{0, 1, 3})); 
  sequence.add(new TilePattern(19.0, new int[]{0, 1, 2, 3})); 
  sequence.add(new TilePattern(19.5, new int[]{0, 1})); 
  sequence.add(new TilePattern(20.0, new int[]{2, 3})); 
  sequence.add(new TilePattern(20.5, new int[]{1, 2})); 
  sequence.add(new TilePattern(21.0, new int[]{0, 3})); 
  sequence.add(new TilePattern(21.5, new int[]{0, 2})); 
  sequence.add(new TilePattern(22.0, new int[]{1, 3})); 
  // Ajoutez plus selon le rythme et la structure que vous souhaitez
}

void setupSequenceRock() {
   if (rock != null){
    rock.play();
  }
  sequence.add(new TilePattern(5.9, new int[]{0, 3}));
  sequence.add(new TilePattern(6.1, new int[]{1, 2}));
}

void setupSequenceRap() {
  delayAfterLastTile = 5.0;
  if (rap != null){
    rap.play();
  }
  sequence.add(new TilePattern(3.5, new int[]{0, 2}));
  sequence.add(new TilePattern(5.8, new int[]{1, 3}));
  sequence.add(new TilePattern(6.7, new int[]{0, 2}));
  sequence.add(new TilePattern(9.2, new int[]{1, 3}));
  sequence.add(new TilePattern(10.0, new int[]{0, 2}));
  sequence.add(new TilePattern(12.5, new int[]{0, 3}));
  sequence.add(new TilePattern(13.5, new int[]{1, 2}));
  sequence.add(new TilePattern(15.1, new int[]{0, 1, 3}));
  sequence.add(new TilePattern(15.6, new int[]{2}));
  sequence.add(new TilePattern(16.7, new int[]{0, 2}));
  sequence.add(new TilePattern(19.0, new int[]{0, 2}));
  sequence.add(new TilePattern(20.0, new int[]{1, 3}));
  sequence.add(new TilePattern(22.2, new int[]{0, 2}));
  sequence.add(new TilePattern(23.5, new int[]{1, 3}));
  sequence.add(new TilePattern(25.5, new int[]{0, 2}));
  sequence.add(new TilePattern(26.7, new int[]{1, 3}));
  sequence.add(new TilePattern(29.0, new int[]{0, 2}));
  sequence.add(new TilePattern(30.0, new int[]{1, 3}));
  sequence.add(new TilePattern(30.8, new int[]{0, }));
  sequence.add(new TilePattern(32.2, new int[]{0, 2}));
  sequence.add(new TilePattern(33.5, new int[]{1, 3}));
  sequence.add(new TilePattern(35.5, new int[]{0, 3}));
  sequence.add(new TilePattern(36.8, new int[]{1, 2}));
  sequence.add(new TilePattern(37.5, new int[]{3}));
  sequence.add(new TilePattern(39.0, new int[]{1, 3}));
  sequence.add(new TilePattern(40.2, new int[]{0}));
  sequence.add(new TilePattern(42.3, new int[]{1, 3}));
  sequence.add(new TilePattern(43.0, new int[]{0, 2, 3}));
  sequence.add(new TilePattern(44.3, new int[]{1}));
  sequence.add(new TilePattern(45.0, new int[]{2}));
  sequence.add(new TilePattern(45.5, new int[]{0, 3}));
  sequence.add(new TilePattern(46.8, new int[]{2}));
  sequence.add(new TilePattern(49.0, new int[]{1}));
  sequence.add(new TilePattern(50.0, new int[]{0, 2}));
  sequence.add(new TilePattern(50.8, new int[]{3}));
  sequence.add(new TilePattern(52.3, new int[]{1, 3}));
  sequence.add(new TilePattern(53.5, new int[]{1, 3}));
  sequence.add(new TilePattern(55.5, new int[]{0, 2}));
  sequence.add(new TilePattern(56.7, new int[]{0, 3}));
  sequence.add(new TilePattern(57.5, new int[]{0, 2}));
  sequence.add(new TilePattern(59.0, new int[]{1, 3}));
  sequence.add(new TilePattern(60.2, new int[]{1, 2}));
  sequence.add(new TilePattern(62.2, new int[]{0, 1}));
  sequence.add(new TilePattern(63.5, new int[]{2, 3}));
  sequence.add(new TilePattern(64.3, new int[]{1, 3}));
  sequence.add(new TilePattern(65.7, new int[]{2, 3}));
  sequence.add(new TilePattern(66.8, new int[]{1, 2 }));
  sequence.add(new TilePattern(69.0, new int[]{0, 2 }));
  sequence.add(new TilePattern(70.0, new int[]{0, 2 }));
  sequence.add(new TilePattern(72.2, new int[]{1, 3 }));
  sequence.add(new TilePattern(73.0, new int[]{0, 2 }));
  sequence.add(new TilePattern(75.5, new int[]{0, 2 }));
  sequence.add(new TilePattern(76.5, new int[]{1, 3 }));
  sequence.add(new TilePattern(79.0, new int[]{0, 2 }));
  sequence.add(new TilePattern(80.0, new int[]{1, 3 }));
  sequence.add(new TilePattern(82.1, new int[]{1, 2 }));
  sequence.add(new TilePattern(83.3, new int[]{0, 3 }));
  sequence.add(new TilePattern(84.2, new int[]{2}));
  sequence.add(new TilePattern(85.5, new int[]{0, 1 }));
  sequence.add(new TilePattern(86.7, new int[]{0, 1 }));
  sequence.add(new TilePattern(89.0, new int[]{0, 2 }));
  sequence.add(new TilePattern(90.0, new int[]{1, 3 }));
  sequence.add(new TilePattern(90.8, new int[]{0}));
  sequence.add(new TilePattern(92.3, new int[]{1, 3 }));
  sequence.add(new TilePattern(93.5, new int[]{1, 3 }));
  sequence.add(new TilePattern(95.5, new int[]{0, 2 }));
  sequence.add(new TilePattern(96.5, new int[]{1, 3 }));
  sequence.add(new TilePattern(99.4, new int[]{2, 3 }));
  sequence.add(new TilePattern(100.6, new int[]{0, 1 }));
  sequence.add(new TilePattern(102.5, new int[]{0, 2 }));
  sequence.add(new TilePattern(103.5, new int[]{1, 3 }));
  sequence.add(new TilePattern(105.7, new int[]{0, 2 }));
  sequence.add(new TilePattern(106.7, new int[]{1, 3 }));
}

void setupSequencePop() {
  if (pop != null){
    pop.play();
  }
  delayAfterLastTile = 3.0;
  sequence.add(new TilePattern(0.5, new int[]{0}));
  sequence.add(new TilePattern(1.0, new int[]{1}));
  sequence.add(new TilePattern(1.5, new int[]{0}));
  sequence.add(new TilePattern(2.0, new int[]{1}));
  sequence.add(new TilePattern(2.5, new int[]{2}));
  sequence.add(new TilePattern(3.0, new int[]{3}));
  sequence.add(new TilePattern(3.5, new int[]{2}));
  sequence.add(new TilePattern(4.0, new int[]{3}));
  sequence.add(new TilePattern(4.5, new int[]{0}));
  sequence.add(new TilePattern(5.0, new int[]{1}));
  sequence.add(new TilePattern(5.5, new int[]{0}));
  sequence.add(new TilePattern(6.0, new int[]{1}));
  sequence.add(new TilePattern(6.5, new int[]{0}));
  sequence.add(new TilePattern(7.0, new int[]{1}));
  sequence.add(new TilePattern(7.5, new int[]{0, 1, 2, 3}));
  sequence.add(new TilePattern(8.0, new int[]{0}));
  sequence.add(new TilePattern(8.5, new int[]{1}));
  sequence.add(new TilePattern(9.0, new int[]{2}));
  sequence.add(new TilePattern(9.5, new int[]{3}));
  sequence.add(new TilePattern(10.0, new int[]{0}));
  sequence.add(new TilePattern(10.5, new int[]{1}));
  sequence.add(new TilePattern(11.0, new int[]{2}));
  sequence.add(new TilePattern(11.5, new int[]{3}));
  sequence.add(new TilePattern(12.0, new int[]{0}));
  sequence.add(new TilePattern(12.5, new int[]{1}));
  sequence.add(new TilePattern(13.0, new int[]{2}));
  sequence.add(new TilePattern(13.5, new int[]{3}));
  sequence.add(new TilePattern(14.0, new int[]{0}));
  sequence.add(new TilePattern(14.5, new int[]{1}));
  sequence.add(new TilePattern(15.0, new int[]{2}));
  sequence.add(new TilePattern(15.5, new int[]{3}));
  sequence.add(new TilePattern(17.0, new int[]{3}));
  sequence.add(new TilePattern(17.5, new int[]{2}));
  sequence.add(new TilePattern(18.0, new int[]{1}));
  sequence.add(new TilePattern(18.5, new int[]{0}));
  sequence.add(new TilePattern(19.0, new int[]{3}));
  sequence.add(new TilePattern(19.5, new int[]{2}));
  sequence.add(new TilePattern(20.0, new int[]{1}));
  sequence.add(new TilePattern(20.5, new int[]{0}));
  sequence.add(new TilePattern(21.0, new int[]{3}));
  sequence.add(new TilePattern(21.5, new int[]{2}));
  sequence.add(new TilePattern(22.0, new int[]{1}));
  sequence.add(new TilePattern(22.5, new int[]{0}));
  sequence.add(new TilePattern(23.0, new int[]{3}));
  sequence.add(new TilePattern(23.5, new int[]{2}));
  sequence.add(new TilePattern(24.0, new int[]{1}));
  sequence.add(new TilePattern(24.5, new int[]{0}));
  sequence.add(new TilePattern(25.5, new int[]{0, 3}));
  sequence.add(new TilePattern(26.0, new int[]{1, 2}));
  sequence.add(new TilePattern(26.5, new int[]{0, 3}));
  sequence.add(new TilePattern(27.0, new int[]{1, 2}));
  sequence.add(new TilePattern(27.5, new int[]{0, 3}));
  sequence.add(new TilePattern(28.0, new int[]{1, 2}));
  sequence.add(new TilePattern(28.5, new int[]{0, 3}));
  sequence.add(new TilePattern(29.0, new int[]{1, 2}));
  sequence.add(new TilePattern(30.5, new int[]{0}));
  sequence.add(new TilePattern(31.0, new int[]{1}));
  sequence.add(new TilePattern(31.5, new int[]{2}));
  sequence.add(new TilePattern(32.0, new int[]{3}));
  sequence.add(new TilePattern(32.25, new int[]{0}));
  sequence.add(new TilePattern(34.0, new int[]{0, 3}));
  sequence.add(new TilePattern(34.5, new int[]{1, 2}));
  sequence.add(new TilePattern(35.0, new int[]{0, 3}));
  sequence.add(new TilePattern(35.5, new int[]{1, 2}));
  sequence.add(new TilePattern(36.0, new int[]{0, 3}));
  sequence.add(new TilePattern(36.5, new int[]{1, 2}));
  sequence.add(new TilePattern(37.0, new int[]{0, 3}));
  sequence.add(new TilePattern(37.5, new int[]{1, 2}));
  sequence.add(new TilePattern(38.75, new int[]{3}));
  sequence.add(new TilePattern(39.25, new int[]{2}));
  sequence.add(new TilePattern(39.75, new int[]{1}));
  sequence.add(new TilePattern(40.25, new int[]{0}));
  sequence.add(new TilePattern(40.5, new int[]{3}));
  sequence.add(new TilePattern(41.5, new int[]{0}));
  sequence.add(new TilePattern(42.0, new int[]{1}));
  sequence.add(new TilePattern(42.5, new int[]{0}));
  sequence.add(new TilePattern(43.0, new int[]{1}));
  sequence.add(new TilePattern(43.5, new int[]{0}));
  sequence.add(new TilePattern(44.0, new int[]{1}));
  sequence.add(new TilePattern(44.5, new int[]{2}));
  // sequence.add(new TilePattern(45.5, new int[]{2}));
  sequence.add(new TilePattern(45.5, new int[]{3}));
  sequence.add(new TilePattern(46.0, new int[]{2}));
  sequence.add(new TilePattern(46.5, new int[]{3}));
  sequence.add(new TilePattern(47.0, new int[]{2}));
  sequence.add(new TilePattern(47.5, new int[]{3}));
  sequence.add(new TilePattern(48.0, new int[]{2}));
  sequence.add(new TilePattern(48.5, new int[]{1}));
  // sequence.add(new TilePattern(49.5, new int[]{1}));
  sequence.add(new TilePattern(49.5, new int[]{0}));
  sequence.add(new TilePattern(50.0, new int[]{1}));
  sequence.add(new TilePattern(50.5, new int[]{0}));
  sequence.add(new TilePattern(51.0, new int[]{1}));
  sequence.add(new TilePattern(51.5, new int[]{0}));
  sequence.add(new TilePattern(52.0, new int[]{1}));
  sequence.add(new TilePattern(52.5, new int[]{2}));
  // sequence.add(new TilePattern(53.0, new int[]{3}));
  sequence.add(new TilePattern(53.5, new int[]{3}));
  sequence.add(new TilePattern(54.0, new int[]{2}));
  sequence.add(new TilePattern(54.5, new int[]{3}));
  sequence.add(new TilePattern(55.0, new int[]{2}));
  sequence.add(new TilePattern(55.5, new int[]{3}));
  sequence.add(new TilePattern(56.0, new int[]{2}));
  sequence.add(new TilePattern(56.5, new int[]{1}));
   sequence.add(new TilePattern(57.5, new int[]{0, 3}));
  sequence.add(new TilePattern(58.0, new int[]{1, 2}));
  sequence.add(new TilePattern(59.5, new int[]{0, 3}));
  sequence.add(new TilePattern(59.0, new int[]{1, 2}));
  sequence.add(new TilePattern(59.5, new int[]{0, 3}));
  sequence.add(new TilePattern(60.0, new int[]{1, 2}));
  sequence.add(new TilePattern(60.5, new int[]{0, 3}));
  sequence.add(new TilePattern(61.0, new int[]{1, 2}));
  sequence.add(new TilePattern(61.5, new int[]{0}));
  sequence.add(new TilePattern(62.0, new int[]{1}));
  sequence.add(new TilePattern(62.5, new int[]{2}));
  sequence.add(new TilePattern(63.0, new int[]{3}));
  sequence.add(new TilePattern(63.25, new int[]{0}));
  sequence.add(new TilePattern(64.0, new int[]{0, 3}));
  sequence.add(new TilePattern(64.5, new int[]{1, 2}));
  sequence.add(new TilePattern(65.0, new int[]{0, 3}));
  sequence.add(new TilePattern(65.5, new int[]{1, 2}));
  sequence.add(new TilePattern(66.0, new int[]{0, 3}));
  sequence.add(new TilePattern(66.5, new int[]{1, 2}));
  sequence.add(new TilePattern(67.0, new int[]{0, 3}));
  sequence.add(new TilePattern(67.5, new int[]{1, 2}));
  sequence.add(new TilePattern(68.75, new int[]{3}));
  sequence.add(new TilePattern(69.25, new int[]{2}));
  sequence.add(new TilePattern(69.75, new int[]{1}));
  sequence.add(new TilePattern(70.25, new int[]{0}));
  sequence.add(new TilePattern(70.5, new int[]{3}));
}

void draw() {
  switch(gameState) {
    case MODE:
      displayModeScreen();
      break;
    case TITLE:
      displayTitleScreen();
      break;
    case GAME:
      displayGameScreen();
      break;
    case END:
      displayEndScreen();
      break;
    case SCORE:
      displayScoreScreen();
      break;
  }
  tileWidth = width / (nbPlayers * 4); // Divise l'écran en 4 colonnes.
}

void displayScoreScreen(){
  if (sequenceIndex >= sequence.size() && tiles1.isEmpty()){
      if(isDuoMode==false){
          CheckScore();
          if(scoreSelection==2){
            PrintWriter writer = createWriter("scorero.txt");
            writer.println(Roline1);
            writer.println(Roline2);
            writer.println(Roline3);
            writer.println(Roline4);
            writer.println(Roline5);
            writer.flush(); // Assure que toutes les données sont écrites
            writer.close(); // Ferme le fichier
            
          }else if(scoreSelection==3){
            PrintWriter writer = createWriter("scorera.txt");
            writer.println(Raline1);
            writer.println(Raline2);
            writer.println(Raline3);
            writer.println(Raline4);
            writer.println(Raline5);
            writer.flush(); // Assure que toutes les données sont écrites
            writer.close(); // Ferme le fichier
            
          }else if(scoreSelection==1){
            PrintWriter writer = createWriter("scorec.txt");
            writer.println(cline1);
            writer.println(cline2);
            writer.println(cline3);
            writer.println(cline4);
            writer.println(cline5);
            writer.flush(); // Assure que toutes les données sont écrites
            writer.close(); // Ferme le fichier
            
          }else if(scoreSelection==4){
            PrintWriter writer = createWriter("scorep.txt");
            writer.println(pline1);
            writer.println(pline2);
            writer.println(pline3);
            writer.println(pline4);
            writer.println(pline5);
            writer.flush(); // Assure que toutes les données sont écrites
            writer.close(); // Ferme le fichier
            
          }
          gameState = END;
        }else if(isDuoMode==true){
           gameState = END;
        }
      }else{
         if(scoreSelection==2){
            PrintWriter writer = createWriter("scorero.txt");
            writer.println(Roline1);
            writer.println(Roline2);
            writer.println(Roline3);
            writer.println(Roline4);
            writer.println(Roline5);
            writer.flush(); // Assure que toutes les données sont écrites
            writer.close(); // Ferme le fichier
            
          }else if(scoreSelection==3){
            PrintWriter writer = createWriter("scorera.txt");
            writer.println(Raline1);
            writer.println(Raline2);
            writer.println(Raline3);
            writer.println(Raline4);
            writer.println(Raline5);
            writer.flush(); // Assure que toutes les données sont écrites
            writer.close(); // Ferme le fichier
            
          }else if(scoreSelection==1){
            PrintWriter writer = createWriter("scorec.txt");
            writer.println(cline1);
            writer.println(cline2);
            writer.println(cline3);
            writer.println(cline4);
            writer.println(cline5);
            writer.flush(); // Assure que toutes les données sont écrites
            writer.close(); // Ferme le fichier
            
          }else if(scoreSelection==4){
            PrintWriter writer = createWriter("scorep.txt");
            writer.println(pline1);
            writer.println(pline2);
            writer.println(pline3);
            writer.println(pline4);
            writer.println(pline5);
            writer.flush(); // Assure que toutes les données sont écrites
            writer.close(); // Ferme le fichier
            
          }
          gameState = END;
  }
}

void CheckScore(){
  if(scoreSelection == 2){
     if(score1>Ronumber5 &&score1>Ronumber4 && score1>Ronumber3 && score1>Ronumber2 && score1>Ronumber1){
        userInput = JOptionPane.showInputDialog("Veuillez saisir votre texte :");
        Roline5 = Roline4;
        Roline4 = Roline3;
        Roline3 = Roline2;
        Roline2 = Roline1;
        Roline1 = userInput +" : "+ score1;
      }else if(score1>Ronumber5 &&score1>Ronumber4 && score1>Ronumber3 && score1>Ronumber2){
         userInput = JOptionPane.showInputDialog("Veuillez saisir votre texte :");
         Roline5 = Roline4;
         Roline4 = Roline3;
         Roline3 = Roline2;
         Roline2 = userInput +" : "+ score1;
      }else if(score1>Ronumber5 &&score1>Ronumber4 && score1>Ronumber3){
         userInput = JOptionPane.showInputDialog("Veuillez saisir votre texte :");
         Roline5 = Roline4;
         Roline4 = Roline3;
         Roline3 = userInput +" : "+ score1;
      }
      else if(score1>Ronumber5 &&score1>Ronumber4 ){
         userInput = JOptionPane.showInputDialog("Veuillez saisir votre texte :");
         Roline5 = Roline4;
         Roline4 = userInput +" : "+ score1;;
         
      }
      else if(score1>Ronumber5){
         userInput = JOptionPane.showInputDialog("Veuillez saisir votre texte :");
         Roline5 = userInput +" : "+ score1;
        
      }
  }else if(scoreSelection == 3){
      if(score1>Ranumber5 &&score1>Ranumber4 && score1>Ranumber3 && score1>Ranumber2 && score1>Ranumber1){
        userInput = JOptionPane.showInputDialog("Veuillez saisir votre texte :");
        Raline5 = Raline4;
        Raline4 = Raline3;
        Raline3 = Raline2;
        Raline2 = Raline1;
        Raline1 = userInput +" : "+ score1;
      }else if(score1>Ranumber5 &&score1>Ranumber4 && score1>Ranumber3 && score1>Ranumber2){
         userInput = JOptionPane.showInputDialog("Veuillez saisir votre texte :");
         Raline5 = Raline4;
         Raline4 = Raline3;
         Raline3 = Raline2;
         Raline2 = userInput +" : "+ score1;
      }else if(score1>Ranumber5 &&score1>Ranumber4 && score1>Ranumber3){
         userInput = JOptionPane.showInputDialog("Veuillez saisir votre texte :");
         Raline5 = Raline4;
         Raline4 = Raline3;
         Raline3 = userInput +" : "+ score1;
      }
      else if(score1>Ranumber5 &&score1>Ranumber4 ){
         userInput = JOptionPane.showInputDialog("Veuillez saisir votre texte :");
         Raline5 = Raline4;
         Raline4 = userInput +" : "+ score1;
         
      }
      else if(score1>Ranumber5){
         userInput = JOptionPane.showInputDialog("Veuillez saisir votre texte :");
         Raline5 = userInput +" : "+ score1;
        
      }
    
  }else if(scoreSelection == 1){
     if(score1>cnumber5 &&score1>cnumber4 && score1>cnumber3 && score1>cnumber2 && score1>cnumber1){
        userInput = JOptionPane.showInputDialog("Veuillez saisir votre texte :");
        cline5 = cline4;
        cline4 = cline3;
        cline3 = cline2;
        cline2 = cline1;
        cline1 = userInput +" : "+ score1;
      }else if(score1>cnumber5 &&score1>cnumber4 && score1>cnumber3 && score1>cnumber2){
         userInput = JOptionPane.showInputDialog("Veuillez saisir votre texte :");
         cline5 = cline4;
         cline4 = cline3;
         cline3 = cline2;
         cline2 = userInput +" : "+ score1;
      }else if(score1>cnumber5 &&score1>cnumber4 && score1>cnumber3){
         userInput = JOptionPane.showInputDialog("Veuillez saisir votre texte :");
         cline5 = cline4;
         cline4 = cline3;
         cline3 = userInput +" : "+ score1;
      }
      else if(score1>cnumber5 &&score1>cnumber4 ){
         userInput = JOptionPane.showInputDialog("Veuillez saisir votre texte :");
         cline5 = cline4;
         cline4 = userInput +" : "+ score1;
         
      }
      else if(score1>cnumber5){
         userInput = JOptionPane.showInputDialog("Veuillez saisir votre texte :");
         cline5 = userInput +" : "+ score1;
        
      }
  }else if(scoreSelection == 4){
     if(score1>pnumber5 &&score1>pnumber4 && score1>pnumber3 && score1>pnumber2 && score1>pnumber1){
        userInput = JOptionPane.showInputDialog("Veuillez saisir votre texte :");
        pline5 = pline4;
        pline4 = pline3;
        pline3 = pline2;
        pline2 = pline1;
        pline1 = userInput +" : "+ score1;
      }else if(score1>pnumber5 &&score1>pnumber4 && score1>pnumber3 && score1>pnumber2){
         userInput = JOptionPane.showInputDialog("Veuillez saisir votre texte :");
         pline5 = pline4;
         pline4 = pline3;
         pline3 = pline2;
         pline2 = userInput +" : "+ score1;
      }else if(score1>pnumber5 &&score1>pnumber4 && score1>pnumber3){
         userInput = JOptionPane.showInputDialog("Veuillez saisir votre texte :");
         pline5 = pline4;
         pline4 = pline3;
         pline3 = userInput +" : "+ score1;
      }
      else if(score1>pnumber5 &&score1>pnumber4 ){
         userInput = JOptionPane.showInputDialog("Veuillez saisir votre texte :");
         pline5 = pline4;
         pline4 = userInput +" : "+ score1;
         
      }
      else if(score1>pnumber5){
         userInput = JOptionPane.showInputDialog("Veuillez saisir votre texte :");
         pline5 = userInput +" : "+ score1;
        
      }
  }
}

void displayModeScreen() {
  playerButtons[0] = new PlayerButton("1 Player", width/2-100, height/2, 100, 50);
  playerButtons[1] = new PlayerButton("2 Players", width/2-100, height/2+100, 100, 50);
  image(backgroundImg, 0, 0);
  textSize(90);
  textAlign(CENTER, CENTER);
  text("PIANO TUILES", width/2-30, 150);
  displayPlayerButtons();
  
  for (int i = 0; i < playerButtons.length; i++) {
    PlayerButton button = playerButtons[i];
    if (i == currentSelection && enterPressed_) {
      // Changer la séquence en fonction du bouton cliqué
      if (button.title.equals("1 Player")) {
        gameState = TITLE;
      } else if (button.title.equals("2 Players")) {
        isDuoMode = true;
        gameState = TITLE;
      }
    }
  }
}

void displayTitleScreen() {
  songStartTime = millis();
  sequenceButtons[0] = new SequenceButton("CLASSIQUE", width/2-150, 200, 300, 100);
  sequenceButtons[1] = new SequenceButton("ROCK", width/2-150, 350, 300, 100);
  sequenceButtons[2] = new SequenceButton("RAP", width/2-150, 500, 300, 100);
  sequenceButtons[3] = new SequenceButton("POP", width/2-150, 650, 300, 100);
  background(0);
  image(backgroundImg, 0, 0);
  displaySequenceButtons();
  
  for (int i = 0; i < sequenceButtons.length; i++) {
    SequenceButton button = sequenceButtons[i];
    if (i == currentSelection && enterPressed) {
      // Changer la séquence en fonction du bouton cliqué
      if (button.title.equals("CLASSIQUE")) {
        scoreSelection=1;
        setupSequenceClas();
        gameState = GAME;
      } else if (button.title.equals("ROCK")) {
        scoreSelection=2;
        setupSequenceRock();
        gameState = GAME;
      } else if (button.title.equals("RAP")) {
        scoreSelection=3;
        setupSequenceRap();
        gameState = GAME;
      } else if (button.title.equals("POP")) {
        scoreSelection=4;
        setupSequencePop();
        gameState = GAME;
      }
    }
  }
}

void displayGameScreen() {
  float currentTime = (millis() - songStartTime) / 1000.0; // Temps actuel en secondes
  
  // Générer les tuiles selon la séquence
  while (sequenceIndex < sequence.size() && currentTime >= sequence.get(sequenceIndex).time) {
    for (int column : sequence.get(sequenceIndex).columns) {
      spawnTile(column);
    }
    sequenceIndex++;
  }
  
  background(255);
  image(backgroundImg, 0, 0);
  drawHUD();
  moveTiles();
  drawTiles();
  
  for (ScoreDisplay sd : scoreDisplays) {
    sd.draw();
  }
  
  if (sequenceIndex >= sequence.size() && tiles1.isEmpty() && endSequenceTime == 0) {
    endSequenceTime = millis(); // Enregistrez le moment où la dernière tuile a été traitée
  }

  if (endSequenceTime > 0 && millis() - endSequenceTime >= delayAfterLastTile * 1000) {
      gameState = SCORE; // Retournez au menu après le délai spécifique
      endSequenceTime = 0; // Réinitialisez pour la prochaine fois
  }
}

void displayEndScreen() {
  Rolines = loadStrings("scorero.txt"); 
  Ralines = loadStrings("scorera.txt"); 
  clines = loadStrings("scorec.txt"); 
  plines = loadStrings("scorep.txt"); 
  //for (String line : lines) {
   //println(line);
  //}
  image(backgroundImg, 0, 0);
  textSize(32);
  textAlign(CENTER, CENTER);
  fill(255);
  if (health <= 0) {
        text("Dommage, vous avez perdu !", width / 2, height / 2);
    }
    // Vérifie si le joueur a réussi à terminer la séquence sans épuiser sa santé
    else if (sequenceIndex >= sequence.size() && tiles1.isEmpty()) {
        
        text("Félicitations, vous avez réussi !", width / 2, height / 2);
    }
    if(isDuoMode==false){
      if(scoreSelection == 2){
        float RolinesY = height - Rolines.length * 20 - 400;
        for (int i = 0; i < Rolines.length; i++) {
           text(Rolines[i], width / 2, RolinesY + i * 35); // Affiche chaque ligne avec un espacement de 20 pixels
        }
      }else if(scoreSelection == 3){
        float RalinesY = height - Ralines.length * 20 - 400;
        for (int i = 0; i < Ralines.length; i++) {
           text(Ralines[i], width / 2, RalinesY + i * 35); // Affiche chaque ligne avec un espacement de 20 pixels
        }
      }else if(scoreSelection == 1){
        float clinesY = height - clines.length * 20 - 400;
        for (int i = 0; i < clines.length; i++) {
           text(clines[i], width / 2, clinesY + i * 35); // Affiche chaque ligne avec un espacement de 20 pixels
        }
      }else if(scoreSelection == 4){
        float plinesY = height - plines.length * 20 - 400;
        for (int i = 0; i < plines.length; i++) {
           text(plines[i], width / 2, plinesY + i * 35); // Affiche chaque ligne avec un espacement de 20 pixels
        }
      }
    }else if(isDuoMode==true){
      text("player1 : " +score1 , width / 3, height / 1.5);
      text("player2 : " +score2 , width / 1.5, height / 1.5);
    }
}

void drawHUD() {
  // Dessiner la barre
  rect(0, rodHeight, 2000, 2);
  noStroke();
  
  displayCombo();
  drawHealthBar();
  displayScore();
}

void displayPlayerButtons() {
  for (int i = 0; i < playerButtons.length; i++) {
    PlayerButton button = playerButtons[i];
    fill(0, 0, 0, 0);
    noStroke();
    rect(button.x, button.y, button.width, button.height);
    textAlign(CENTER, CENTER);
    textSize(64);
    if (i == currentSelection) {
      fill(221, 160, 221);  // Couleur du bouton sélectionné
    } else {
      fill(0);  // Couleur des autres boutons
    }
    text(button.title, button.x + button.width/2, button.y + button.height/2);
  }
}

void displaySequenceButtons() {
  for (int i = 0; i < sequenceButtons.length; i++) {
    SequenceButton button = sequenceButtons[i];
    fill(0, 0, 0, 0);
    noStroke();
    rect(button.x, button.y, button.width, button.height);
    textAlign(CENTER, CENTER);
    textSize(64);
    if (i == currentSelection) {
      fill(221, 160, 221);  // Couleur du bouton sélectionné
    } else {
      fill(0); // Couleur des autres boutons
    }
    text(button.title, button.x + button.width/2, button.y + button.height/2);
  }
}

void drawHealthBar() {
  if (!isDuoMode){
    fill(#FD0400); // Couleur rouge pour la barre de vie
    float healthWidth = (width * 0.8) * (health / (float)maxHealth); // Calcul de la largeur de la barre de vie basé sur la santé actuelle
    float barHeight = 26;
    float borderRadius = 13;
    rect(width * 0.15, height - 75, healthWidth, barHeight, borderRadius);
    
    // Détermine quel sprite de cœur utiliser en fonction de la santé actuelle
    SpriteAnim currentHeartSprite;
    if (health > 5) {
      currentHeartSprite = heart1;
    } else if (health > 4) {
      currentHeartSprite = heart2;
    } else if (health > 3) {
      currentHeartSprite = heart3;
    } else if (health > 2) {
      currentHeartSprite = heart4;
    } else if (health > 1) {
      currentHeartSprite = heart5;
    } else {
      currentHeartSprite = heart6;
    }
    // Dessine le sprite du cœur approprié
    currentHeartSprite.anim(50, height - 110);
  }
}

void displayCombo() {
  if (!isDuoMode){
    fill(255);
    textSize(32);
    textAlign(RIGHT, TOP);
    text("Combo: " + combo1, width-80, 10);
  } else  {
    fill(255);
    textSize(32);
    textAlign(RIGHT, TOP);
    text("Combo: " + combo1, width/2-100, 10);
    textSize(32);
    textAlign(LEFT, TOP);
    text("Combo: " + combo2, width-150, 10);
  }
}

void displayScore() {
  if (!isDuoMode){
    fill(255);
    textSize(32);
    textAlign(LEFT, TOP);
    text("Score: " + score1, 10, 10);
  } else {
    fill(255);
    textSize(32); 
    textAlign(LEFT, TOP);
    text("Score: " + score1, 10, 10);
    textSize(32);
    textAlign(RIGHT, TOP);
    text("Score: " + score2, width/2+200, 10);
  }
}

void spawnTile(int column) {
    tileHeight = height / 4.0;
    float spacing = 5; // Espace entre les tuiles
    
    if (!isDuoMode) {
        // Pour le joueur 1 en mode solo
        // Inclut l'espace dans le calcul de la position x
        float xPosition = column * (tileWidth + spacing);
        tiles1.add(new Tile(xPosition, -tileHeight, tileWidth, tileHeight, speed));
    } else {
        // Pour le joueur 1 en mode duo
        // Réduit la largeur de la tuile pour inclure l'espace et ajuste la position x en conséquence
        float xPosition1 = column * (tileWidth / 2 + spacing);
        tiles1.add(new Tile(xPosition1, -tileHeight, tileWidth / 2, tileHeight, speed));
        
        // Pour le joueur 2 en mode duo, positionnement à partir de la moitié de l'écran
        // Ajoute l'espace initial pour la moitié droite de l'écran et ajuste chaque position x suivante
        float xPosition2 = width / 2 + column * (tileWidth / 2 + spacing) + spacing;
        tiles2.add(new Tile(xPosition2, -tileHeight, tileWidth / 2, tileHeight, speed));
    }
}
  
void drawTiles() {
    for (Tile tile : tiles1) {
        image(pink_tile_1p, tile.x, tile.y, tile.width, tile.height);
    }
    if (isDuoMode) {
        for (Tile tile : tiles2) {
            image(blue_tile_1p, tile.x, tile.y, tile.width, tile.height);
        }
    }
}


void keyPressed() {
  if (gameState == TITLE) {
    if (keyCode == ENTER) {
      enterPressed = true;
    }
    if (keyCode == UP && currentSelection > 0) {
      currentSelection--;
    } else if (keyCode == DOWN && currentSelection < sequenceButtons.length - 1) {
      currentSelection++;
    }
  } else if (gameState == MODE) {
    if (keyCode == ENTER) {
      enterPressed_ = true;
    }
    if (keyCode == UP && currentSelection > 0) {
      currentSelection--;
    } else if (keyCode == DOWN && currentSelection < playerButtons.length - 1) {
      currentSelection++;
    }
  }
  // Gestion des touches pour le joueur 1
  handlePlayerInput(tiles1, 'd', 'f', 'j', 'k', 1);

  // Gestion des touches pour le joueur 2 en mode duo
  if (isDuoMode) {
    handlePlayerInput(tiles2, 'e', 'r', 'u', 'i', 2);
  }
}

void handlePlayerInput(ArrayList<Tile> tiles, char keyLeft, char keyDown, char keyUp, char keyRight, int playerNumber) {
  for (int i = tiles.size() - 1; i >= 0; i--) {
    Tile tile = tiles.get(i);
    int column = int((tile.x - (playerNumber == 2 ? width / 2 : 0)) / (tileWidth / (isDuoMode ? 2 : 1)));
    // Vérifie si une touche est pressée et si la tuile est à la hauteur de la ligne de jugement
    if ((key == keyLeft && column == 0) || (key == keyDown && column == 1) || (key == keyUp && column == 2) || (key == keyRight && column == 3)) {
      if (tile.y + tile.height > rodHeight && tile.y < rodHeight + tile.height) {
        float relativePosition = (tile.y + tile.height) - rodHeight;
        // Logique pour déterminer le score basé sur la précision
        // Mise à jour des scores et des combos
        updateScoreAndCombo(relativePosition, playerNumber);
        tiles.remove(i);
      } 
    }
  }
}

void updateScoreAndCombo(float relativePosition, int playerNumber) {
  int scoreColor;
  int addScore;
  String message;
  if (relativePosition <= tileHeight / 3) {
    message = "Parfait!";
    scoreColor = color(0, 255, 0); // Vert
    addScore = 200;
  } else if (relativePosition <= 2 * tileHeight / 3) {
    message = "Bon!";
    scoreColor = color(255, 165, 0); // Orange
    addScore = 100;
  } else {
    message = "Mauvais!";
    scoreColor = color(255, 0, 0); // Rouge
    addScore = 50;
  }

  // Met à jour le score et le combo en fonction du joueur
  if (playerNumber == 1) {
    combo1 += 1;
    score1 += addScore * combo1;
    if (health < maxHealth){
      health += 1;
    }
  } else {
    combo2 += 1;
    score2 += addScore * combo2;
  }

  // Met à jour l'affichage du score pour la colonne correspondante
  lastScoreMessage = message;
  scoreDisplays[playerNumber - 1].update(lastScoreMessage, scoreColor, 30); // Assurez-vous d'avoir un affichage par joueur
}


void moveTiles() {
  if (!isDuoMode){
    ArrayList<Tile> tilesToRemove = new ArrayList<Tile>();
    for (Tile tile : tiles1) {
      tile.y += tile.speed;
      if (tile.y >= height) {
        combo1 = 0;
        health -= 1;
        tilesToRemove.add(tile);
        if (health <= 0) {
            
            gameState = SCORE;
        }
      }
    }
    tiles1.removeAll(tilesToRemove);
    if (!tilesToRemove.isEmpty()) {
    }
  } else {
    ArrayList<Tile> tilesToRemove1 = new ArrayList<Tile>();
    for (Tile tile : tiles1) {
      tile.y += tile.speed;
      if (tile.y >= height) {
        combo1 = 0;
        tilesToRemove1.add(tile);
      }
    }
    tiles1.removeAll(tilesToRemove1);
    if (!tilesToRemove1.isEmpty()) {
    }
    ArrayList<Tile> tilesToRemove2 = new ArrayList<Tile>();
    for (Tile tile : tiles2) {
      tile.y += tile.speed;
      if (tile.y >= height) {
        combo2 = 0;
        tilesToRemove2.add(tile);
      }
    }
    tiles2.removeAll(tilesToRemove2);
    if (!tilesToRemove2.isEmpty()) {
    }
  }
}
