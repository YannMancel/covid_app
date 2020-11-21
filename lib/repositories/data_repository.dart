import 'package:covid_app/data_layer/country.dart';
import 'package:covid_app/data_layer/diff.dart';
import 'package:covid_app/data_layer/status.dart';

abstract class DataRepository {

  // -- Country --

  /// Returns all available countries.
  Future<List<Country>> getAvailableCountries();

  // -- Status --

  /// Returns latest [Status] for all available countries.
  Future<List<Status>> getStatusForAllAvailableCountries();

  /// Returns latest [Status] for a country.
  Future<Status> getStatusByCountry(String countryInAlpha2Format);

  // -- Diff --

  /// Returns [Diff] between the latest state and previous one
  /// for all available countries.
  Future<List<Diff>> getDiffForAllAvailableCountries();

  /// Returns [Diff] between the latest state and previous one
  /// for a country.
  Future<Diff> getDiffByCountry(String countryInAlpha2Format);

  // -- Timeline --

  /// Returns a timeline in [List] of [Status] for a specific country.
  Future<List<Status>> getTimelineByCountry(String countryInAlpha2Format);
}