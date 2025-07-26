/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */

synchronized public void win_draw1(PApplet appc, GWinData data) { //_CODE_:menu:359365:
  appc.background(230);
} //_CODE_:menu:359365:

public void menu_createTerritory(GButton source, GEvent event) { //_CODE_:menu1:494671:
  lastButton = "None";
  currTerr = new Territory();
  menu.setVisible(false);
  create.setVisible(true);
  create1.setText("");
  create3.setText("");
  create5.setText("");
  create16.setText("");
  create17.setText("");
  create_coordinateList.setText("none");
} //_CODE_:menu1:494671:

public void menu_editTerritory(GButton source, GEvent event) { //_CODE_:menu2:795523:
  if (territories.size() == 0) return;
  lastButton = "None";
  
  
  
   territoryBackup.clear();
  
  ArrayList<ArrayList<Integer>> backupNeighbourValues = new ArrayList<>();
  
  for (Territory territory : territories) {
    territoryBackup.add(territory.copyWithoutNeighbours());
    ArrayList<Integer> backupValuesThisTerritory = new ArrayList<>(); 
    for (Territory s : territory.neighbours) {
      for (int i = 0; i < territories.size(); i++) { if (s.name == territories.get(i).name) { backupValuesThisTerritory.add(i); break; } }
    }
    backupNeighbourValues.add(backupValuesThisTerritory);
  }
  
  for (int i = 0; i < territoryBackup.size(); i++) {
  
    for (int z : backupNeighbourValues.get(i)) territoryBackup.get(i).neighbours.add(territoryBackup.get(z));
    
  }
  
  
  currTerr = territories.get(0);
  menu.setVisible(false);
  edit.setVisible(true);
  edit1.setText(currTerr.name);
  edit3.setText(currTerr.nation);
  edit5.setText(str(currTerr.population));
  edit7.setSelected(currTerr.terrain - 1);
  edit9.setText(str(currTerr.coal));
  edit11.setText(str(currTerr.oil));
  


   redrawMap();

 
  if (currTerr.coordinates.size() == 0) edit_coordinateList.setText("none");
  else {
    String currentText = "";
    for (PVector pix : currTerr.coordinates) currentText += "\n" + int(pix.x) + ", " + int(pix.y);
    edit_coordinateList.setText(currentText);
  }
} //_CODE_:menu2:795523:

public void menu_registerNeighbours(GButton source, GEvent event) { //_CODE_:menu3:309826:
  if (territories.size() == 0) return;  
  lastButton = "None";
  
  //im gonna kill everybody 
  //I HATE PROGRAMMING AAAAAAAAAAAAAAAA
  
   territoryBackup.clear();
  
  ArrayList<ArrayList<Integer>> backupNeighbourValues = new ArrayList<>();
  
  for (Territory territory : territories) {
    territoryBackup.add(territory.copyWithoutNeighbours());
    ArrayList<Integer> backupValuesThisTerritory = new ArrayList<>(); 
    for (Territory s : territory.neighbours) {
      for (int i = 0; i < territories.size(); i++) { if (s.name == territories.get(i).name) { backupValuesThisTerritory.add(i); break; } }
    }
    backupNeighbourValues.add(backupValuesThisTerritory);
  }
  
  for (int i = 0; i < territoryBackup.size(); i++) {
  
    for (int z : backupNeighbourValues.get(i)) territoryBackup.get(i).neighbours.add(territoryBackup.get(z));
    
  }
  
  
  menu.setVisible(false);
  neighbour.setVisible(true);
  ArrayList<String> territoryNames = new ArrayList<>();
  for (Territory t : territories) territoryNames.add(t.name);
  String[] territoryList = new String[territoryNames.size()];
  territoryList = territoryNames.toArray(territoryList);
  neighbour1.setItems(territoryList, 0);
  currTerr = territories.get(0).copy();
  redrawMap();
  String currentText = "";
  for (Territory t : currTerr.neighbours) currentText += "\n" + t.name;
  neighbourList.setText(currentText);  
} //_CODE_:menu3:309826:

