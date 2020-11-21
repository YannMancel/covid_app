import 'dart:async';
import 'package:covid_app/bloc_layer/base_bloc.dart';
import 'package:covid_app/data_layer/country.dart';
import 'package:covid_app/data_layer/status.dart';
import 'package:covid_app/repositories/covid_repository.dart';
import 'package:covid_app/repositories/data_repository.dart';
import 'package:rxdart/rxdart.dart';

/// A [BLoC] subclass.
class CovidDataBLoC extends BLoC {

  // FIELDS --------------------------------------------------------------------

  final DataRepository _repository = CovidRepository();

  List<Country> _countries;
  List<Country> get countries => _countries;

  final _countriesController = BehaviorSubject<List<Country>>();
  Stream<List<Country>> get countriesStream => _countriesController.stream;

  final _statusController = StreamController<List<Map<String, dynamic>>>();
  Stream<List<Map<String, dynamic>>> get statusStream => _statusController.stream;

  // CONSTRUCTORS --------------------------------------------------------------

  CovidDataBLoC() {
    _loadAllAvailableCountries();
  }

  // METHODS -------------------------------------------------------------------

  // -- BLoC --

  @override
  void dispose() {
    _countriesController.close();
    _statusController.close();
  }

  // -- StreamController --

  Future<void> _loadAllAvailableCountries() async {
    final countries = await _repository.getAvailableCountries();
    _countries = countries;
    _countriesController.sink.add(countries);
  }

  Future<void> getStatusOfSelectedCountries(List<String> countryNames) async {
    var statusOfCountries = <Map<String, dynamic>>[];

    for(int i = 0 ; i < countryNames.length ; i++) {
      // ex: countryName = France (FR)
      var name = countryNames[i].split(' ').last;
      name = name.substring(1, name.length - 1);

      final generalStatus = await _repository.getStatusByCountry(name);
      final timeline = await _repository.getTimelineByCountry(name);

      if (generalStatus != null || timeline != null) {
        var map = <String, dynamic>{};

        if (generalStatus != null) map[GENERAL_STATUS] = generalStatus;
        if (timeline != null) map[TIMELINE] = timeline;

        statusOfCountries.add(map);
      }
    }

    _statusController.sink.add(statusOfCountries);
  }
}