class Formable {

  String name;
  ArrayList<Territory> territories;
  
  
  public Formable() {
    this.name = "";
    this.territories = new ArrayList<>();
  }

  public Formable(String name, ArrayList<Territory> containedTerritories) {
    this.name = name;
    this.territories = containedTerritories;
  }
}
