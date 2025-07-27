class Nation {

  String name;
  ArrayList<Territory> territories;
  
  
  public Nation() {
    this.name = "";
    this.territories = new ArrayList<>();
  }

  public Nation(String name, ArrayList<Territory> containedTerritories) {
    this.name = name;
    this.territories = containedTerritories;
  }
}
