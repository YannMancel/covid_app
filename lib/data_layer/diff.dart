
class Diff {

  // FIELDS --------------------------------------------------------------------

  String country;
  String lastUpdate;
  int newCases;
  int newDeaths;
  int newRecovered;

  // CONSTRUCTORS --------------------------------------------------------------

  Diff._();

  Diff.fromMap(Map<String, dynamic> map) {
    country = map['country'];
    lastUpdate = map['last_update'];
    newCases = map['new_cases'];
    newDeaths = map['new_deaths'];
    newRecovered = map['new_recovered'];
  }
}