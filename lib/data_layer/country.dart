
class Country {

  // FIELDS --------------------------------------------------------------------

  String name;
  String alpha2;

  // CONSTRUCTORS --------------------------------------------------------------

  Country._();

  Country.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    alpha2 = map['alpha2'];
  }
}