public void menu_paintAll(GButton source, GEvent event) { //_CODE_:menu4:617171:
  for (int i = 0; i < territories.size(); i++) {
    
    color c = lerpColor(color(255, 0, 0), color(0, 0, 255), float(i) / territories.size());
    for (PVector pix : territories.get(i).coordinates) {

      ArrayList<PVector> floodPixels = getFloodPixels(pix);
      fill(mapImage, floodPixels, c);
    
    }
    shouldRedraw = true;
  }
} //_CODE_:menu4:617171:

synchronized public void win_draw2(PApplet appc, GWinData data) { //_CODE_:create:390304:
  appc.background(230);
} //_CODE_:create:390304:

public void create_nameChanged(GTextField source, GEvent event) { //_CODE_:create1:218102:
  currTerr.name = source.getText();
  lastButton = "None";
} //_CODE_:create1:218102:

public void create_nationChanged(GTextField source, GEvent event) { //_CODE_:create3:506491:
  currTerr.nation = source.getText();
  lastButton = "None";
} //_CODE_:create3:506491:

public void create_populationChanged(GTextField source, GEvent event) { //_CODE_:create5:496908:
  try {
    currTerr.population = int(source.getText());
  } catch (Exception e) {}
  lastButton = "None";
} //_CODE_:create5:496908:

public void create_terrainChanged(GDropList source, GEvent event) { //_CODE_:create7:401323:
  currTerr.terrain = source.getSelectedIndex() + 1;
  lastButton = "None";
} //_CODE_:create7:401323:

public void create_save(GButton source, GEvent event) { //_CODE_:create12:494261:
  lastButton = "None";
  ArrayList<String> stringsToSave = new ArrayList<String>();
  territories.add(currTerr);
  currTerr = null;
  menu.setVisible(true);
  create.setVisible(false);
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
  mapImage = blankImage.copy();
  shouldRedraw = true;
} //_CODE_:create12:494261:

public void create_cancel(GButton source, GEvent event) { //_CODE_:create13:201712:

  lastButton = "None";
  currTerr = null;
  menu.setVisible(true);
  create.setVisible(false);
  mapImage = blankImage.copy();
  shouldRedraw = true;
} //_CODE_:create13:201712:

public void create_coalChanged(GTextField source, GEvent event) { //_CODE_:create16:507908:
  try {
    currTerr.coal = float(source.getText());
  } catch (Exception e) {}
  lastButton = "None";
} //_CODE_:create16:507908:

public void create_oilChanged(GTextField source, GEvent event) { //_CODE_:create17:796097:
  try {
    currTerr.oil = float(source.getText());
  } catch (Exception e) {}
  lastButton = "None";
} //_CODE_:create17:796097:

synchronized public void win_draw3(PApplet appc, GWinData data) { //_CODE_:neighbour:690250:
  appc.background(230);
} //_CODE_:neighbour:690250:

public void neighbour_territorySelected(GDropList source, GEvent event) { //_CODE_:neighbour1:754508:
  lastButton = "None";
  currTerr = findTerritory(source.getSelectedText()).copy();


  redrawMap();


  neighbourList.setText("");
  if (currTerr.neighbours.size() == 0) return;
  for (Territory terr : currTerr.neighbours) neighbourList.setText(neighbourList.getText() + "\n" + terr.name);  
} //_CODE_:neighbour1:754508:

public void neighbour_save(GButton source, GEvent event) { //_CODE_:neighbour6:961379:
  lastButton = "None";
  ArrayList<String> stringsToSave = new ArrayList<String>();
  currTerr = null;
  menu.setVisible(true);
  neighbour.setVisible(false);
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
  mapImage = blankImage.copy();
  shouldRedraw = true;
} //_CODE_:neighbour6:961379:

public void neighbour_cancel(GButton source, GEvent event) { //_CODE_:neighbour7:845164:
  lastButton = "None";
  territories.clear();
  territories = (ArrayList)territoryBackup.clone();
  currTerr = null;
  menu.setVisible(true);
  neighbour.setVisible(false);
  mapImage = blankImage.copy();
  shouldRedraw = true;
} //_CODE_:neighbour7:845164:

synchronized public void win_draw4(PApplet appc, GWinData data) { //_CODE_:edit:227452:
  appc.background(230);
} //_CODE_:edit:227452:

