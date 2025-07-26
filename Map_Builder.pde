import g4p_controls.*;

String mapName = "blank_map.png";
int mapWidth = 500; //change to automatically find
int mapHeight = 500; //change to automatically find
PImage blankImage;
PImage mapImage;
ArrayList<Territory> territories = new ArrayList<>();
boolean shouldRedraw;

ArrayList<Territory> territoryBackup = new ArrayList<>();

Territory currTerr;

String lastButton = "None";

void setup() {
  size(1200, 1200);
  createGUI();
  shouldRedraw = false;
  create.setVisible(false);
  edit.setVisible(false);
  neighbour.setVisible(false);
  
  String jarPath = sketchPath("");  
  String imagePath = jarPath + File.separator + "blank_map.png";
  
  mapImage = loadImage(imagePath);
  blankImage = loadImage(imagePath);
  
  windowResize(mapImage.width, mapImage.height);
  image(mapImage, 0, 0);
  String[] strings = loadStrings("Territories.txt");
  for (String string : strings) {
    String[] parts = string.split("\t");
    ArrayList<Territory> neighbours = new ArrayList<>();
    ArrayList<PVector> coordinates = new ArrayList<>();
    parts[5] = parts[5].replace(" ", "");
    parts[5] = parts[5].replace("(", "");
    parts[5] = parts[5].replace("[", "");
    parts[5] = parts[5].replace("]", "");
    parts[5] = parts[5].replace(")", "");
    String[] coords = parts[5].split(",");
    for (int i = 0; i < int(coords.length/2); i++) coordinates.add(new PVector(int(coords[2*i]), int(coords[2*i + 1])));
    Territory t = new Territory(parts[0], parts[1], int(parts[2]), int(parts[9]), coordinates, neighbours, int(parts[11]), int(parts[12]));
    territories.add(t);
  }
  
  //println(territories);

  for (int i = 0; i < strings.length; i++) {
        String[] parts = strings[i].split("\t");
        String neighbours = parts[3];
        neighbours = neighbours.replace("[", "");
        neighbours = neighbours.replace("]", "");
        neighbours = neighbours.replace("'", "");
        neighbours = neighbours.replace("'", "");
        for (String s : neighbours.split(",")) { 
          if (s.equals("")) continue;
          territories.get(i).neighbours.add(findTerritory(s));
        }
  }

}

void draw() {
  if (shouldRedraw) {
    background(255);
    image(mapImage, 0, 0);
    shouldRedraw = false;  
  }
}
