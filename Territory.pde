class Territory {

  String name;
  String nation;
  int population;
  int terrain;
  ArrayList<PVector> coordinates;
  ArrayList<Territory> neighbours;
  float coal;
  float oil;
  
  public Territory() {
    name = "";
    nation = "";
    population = 0;
    terrain = 1;
    coordinates = new ArrayList<>();
    neighbours = new ArrayList<>();
    coal = 0;
    oil = 0;
  }
  
  public Territory(String name, String nation, int population, int terrain, ArrayList<PVector> coordinates, ArrayList<Territory> neighbours, float coal, float oil) {
    this.name = name;
    this.nation = nation;
    this.population = population;
    this.terrain = terrain;
    this.coordinates = coordinates;
    this.neighbours = neighbours;
    this.coal = coal;
    this.oil = oil;
  }


  @Override
  public String toString() {
    String s = "____________________________________________\n" + this.name + "\n\nNation: " + this.nation + "\nPopulation: " + this.population + "\nTerrain Type: " + this.terrain + "\n\nNeighbours:";
    
    for (Territory t : neighbours) {
      try {
        s += "\n" + t.name;
      } catch (Exception ignored) {}
    }
    
    s += "\nCoal: " + this.coal + "\nOil: " + this.oil + "\n____________________________________________";
    
    return s;
  }
  
  public Territory copy() {
  
    return new Territory(name, nation, population, terrain, coordinates, neighbours, coal, oil);
    
  }
  
  
    public Territory copyWithoutNeighbours() {
  
    return new Territory(name, nation, population, terrain, coordinates, new ArrayList<>(), coal, oil);
    
  }
}