public void edit_nameChanged(GTextField source, GEvent event) { //_CODE_:edit1:414268:
    currTerr.name = (source.getText());
} //_CODE_:edit1:414268:

public void edit_nationChanged(GTextField source, GEvent event) { //_CODE_:edit3:685505:
    currTerr.nation = (source.getText());
} //_CODE_:edit3:685505:

public void edit_populationChanged(GTextField source, GEvent event) { //_CODE_:edit5:459017:
  try {
    currTerr.population = int(source.getText());
  } catch (Exception e) {}
  lastButton = "None";
} //_CODE_:edit5:459017:

public void edit_coalChanged(GTextField source, GEvent event) { //_CODE_:edit9:403175:
  try {
    currTerr.coal = float(source.getText());
  } catch (Exception e) {}
  lastButton = "None";
} //_CODE_:edit9:403175:

public void edit_oilChanged(GTextField source, GEvent event) { //_CODE_:edit11:229419:
  try {
    currTerr.oil = float(source.getText());
  } catch (Exception e) {}
  lastButton = "None";
} //_CODE_:edit11:229419:

public void edit_terrainChanged(GDropList source, GEvent event) { //_CODE_:edit7:416596:
  currTerr.terrain = source.getSelectedIndex() + 1;
} //_CODE_:edit7:416596:

public void edit_save(GButton source, GEvent event) { //_CODE_:edit14:539957:
  ArrayList<String> stringsToSave = new ArrayList<String>();
  currTerr = null;
  menu.setVisible(true);
  edit.setVisible(false);
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
  mapImage = blankImage.copy();
  shouldRedraw = true;
} //_CODE_:edit14:539957:

