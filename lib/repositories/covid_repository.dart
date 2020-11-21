import 'package:covid_app/data_layer/country.dart';
import 'package:covid_app/data_layer/diff.dart';
import 'package:covid_app/data_layer/status.dart';
import 'package:covid_app/repositories/data_repository.dart';
import 'package:covid_app/services/covid_service.dart' as covidAPI;
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

/// A [DataRepository] subclass.
class CovidRepository extends DataRepository {

  // -- Country --

  @override
  Future<List<Country>> getAvailableCountries() async {
    final url = covidAPI.getUrlToLoadAvailableCountries();
    final http.Response response = await http.get(url);

    // Error GET request
    if (response.statusCode != 200) return null;

    final List<dynamic> countriesInMaps = convert.jsonDecode(response.body);

    var countries = <Country>[];
    countriesInMaps.forEach((countryMap) =>
        countries.add(Country.fromMap(countryMap)));

    return countries;
  }

  // -- Status --

  @override
  Future<List<Status>> getStatusForAllAvailableCountries() async {
    final url = covidAPI.getUrlToLoadStatus();
    final http.Response response = await http.get(url);

    // Error GET request
    if (response.statusCode != 200) return null;

    final List<dynamic> statusInMaps = convert.jsonDecode(response.body);

    var status = <Status>[];
    statusInMaps.forEach((statusMap) =>
        status.add(Status.fromMap(statusMap)));

    return status;
  }

  @override
  Future<Status> getStatusByCountry(String countryInAlpha2Format) async {
    final url = covidAPI.getUrlToLoadStatusByCountry(countryInAlpha2Format);

    // Error with format of argument
    if (url == null) return null;

    final http.Response response = await http.get(url);

    // Error GET request
    if (response.statusCode != 200) return null;

    return Status.fromMap(convert.jsonDecode(response.body));
  }

  // -- Diff --

  @override
  Future<List<Diff>> getDiffForAllAvailableCountries() async {
    final url = covidAPI.getUrlToLoadDiff();
    final http.Response response = await http.get(url);

    // Error GET request
    if (response.statusCode != 200) return null;

    final List<dynamic> diffInMaps = convert.jsonDecode(response.body);

    var diff = <Diff>[];
    diffInMaps.forEach((statusMap) =>
        diff.add(Diff.fromMap(statusMap)));

    return diff;
  }

  @override
  Future<Diff> getDiffByCountry(String countryInAlpha2Format) async {
    final url = covidAPI.getUrlToLoadDiffByCountry(countryInAlpha2Format);

    // Error with format of argument
    if (url == null) return null;

    final http.Response response = await http.get(url);

    // Error GET request
    if (response.statusCode != 200) return null;

    return Diff.fromMap(convert.jsonDecode(response.body));
  }

  // -- Timeline --

  @override
  Future<List<Status>> getTimelineByCountry(String countryInAlpha2Format) async {
    final url = covidAPI.getUrlToLoadTimelineByCountry(countryInAlpha2Format);

    // Error with format of argument
    if (url == null) return null;

    final http.Response response = await http.get(url);

    // Error GET request
    if (response.statusCode != 200) return null;

    final List<dynamic> statusInMaps = convert.jsonDecode(response.body);

    var status = <Status>[];
    statusInMaps.forEach((statusMap) =>
        status.add(Status.fromMap(statusMap)));

    return status;
  }
}