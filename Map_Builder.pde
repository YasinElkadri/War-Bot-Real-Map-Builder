import g4p_controls.*;

String mapName = "blank_map.png";
PImage blankImage;
PImage mapImage;
ArrayList<Territory> territories = new ArrayList<>();
ArrayList<Nation> nations = new ArrayList<>();
ArrayList<Formable> formables = new ArrayList<>();
boolean shouldRedraw;

ArrayList<Territory> backupList = new ArrayList<>();

Territory currTerr;
Nation currNat;
Formable currForm;

String lastButton = "None";

void setup() {
  size(1200, 1200);
  createGUI();
  shouldRedraw = false;
  create.setVisible(false);
  edit.setVisible(false);
  neighbour.setVisible(false);
  natCreate.setVisible(false);
  natEdit.setVisible(false);
  formCreate.setVisible(false);
  formEdit.setVisible(false);
  
  String jarPath = sketchPath("");  
  String imagePath = jarPath + File.separator + "blank_map.png";
  
  mapImage = loadImage(imagePath);
  blankImage = loadImage(imagePath);
  
  windowResize(mapImage.width, mapImage.height);
  image(mapImage, 0, 0);
  
  try {
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
  } catch (Exception e) {}
  
  try {
    String[] nats = loadStrings("Nations.txt");
    for (String string : nats) {
      String[] parts = string.split("\t");
      String name = parts[0];
      ArrayList<Territory> terrs = new ArrayList<>();
      for (Territory t : territories) {
        if (t.name.equals(name)) terrs.add(t);
      }
      Nation n = new Nation(name, terrs);
      nations.add(n);
    }
  } catch (Exception e) {}
  
  try {
    String[] forms = loadStrings("Formables.txt");
    for (String string : forms) {
      String[] parts = string.split("\t");
      String name = parts[0];
      ArrayList<Territory> terrs = new ArrayList<>();
      String territs = parts[3];
      territs = territs.replace("[", "");
      territs = territs.replace("]", "");
      territs = territs.replace("'", "");
      territs = territs.replace("'", "");
      
      for (String b : territs.split(",")) {
        Territory t = findTerritory(b);
        if (t != null) terrs.add(t);
      }
      Formable f = new Formable(name, terrs);
      formables.add(f);
    }
  } catch (Exception e) {}
}

void draw() {
  if (shouldRedraw) {
    background(255);
    mapImage.updatePixels();
    image(mapImage, 0, 0);
    shouldRedraw = false;  
  }
}
