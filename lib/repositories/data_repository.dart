import 'package:covid_app/data_layer/country.dart';
import 'package:covid_app/data_layer/diff.dart';
import 'package:covid_app/data_layer/status.dart';
import 'package:http/http.dart' as http;

abstract class DataRepository {

  // -- Country --

  /// Returns all available countries.
  Future<List<Country>> getAvailableCountries(http.Client client);

  // -- Status --

  /// Returns latest [Status] for all available countries.
  Future<List<Status>> getStatusForAllAvailableCountries(http.Client client);

  /// Returns latest [Status] for a country.
  Future<Status> getStatusByCountry(
    http.Client client,
    String countryInAlpha2Format
  );

  // -- Diff --

  /// Returns [Diff] between the latest state and previous one
  /// for all available countries.
  Future<List<Diff>> getDiffForAllAvailableCountries(http.Client client);

  /// Returns [Diff] between the latest state and previous one
  /// for a country.
  Future<Diff> getDiffByCountry(
    http.Client client,
    String countryInAlpha2Format
  );

  // -- Timeline --

  /// Returns a timeline in [List] of [Status] for a specific country.
  Future<List<Status>> getTimelineByCountry(
    http.Client client,
    String countryInAlpha2Format
  );
}