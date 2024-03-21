import processing.sound.SoundFile;
SoundFile music;
PImage[] pokemonPic = new PImage[4];
PImage playerPic;
PImage computerPic;
int num;
int number;
PImage backgroundpic;
PImage menu;
Pokemon player;
ComputerPokemon Boss;
String text_box = "";
int selected=0;
String rules = "(Please press a number that corresponds to each move.)";
boolean pturn = true;



void setup() {
  size(1050, 540);
  music = new SoundFile(this,"theme.mp3");
  music.amp(0.3);
  music.loop();
  menu = loadImage("menu.png"); 
  num = (int) (Math.random() * 3);
  number = (int) (Math.random() * 3);
  backgroundpic = loadImage("background.jpg");
  pokemonPic[0] = loadImage("p.png");
  pokemonPic[1] = loadImage("poka.png");
  pokemonPic[2] = loadImage("pked.png");
  playerPic = pokemonPic[number];
  computerPic = pokemonPic[num];
  textSize(24);
  player = new Pokemon("Player's Pokemon");
  Boss = new ComputerPokemon();
}
void draw() {
  delay(3000);
  background(backgroundpic);
  image(menu, -5, -10, width/2, height/2);
  drawPokemonPlayer(playerPic, width / 4, height / 2);
  drawPokemonComputer(computerPic, 3 * width / 4, height / 2);
  text(rules, 230, 520);
  if (pturn){
    showmenu();
  }

  if (player.health > 0 && Boss.health > 0) {
    if (pturn && selected != 0) {
      playerTurn();
      pturn = false;
    }
    else if (pturn && selected == 0){
      pturn = true;
    }
    else {
      computerTurn();
      pturn = true;
    }
  } 
  else {
    endGame();
  } 
  text(text_box, 85, 60);
}
void keyPressed() {
  if (key == '1' || key == '2' || key == '3' || key == '4') {
    selected = key - 48;   
  }
}

void drawPokemonPlayer(PImage playerPic, float x, float y) {
  String playername= "PLAYER 1";
  text(playername, x + 5, y + 50);
  image(playerPic, x, y + 60, 120, 120);
}


void drawPokemonComputer(PImage computerPic, float x, float y) {
  String cpu = "CPU's Pokémon";
  text(cpu, x - 140, y - 110);
  image(computerPic, x - 150, y - 90, 120, 120);
}
void showmenu(){
  delay(1000);
  text_box = "                 Player's turn!\n";
  text_box += "\n" + player.skills[1] + "(1)     (2)" + player.skills[2];
  text_box += "\n " + player.skills[3] + "(3)             (4)" + player.skills[4];
}
void playerTurn() {
  text_box = "                 Player's turn!\n";
  text_box += "\n" + player.skills[1] + "(1)     (2)" + player.skills[2];
  text_box += "\n " + player.skills[3] + "(3)             (4)" + player.skills[4];
    if (selected <= 4 && selected > 0) {
      text_box += "\n" + player.name + " uses " + player.skills[selected] + "!";
      player.ability(selected, Boss);
      text_box += "\nPlayer has: " + player.health + "HP left \nComputer has: " + Boss.health + "HP left";
    }
    else{
    }
  selected = 0;
}

void computerTurn() {
  text_box = Boss.name + "'s turn!";
  int rand = (int) (Math.random() * 4);
  text_box += "\n" + Boss.name + " uses " + Boss.skills[rand + 1] + "!";
  Boss.ability(rand + 1, player);
  text_box += "\nPlayer has: " + player.health + "HP left \nComputer has: " + Boss.health + "HP left";
}

void endGame() {
  if (Boss.health <= 0) {
    text_box = "The deadly " + Boss.name + " has been defeated! \nYou earn a 100 on your finals!";
  } 
  else if (player.health <= 0) {
    text_box = "Your " + player.name + " has been defeated! \nYou have failed your finals sadly:(";
  }
}
class Pokemon {
  public int health;
  public String[] skills = new String[5];
  public String name;

  public Pokemon(String assigned) {
    health = 300;
    name = assigned;
    skills[1] = "Mega Punch";
    skills[2] = "Triple Kick";
    skills[3] = "Fire Ball";
    skills[4] = "Lightning";
  }

  public void ability(int choice, Pokemon target) {
    switch (choice) {
      case 1:
        target.health = target.health - 15;
        break;
      case 2:
        target.health = (int) (target.health / 2);
        break;
      case 3:
        target.health = target.health - 50;
        health = health - 50;
        break;
      case 4:
        health = health + 40;
        break;
    }
  }
}

class ComputerPokemon extends Pokemon {
  public ComputerPokemon() {
    super("Computer Pokemon");
    skills[1] = "Terrorize";
    skills[2] = "Element Blast";
    skills[3] = "Leg Sweep";
    skills[4] = "Tackle";
  }

  public void ability(int choice, Pokemon target) {
    switch (choice) {
      case 1:
        target.health = target.health - 15;
        break;
      case 2:
        target.health = (int) (target.health / 2);
        break;
      case 3:
        target.health = target.health - 50;
        health = health - 50;
        break;
      case 4:
        health = health + 40;
        break;
    }
  }
}
