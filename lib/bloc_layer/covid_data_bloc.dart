import 'dart:async';
import 'dart:math';
import 'package:covid_app/bloc_layer/base_bloc.dart';
import 'package:covid_app/data_layer/country.dart';
import 'package:covid_app/data_layer/status.dart';
import 'package:covid_app/repositories/covid_repository.dart';
import 'package:covid_app/repositories/data_repository.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

/// A [BLoC] subclass.
class CovidDataBLoC extends BLoC {

  // FIELDS --------------------------------------------------------------------

  final DataRepository _repository = CovidRepository();

  List<String> _countriesFromStorage;
  List<Country> _countries;

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
    final countries = await _repository.getAvailableCountries(http.Client());
    _countries = countries;
    _countriesController.sink.add(countries);
  }

  Future<void> getStatusOfSelectedCountries(List<String> countryNames) async {
    var statusOfCountries = <Map<String, dynamic>>[];

    for(int i = 0 ; i < countryNames.length ; i++) {
      // ex: countryName = France (FR)
      var nameFormats = countryNames[i].split(' ');

      // ex: France
      final nameStandardFormat = nameFormats.first;

      // ex: FR
      var nameAlpha2Format = nameFormats.last;
      nameAlpha2Format =
          nameAlpha2Format.substring(1, nameAlpha2Format.length - 1);

      final generalStatus = await _repository
          .getStatusByCountry(http.Client(), nameAlpha2Format);
      final timeline = await _repository
          .getTimelineByCountry(http.Client(), nameAlpha2Format);

      if (generalStatus != null || timeline != null) {
        var map = <String, dynamic>{
          COUNTRY_NAME: nameStandardFormat,
          LAST_UPDATE: generalStatus.lastUpdate.split('T').first
        };

        if (generalStatus != null) map[GENERAL_STATUS] = generalStatus;
        if (timeline != null) map[TIMELINE] = _getPointsForChart(timeline);

        statusOfCountries.add(map);
      }
    }

    _countriesFromStorage = countryNames;
    _statusController.sink.add(statusOfCountries);
  }

  // -- Country --

  List<Country> getCountriesNotSelected() {
    if (_countries == null || _countries.isEmpty) return null;

    if (_countriesFromStorage == null || _countriesFromStorage.isEmpty)
      return _countries;

    var selectedCountries = _countriesFromStorage
        .map((country) {
          // ex: countryName = France (FR)
          var name = country.split(' ').last;
          return name.substring(1, name.length - 1);
        })
        .toList();

    return _countries
        .where((country) => !selectedCountries.contains(country.alpha2))
        .toList();
  }

  // -- Timeline --

  /// Gets a [List] which contains 3 [List]s of [Point].
  /// - [List] #1 corresponds to the 'cases' values of 7 last days
  /// - [List] #2 corresponds to the 'recovered' values of 7 last days
  /// - [List] #3 corresponds to the 'deaths' values of 7 last days
  List<List<Point<int>>> _getPointsForChart(List<Status> timeline) {
    var result = [
      <Point<int>>[], // cases
      <Point<int>>[], // recovered
      <Point<int>>[]  // deaths
    ];

    int index = 0;

    // Take the 7 last days
    timeline.take(7).forEach((status) {
      result[0].add(Point(index, status.cases));      // cases
      result[1].add(Point(index, status.recovered));  // recovered
      result[2].add(Point(index, status.deaths));     // deaths

      index--;
    });

    return result;
  }
}