public void edit_cancel(GButton source, GEvent event) { //_CODE_:edit15:378981:
  lastButton = "None";
  territories.clear();
  territories = (ArrayList)territoryBackup.clone();
  currTerr = null;
  menu.setVisible(true);
  edit.setVisible(false);
  mapImage = blankImage.copy();
  shouldRedraw = true;
} //_CODE_:edit15:378981:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Sketch Window");
  menu = GWindow.getWindow(this, "Main Menu", 0, 0, 240, 360, JAVA2D);
  menu.noLoop();
  menu.setActionOnClose(G4P.EXIT_APP);
  menu.addDrawHandler(this, "win_draw1");
  menu0 = new GLabel(menu, 80, 10, 80, 30);
  menu0.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  menu0.setText("MAIN MENU");
  menu0.setOpaque(false);
  menu1 = new GButton(menu, 80, 80, 80, 30);
  menu1.setText("Create Territory");
  menu1.addEventHandler(this, "menu_createTerritory");
  menu2 = new GButton(menu, 80, 150, 80, 30);
  menu2.setText("Edit Territory");
  menu2.addEventHandler(this, "menu_editTerritory");
  menu3 = new GButton(menu, 80, 220, 80, 30);
  menu3.setText("Register Neighbours");
  menu3.addEventHandler(this, "menu_registerNeighbours");
  menu4 = new GButton(menu, 80, 290, 80, 30);
  menu4.setText("Paint All");
  menu4.addEventHandler(this, "menu_paintAll");
  create = GWindow.getWindow(this, "Create Territory", 0, 0, 240, 600, JAVA2D);
  create.noLoop();
  create.setActionOnClose(G4P.EXIT_APP);
  create.addDrawHandler(this, "win_draw2");
  create0 = new GLabel(create, 20, 20, 80, 20);
  create0.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  create0.setText("Name:");
  create0.setOpaque(false);
  create1 = new GTextField(create, 110, 20, 120, 15, G4P.SCROLLBARS_NONE);
  create1.setOpaque(true);
  create1.addEventHandler(this, "create_nameChanged");
  create2 = new GLabel(create, 20, 50, 80, 20);
  create2.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  create2.setText("Nation:");
  create2.setOpaque(false);
  create3 = new GTextField(create, 110, 50, 120, 15, G4P.SCROLLBARS_NONE);
  create3.setOpaque(true);
  create3.addEventHandler(this, "create_nationChanged");
  create4 = new GLabel(create, 20, 80, 80, 20);
  create4.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  create4.setText("Population:");
  create4.setOpaque(false);
  create5 = new GTextField(create, 110, 80, 120, 15, G4P.SCROLLBARS_NONE);
  create5.setOpaque(true);
  create5.addEventHandler(this, "create_populationChanged");
  create6 = new GLabel(create, 20, 110, 80, 20);
  create6.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  create6.setText("Terrain:");
  create6.setOpaque(false);
  create7 = new GDropList(create, 110, 110, 120, 140, 6, 10);
  create7.setItems(loadStrings("list_401323"), 0);
  create7.addEventHandler(this, "create_terrainChanged");
  create_coordinateList = new GLabel(create, 80, 230, 80, 240);
  create_coordinateList.setTextAlign(GAlign.LEFT, GAlign.TOP);
  create_coordinateList.setText("none");
  create_coordinateList.setOpaque(false);
  create10 = new GLabel(create, 80, 200, 80, 20);
  create10.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  create10.setText("Coordinates:");
  create10.setOpaque(false);
  create12 = new GButton(create, 80, 490, 80, 30);
  create12.setText("Save");
  create12.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  create12.addEventHandler(this, "create_save");
  create13 = new GButton(create, 80, 540, 80, 30);
  create13.setText("Cancel");
  create13.setLocalColorScheme(GCScheme.RED_SCHEME);
  create13.addEventHandler(this, "create_cancel");
  create15 = new GLabel(create, 20, 140, 80, 20);
  create15.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  create15.setText("Coal:");
  create15.setOpaque(false);
  create14 = new GLabel(create, 20, 170, 80, 20);
  create14.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  create14.setText("Oil:");
  create14.setOpaque(false);
  create16 = new GTextField(create, 110, 140, 120, 15, G4P.SCROLLBARS_NONE);
  create16.setOpaque(true);
  create16.addEventHandler(this, "create_coalChanged");
  create17 = new GTextField(create, 110, 170, 120, 15, G4P.SCROLLBARS_NONE);
  create17.setOpaque(true);
  create17.addEventHandler(this, "create_oilChanged");
  neighbour = GWindow.getWindow(this, "Select Neighbours", 0, 0, 240, 600, JAVA2D);
  neighbour.noLoop();
  neighbour.setActionOnClose(G4P.EXIT_APP);
  neighbour.addDrawHandler(this, "win_draw3");
  neighbour1 = new GDropList(neighbour, 120, 10, 90, 220, 10, 10);
  neighbour1.setItems(loadStrings("list_754508"), 0);
  neighbour1.addEventHandler(this, "neighbour_territorySelected");
  neighbour0 = new GLabel(neighbour, 20, 10, 80, 20);
  neighbour0.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  neighbour0.setText("Territory:");
  neighbour0.setOpaque(false);
  neighbour2 = new GLabel(neighbour, 70, 40, 80, 20);
  neighbour2.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  neighbour2.setText("Neighbours:");
  neighbour2.setOpaque(false);
  neighbourList = new GLabel(neighbour, 20, 70, 200, 400);
  neighbourList.setTextAlign(GAlign.LEFT, GAlign.TOP);
  neighbourList.setText("none");
  neighbourList.setOpaque(false);
  neighbour6 = new GButton(neighbour, 70, 500, 80, 30);
  neighbour6.setText("Save");
  neighbour6.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  neighbour6.addEventHandler(this, "neighbour_save");
  neighbour7 = new GButton(neighbour, 70, 550, 80, 30);
  neighbour7.setText("Cancel");
  neighbour7.setLocalColorScheme(GCScheme.RED_SCHEME);
  neighbour7.addEventHandler(this, "neighbour_cancel");
  edit = GWindow.getWindow(this, "Edit", 0, 0, 240, 600, JAVA2D);
  edit.noLoop();
  edit.setActionOnClose(G4P.EXIT_APP);
  edit.addDrawHandler(this, "win_draw4");
  edit0 = new GLabel(edit, 20, 20, 80, 20);
  edit0.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  edit0.setText("Name: ");
  edit0.setOpaque(false);
  edit1 = new GTextField(edit, 110, 20, 120, 15, G4P.SCROLLBARS_NONE);
  edit1.setOpaque(true);
  edit1.addEventHandler(this, "edit_nameChanged");
  edit2 = new GLabel(edit, 20, 50, 80, 20);
  edit2.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  edit2.setText("Nation:");
  edit2.setOpaque(false);
  edit3 = new GTextField(edit, 110, 50, 120, 15, G4P.SCROLLBARS_NONE);
  edit3.setOpaque(true);
  edit3.addEventHandler(this, "edit_nationChanged");
  edit4 = new GLabel(edit, 20, 80, 80, 20);
  edit4.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  edit4.setText("Population: ");
  edit4.setOpaque(false);
  edit6 = new GLabel(edit, 20, 110, 80, 20);
  edit6.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  edit6.setText("Terrain: ");
  edit6.setOpaque(false);
  edit8 = new GLabel(edit, 20, 140, 80, 20);
  edit8.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  edit8.setText("Coal:");
  edit8.setOpaque(false);
  edit10 = new GLabel(edit, 20, 170, 80, 20);
  edit10.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  edit10.setText("Oil:");
  edit10.setOpaque(false);
  edit5 = new GTextField(edit, 110, 80, 120, 15, G4P.SCROLLBARS_NONE);
  edit5.setOpaque(true);
  edit5.addEventHandler(this, "edit_populationChanged");
  edit9 = new GTextField(edit, 110, 140, 120, 15, G4P.SCROLLBARS_NONE);
  edit9.setOpaque(true);
  edit9.addEventHandler(this, "edit_coalChanged");
  edit11 = new GTextField(edit, 110, 170, 120, 15, G4P.SCROLLBARS_NONE);
  edit11.setOpaque(true);
  edit11.addEventHandler(this, "edit_oilChanged");
  edit7 = new GDropList(edit, 110, 110, 120, 140, 6, 10);
  edit7.setItems(loadStrings("list_416596"), 0);
  edit7.addEventHandler(this, "edit_terrainChanged");
  edit12 = new GLabel(edit, 80, 200, 80, 20);
  edit12.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  edit12.setText("Coordinates:");
  edit12.setOpaque(false);
  edit_coordinateList = new GLabel(edit, 80, 230, 80, 240);
  edit_coordinateList.setTextAlign(GAlign.LEFT, GAlign.TOP);
  edit_coordinateList.setText("none");
  edit_coordinateList.setOpaque(false);
  edit14 = new GButton(edit, 80, 490, 80, 30);
  edit14.setText("Save");
  edit14.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  edit14.addEventHandler(this, "edit_save");
  edit15 = new GButton(edit, 80, 540, 80, 30);
  edit15.setText("Cancel");
  edit15.setLocalColorScheme(GCScheme.RED_SCHEME);
  edit15.addEventHandler(this, "edit_cancel");
  menu.loop();
  create.loop();
  neighbour.loop();
  edit.loop();
}

// Variable declarations 
// autogenerated do not edit
GWindow menu;
GLabel menu0; 
GButton menu1; 
GButton menu2; 
GButton menu3; 
GButton menu4; 
GWindow create;
GLabel create0; 
GTextField create1; 
GLabel create2; 
GTextField create3; 
GLabel create4; 
GTextField create5; 
GLabel create6; 
GDropList create7; 
GLabel create_coordinateList; 
GLabel create10; 
GButton create12; 
GButton create13; 
GLabel create15; 
GLabel create14; 
GTextField create16; 
GTextField create17; 
GWindow neighbour;
GDropList neighbour1; 
GLabel neighbour0; 
GLabel neighbour2; 
GLabel neighbourList; 
GButton neighbour6; 
GButton neighbour7; 
GWindow edit;
GLabel edit0; 
GTextField edit1; 
GLabel edit2; 
GTextField edit3; 
GLabel edit4; 
GLabel edit6; 
GLabel edit8; 
GLabel edit10; 
GTextField edit5; 
GTextField edit9; 
GTextField edit11; 
GDropList edit7; 
GLabel edit12; 
GLabel edit_coordinateList; 
GButton edit14; 
GButton edit15; 
