import 'dart:async';
import 'package:covid_app/bloc_layer/base_bloc.dart';
import 'package:covid_app/helpers/shared_preferences_helpers.dart' as sharedPreferences;

const COUNTRIES_KEY = 'countries';

/// A [BLoC] subclass.
class StorageBLoC extends BLoC {

  // FIELDS --------------------------------------------------------------------

  List<String> _countryNames;
  List<String> get countryName => _countryNames;

  final _countryNamesController = StreamController<List<String>>.broadcast();
  Stream<List<String>> get countryNamesStream => _countryNamesController.stream;

  // CONSTRUCTORS --------------------------------------------------------------

  StorageBLoC() {
    _loadCountryNames();
  }

  // METHODS -------------------------------------------------------------------

  // -- BLoC --

  @override
  void dispose() =>_countryNamesController.close();

  // -- StreamController --

  Future<void> _loadCountryNames() async {
    final countryNames = await sharedPreferences
        .getStringListFromSharedPreferences(COUNTRIES_KEY);

    _countryNames = countryNames ?? <String>[];
    _countryNamesController.sink.add(_countryNames);
  }

  Future<void> addCountryNames(List<String> countryNames) async {
    final newCountryNames = <String>[]
      ..addAll(_countryNames)
      ..addAll(countryNames)
      ..sort();

    final isSaved = await sharedPreferences
        .setStringListFromSharedPreferences(COUNTRIES_KEY, newCountryNames);

    if (isSaved) {
      _countryNames = newCountryNames;
      _countryNamesController.sink.add(_countryNames);
    }
  }

  Future<void> removeCountryName(String countryName) async {
    final isRemoved = _countryNames.remove(countryName);

    if(isRemoved) {
      final isSaved = await sharedPreferences
          .setStringListFromSharedPreferences(COUNTRIES_KEY, _countryNames);

      if (isSaved) _countryNamesController.sink.add(_countryNames);;
    }
  }
}