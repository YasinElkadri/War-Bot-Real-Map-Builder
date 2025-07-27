public Territory findTerritory(String name) {

  for (Territory t : territories) {
 
    if (t.name.equals(name)) { return t; }
  }

  println("HUGE ERROR! COULD NOT FIND", name);
  return null;

}

public void redrawMap() {
  mapImage = blankImage.copy();
  for (PVector pix : currTerr.coordinates) {
    ArrayList<PVector> flood = getFloodPixels(pix);
    fill(mapImage, flood, color(255, 0, 0));
  }
  for (Territory terr : currTerr.neighbours) {
    for (PVector pix : terr.coordinates) {
      ArrayList<PVector> flood = getFloodPixels(pix);
      fill(mapImage, flood, color(0, 0, 255));
    }
  }
  shouldRedraw = true;
}

public void redrawNationMap() {
  mapImage = blankImage.copy();
  for (Territory terr : currNat.territories) {
    for (PVector pix : terr.coordinates) {
      ArrayList<PVector> flood = getFloodPixels(pix);
      fill(mapImage, flood, color(255, 0, 0));
    }
  }
  shouldRedraw = true;
}

public void redrawFormableMap() {
  mapImage = blankImage.copy();
  for (Territory terr : currForm.territories) {
    for (PVector pix : terr.coordinates) {
      ArrayList<PVector> flood = getFloodPixels(pix);
      fill(mapImage, flood, color(255, 0, 0));
    }
  }
  shouldRedraw = true;
}

// not my code
public ArrayList<PVector> getFloodPixels(PVector startPixel) { 
  ArrayList<PVector> flood = new ArrayList<>();
  ArrayList<PVector> toCheck = new ArrayList<>();

  PImage image = blankImage.copy();
  
  int width = image.width;
  int height = image.height;
  int startX = int(startPixel.x);
  int startY = int(startPixel.y);

  if (startX < 0 || startX >= width || startY < 0 || startY >= height) return flood;

  image.loadPixels();

  int startIndex = startY * width + startX;
  int startColour = image.pixels[startIndex];
  int startR = (startColour >> 16) & 255;
  int startG = (startColour >> 8) & 255;
  int startB = startColour & 255;

  boolean[][] visited = new boolean[width][height];
  toCheck.add(new PVector(startX, startY));
  visited[startX][startY] = true;

  while (!toCheck.isEmpty()) {
    PVector current = toCheck.remove(toCheck.size() - 1); 
    int x = int(current.x);
    int y = int(current.y);

    int currentColor = image.pixels[y * width + x];
    int r = (currentColor >> 16) & 255;
    int g = (currentColor >> 8) & 255;
    int b = currentColor & 255;

    if (abs(r - startR) < 150 && abs(g - startG) < 150 && abs(b - startB) < 150) {
      flood.add(current);

      int[][] offsets = { {1,0}, {-1,0}, {0,1}, {0,-1} };
      for (int[] offset : offsets) {
        int nx = x + offset[0];
        int ny = y + offset[1];

        if (nx >= 0 && nx < width && ny >= 0 && ny < height && !visited[nx][ny]) {
          toCheck.add(new PVector(nx, ny));
          visited[nx][ny] = true;
        }
      }
    }
  }

  return flood;
}


public void fill(PImage image, ArrayList<PVector> pix, color colour) {
  image.loadPixels();

  int w = image.width;
  int h = image.height;

  for (PVector p : pix) {
    int x = int(p.x);
    int y = int(p.y);
    
    if (x >= 0 && x < w && y >= 0 && y < h) {
      image.pixels[y * w + x] = colour;
    }
  }
}


boolean containsPVector(ArrayList<PVector> list, PVector target) {
  for (PVector p : list) {
    if (p.x == target.x && p.y == target.y) {
      return true;
    }
  }
  return false;
}

Territory findTerritory(ArrayList<PVector> flooded) {
  for (Territory t : territories) {
    for (PVector coord : t.coordinates) {
      if (containsPVector(flooded, coord)) {
        return t; 
      }
    }
  }
  return null;
}

void saveToText() {
  ArrayList<String> stringsToSave = new ArrayList<String>();
  for (Territory territory : territories) {
    String s = "";
    s += territory.name + "\t" + territory.nation + "\t" + territory.population + "\t[";
    for (Territory neighbouring : territory.neighbours) s += "'" + neighbouring.name + "',";
    if (territory.neighbours.size() > 0) s = s.substring(0, s.length() - 1);
    s += "]\t[]\t[";
    for (PVector pix : territory.coordinates) s += "(" + int(pix.x) + "," + int(pix.y) + "),";
    if (territory.coordinates.size() > 0) s = s.substring(0, s.length() - 1);
    int area = 0;
    for (PVector pix : territory.coordinates) area += getFloodPixels(pix).size();
    s += "]\t[ADD_SEAS_HERE]\t0\tPIXELS:" + area + "\t" + territory.terrain + "\t[]\t" + territory.coal + "\t" + territory.oil;
    stringsToSave.add(s);
  }
  
  String[] stringsToSaveArray = new String[stringsToSave.size()];
  stringsToSaveArray = stringsToSave.toArray(stringsToSaveArray);
  saveStrings("Territories.txt", stringsToSaveArray);
  
  
  ArrayList<String> stringsToSaveNat = new ArrayList<>();
  
  for (Nation n : nations) {
    String s = n.name + "\tNone\t10000\t60\t{}\tNon-Aligned\t0\tFLAG_EMOJI\t20\t200\tDENONYM\tCOLOR\tCAPITAL";
    stringsToSaveNat.add(s);
  }
  
  String[] stringsToSaveArrayNat = new String[stringsToSaveNat.size()];
  stringsToSaveArrayNat = stringsToSaveNat.toArray(stringsToSaveArrayNat);
  saveStrings("Nations.txt", stringsToSaveArrayNat);
  

  
  
  ArrayList<String> stringsToSaveForm = new ArrayList<>();

  for (Formable f : formables) {
    String s = f.name + "\t\t\t[";
    for (Territory t : f.territories) s += "\'" + t.name + "\',";
    if (f.territories.size() > 0) s = s.substring(0, s.length() - 1);
    s += "]";
    stringsToSaveForm.add(s);
  }

  String[] stringsToSaveArrayForm = new String[stringsToSaveForm.size()];
  stringsToSaveArrayForm = stringsToSaveForm.toArray(stringsToSaveArrayForm);
  saveStrings("Formables.txt", stringsToSaveArrayForm);
  
}

void mousePressed() {
  if (create.isVisible()) createTerrMapPressed();
  else if (edit.isVisible()) editTerrMapPressed();
  else if (neighbour.isVisible()) neighbourTerrMapPressed();
  else if (natCreate.isVisible()) createNatMapPressed();
  else if (natEdit.isVisible()) editNatMapPressed();
  else if (formCreate.isVisible()) createFormMapPressed();
  else if (formEdit.isVisible()) editFormMapPressed();
}
