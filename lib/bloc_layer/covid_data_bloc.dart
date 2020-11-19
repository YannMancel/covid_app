import 'dart:async';
import 'package:covid_app/bloc_layer/base_bloc.dart';
import 'package:covid_app/data_layer/country.dart';
import 'package:covid_app/repositories/covid_repository.dart';
import 'package:covid_app/repositories/data_repository.dart';

/// A [BLoC] subclass.
class CovidDataBLoC extends BLoC {

  // FIELDS --------------------------------------------------------------------

  final DataRepository _repository = CovidRepository();

  List<Country> _countries;
  List<Country> get countries => _countries;

  final _countriesController = StreamController<List<Country>>.broadcast();
  Stream<List<Country>> get countriesStream => _countriesController.stream;

  // CONSTRUCTORS --------------------------------------------------------------

  CovidDataBLoC() {
    _loadAllAvailableCountries();
  }

  // METHODS -------------------------------------------------------------------

  // -- BLoC --

  @override
  void dispose() {
    _countriesController.close();
  }

  // -- StreamController --

  Future<void> _loadAllAvailableCountries() async {
    final countries = await _repository.getAvailableCountries();
    _countries = countries;
    _countriesController.sink.add(countries);
  }
}