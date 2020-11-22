
const COUNTRY_NAME = 'country_name';
const LAST_UPDATE = 'last_update';
const GENERAL_STATUS = 'general_status';
const TIMELINE = 'timeline';

class Status {

  // FIELDS --------------------------------------------------------------------

  String country;
  String lastUpdate;
  int cases;
  int deaths;
  int recovered;

  // CONSTRUCTORS --------------------------------------------------------------

  Status._();

  Status.fromMap(Map<String, dynamic> map) {
    country = map['country'];
    lastUpdate = map['last_update'];
    cases = map['cases'];
    deaths = map['deaths'];
    recovered = map['recovered'];
  }
}