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

  final _statusController = StreamController<List<Status>>();
  Stream<List<Status>> get statusStream => _statusController.stream;

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
    var statusOfCountries = <Status>[];

    for(int i = 0 ; i < countryNames.length ; i++) {
      // ex: countryName = France (FR)
      var name = countryNames[i].split(' ').last;
      name = name.substring(1, name.length - 1);

      final status = await _repository.getStatusByCountry(name);
      if (status != null) statusOfCountries.add(status);
    }

    _statusController.sink.add(statusOfCountries);
  }
}