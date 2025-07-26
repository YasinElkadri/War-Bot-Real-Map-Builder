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

  image.updatePixels();
}


void mousePressed() {
  int x = mouseX; 
  int y = mouseY;
  

  if (mouseButton == LEFT && create.isVisible()) {
    currTerr.coordinates.add(new PVector(x, y));

    redrawMap();

    String currentText = "";
    for (PVector pix : currTerr.coordinates) currentText += "\n" + int(pix.x) + ", " + int(pix.y);
    create_coordinateList.setText(currentText);
  }
  
  else if (mouseButton == RIGHT && create.isVisible()) {

    ArrayList<PVector> flood1 = getFloodPixels( new PVector(x, y));
    ArrayList<PVector> rmL = new ArrayList<PVector>();
    for (PVector pix : currTerr.coordinates) {
      if (containsPVector(flood1, pix)) rmL.add(pix);
    }

    for (PVector rm : rmL) currTerr.coordinates.remove(rm);
    
    redrawMap();

    String currentText = "";
    for (PVector pix : currTerr.coordinates) currentText += "\n" + int(pix.x) + ", " + int(pix.y);
    create_coordinateList.setText(currentText);
  }
  else if (mouseButton == LEFT && edit.isVisible()) {
    currTerr.coordinates.add(new PVector(x, y));
    redrawMap();

    String currentText = "";
    for (PVector pix : currTerr.coordinates) currentText += "\n" + int(pix.x) + ", " + int(pix.y);
    edit_coordinateList.setText(currentText);
  }
  
  else if (mouseButton == RIGHT && edit.isVisible()) {
    ArrayList<PVector> flood1 = getFloodPixels( new PVector(x, y));
    ArrayList<PVector> rmL = new ArrayList<PVector>();
    for (PVector pix : currTerr.coordinates) {
      if (containsPVector(flood1, pix)) rmL.add(pix);
    }
    for (PVector rm : rmL) currTerr.coordinates.remove(rm);
    
      redrawMap();

    String currentText = "";
    for (PVector pix : currTerr.coordinates) currentText += "\n" + int(pix.x) + ", " + int(pix.y);
    edit_coordinateList.setText(currentText);
  }

  else if (mouseButton == LEFT && neighbour.isVisible()) {
    mapImage = blankImage.copy();
    ArrayList<PVector> floodPixels = getFloodPixels(new PVector(x, y));
    Territory t = findTerritory(floodPixels);
    if (t == null) return;
    if (t.name.equals(currTerr.name)) return;
    for (Territory neighbouring : currTerr.neighbours) if (neighbouring.name.equals(t.name)) return;
    currTerr.neighbours.add(t);
    t.neighbours.add(currTerr);

    redrawMap();

    String currentText = "";
    for (Territory terr : currTerr.neighbours) currentText += "\n" + terr.name;
    neighbourList.setText(currentText);
  }
  
  
  
  else if (mouseButton == CENTER && neighbour.isVisible()) {
    mapImage = blankImage.copy();
    ArrayList<PVector> floodPixels = getFloodPixels(new PVector(x, y));
    Territory t = findTerritory(floodPixels);
    if (t == null) return;
    if (t.name.equals(currTerr.name)) return;
    currTerr = t;

   redrawMap();

    String currentText = "";
    for (Territory terr : currTerr.neighbours) currentText += "\n" + terr.name;
    neighbourList.setText(currentText);
   neighbour1.setSelected(territories.indexOf(currTerr));
  }
  
  
    else if (mouseButton == RIGHT && neighbour.isVisible()) {
      
      mapImage = blankImage.copy();
      ArrayList<PVector> floodPixels = getFloodPixels(new PVector(x, y));
      Territory t = findTerritory(floodPixels);

      if (t == null) return;
      if (t.name.equals(currTerr.name)) return;
      boolean found = false;
      for (Territory neighbouring : currTerr.neighbours) {
          if (neighbouring.name.equals(t.name)) {
              print(neighbouring.name, t.name);
              found = true;
              break;
          }
      }
      if (!found) {
          return;
      }      
      currTerr.neighbours.remove(t);
      t.neighbours.remove(currTerr);
      
       redrawMap();

    String currentText = "";
    for (Territory terr : currTerr.neighbours) currentText += "\n" + terr.name;
    neighbourList.setText(currentText);
  }
  
  
  
  
  else if (mouseButton == CENTER && edit.isVisible()) {
    mapImage = blankImage.copy();
    ArrayList<PVector> floodPixels = getFloodPixels(new PVector(x, y));
    Territory t = findTerritory(floodPixels);
    if (t == null) return;
    if (t.name.equals(currTerr.name)) return;
    currTerr = t;
    
    redrawMap();

    
    String currentText = "";
    for (PVector pix : currTerr.coordinates) currentText += "\n" + int(pix.x) + ", " + int(pix.y);
    edit_coordinateList.setText(currentText);
    edit1.setText(currTerr.name);
    edit3.setText(currTerr.nation);
    edit5.setText(str(currTerr.population));
    edit7.setSelected(currTerr.terrain - 1);
    edit9.setText(str(currTerr.coal));
    edit11.setText(str(currTerr.oil));
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
