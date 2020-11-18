import 'package:covid_app/data_layer/country.dart';
import 'package:covid_app/data_layer/diff.dart';
import 'package:covid_app/data_layer/status.dart';

abstract class DataRepository {

  /// Returns all available countries.
  Future<List<Country>> getAvailableCountries();

  /// Returns latest [Status] for all available countries.
  Future<List<Status>> getStatusForAllAvailableCountries();

  /// Returns [Diff] between the latest state and previous one.
  /// for all available countries.
  Future<List<Diff>> getDiffForAllAvailableCountries();
}