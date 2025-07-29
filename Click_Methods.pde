void createTerrMapPressed() {
  int x = mouseX;
  int y = mouseY;
  
  if (mouseButton == LEFT) {
    currTerr.coordinates.add(new PVector(x, y));

    redrawMap();

    String currentText = "";
    for (PVector pix : currTerr.coordinates) currentText += "\n" + int(pix.x) + ", " + int(pix.y);
    create_coordinateList.setText(currentText);
  }
  
  else if (mouseButton == RIGHT) {

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
}


void editTerrMapPressed() {
  int x = mouseX;
  int y = mouseY;
  
   if (mouseButton == LEFT) {
    currTerr.coordinates.add(new PVector(x, y));
    redrawMap();

    String currentText = "";
    for (PVector pix : currTerr.coordinates) currentText += "\n" + int(pix.x) + ", " + int(pix.y);
    edit_coordinateList.setText(currentText);
  }
  
  else if (mouseButton == RIGHT) {
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
  
  else if (mouseButton == CENTER) {
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


void neighbourTerrMapPressed() {

  int x = mouseX;
  int y = mouseY;
  
  if (mouseButton == LEFT) {
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
  
  
  
  else if (mouseButton == CENTER) {
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
  
  
    else if (mouseButton == RIGHT) {
      
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

}


void createNatMapPressed() {
  
  int x = mouseX;
  int y = mouseY;
  
  if (mouseButton == LEFT) {
    mapImage = blankImage.copy();
    ArrayList<PVector> floodPixels = getFloodPixels(new PVector(x, y));
    Territory t = findTerritory(floodPixels);
    if (t == null) return;
    for (Territory terr : currNat.territories) if (terr.name.equals(t.name)) return;
    for (Nation n : nations) if (n.territories.contains(t)) n.territories.remove(t);
    currNat.territories.add(t);
    t.nation = currNat.name;

    redrawNationMap();
  } else if (mouseButton == RIGHT) {
    mapImage = blankImage.copy();
    ArrayList<PVector> floodPixels = getFloodPixels(new PVector(x, y));
    Territory t = findTerritory(floodPixels);

    if (t == null) return;
    boolean found = false;
    for (Territory terr : currNat.territories) {
        if (terr.name.equals(t.name)) {
            found = true;
            break;
        }
    }
    if (!found) {
        return;
    }      
    currNat.territories.remove(t);
    t.nation = "";
    
    redrawNationMap();
  }
}


void editNatMapPressed() {
  
  int x = mouseX;
  int y = mouseY;
  
  if (mouseButton == LEFT) {
    mapImage = blankImage.copy();
    ArrayList<PVector> floodPixels = getFloodPixels(new PVector(x, y));
    Territory t = findTerritory(floodPixels);
    if (t == null) return;
    for (Territory terr : currNat.territories) if (terr.name.equals(t.name)) return;
    for (Nation n : nations) if (n.territories.contains(t)) n.territories.remove(t);
    currNat.territories.add(t);
    t.nation = currNat.name;

    redrawNationMap();
  } else if (mouseButton == RIGHT) {
    mapImage = blankImage.copy();
    ArrayList<PVector> floodPixels = getFloodPixels(new PVector(x, y));
    Territory t = findTerritory(floodPixels);

    if (t == null) return;
    boolean found = false;
    for (Territory terr : currNat.territories) {
        if (terr.name.equals(t.name)) {
            found = true;
            break;
        }
    }
    if (!found) {
        return;
    }      
    currNat.territories.remove(t);
    t.nation = "";
    
    redrawNationMap();
  }
}
void createFormMapPressed() {
   
  int x = mouseX;
  int y = mouseY;
  
  if (mouseButton == LEFT) {
    mapImage = blankImage.copy();
    ArrayList<PVector> floodPixels = getFloodPixels(new PVector(x, y));
    Territory t = findTerritory(floodPixels);
    if (t == null) return;
    for (Territory terr : currForm.territories) if (terr.name.equals(t.name)) return;
    currForm.territories.add(t);

    redrawFormableMap();
    
  } else if (mouseButton == RIGHT) {
    mapImage = blankImage.copy();
    ArrayList<PVector> floodPixels = getFloodPixels(new PVector(x, y));
    Territory t = findTerritory(floodPixels);

    if (t == null) return;
    boolean found = false;
    for (Territory terr : currForm.territories) {
        if (terr.name.equals(t.name)) {
            found = true;
            break;
        }
    }
    if (!found) {
        return;
    }      
    currForm.territories.remove(t);
    
    redrawFormableMap();
  }
}
void editFormMapPressed() {   
  int x = mouseX;
  int y = mouseY;
  
  if (mouseButton == LEFT) {
    mapImage = blankImage.copy();
    ArrayList<PVector> floodPixels = getFloodPixels(new PVector(x, y));
    Territory t = findTerritory(floodPixels);
    if (t == null) return;
    for (Territory terr : currForm.territories) if (terr.name.equals(t.name)) return;
    currForm.territories.add(t);

    redrawFormableMap();
    
  } else if (mouseButton == RIGHT) {
    mapImage = blankImage.copy();
    ArrayList<PVector> floodPixels = getFloodPixels(new PVector(x, y));
    Territory t = findTerritory(floodPixels);

    if (t == null) return;
    boolean found = false;
    for (Territory terr : currForm.territories) {
        if (terr.name.equals(t.name)) {
            found = true;
            break;
        }
    }
    if (!found) {
        return;
    }      
    currForm.territories.remove(t);
    
    redrawFormableMap();
  }}
