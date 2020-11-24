import 'package:covid_app/data_layer/country.dart';
import 'package:covid_app/data_layer/diff.dart';
import 'package:covid_app/data_layer/status.dart';
import 'package:covid_app/repositories/covid_repository.dart';
import 'package:covid_app/repositories/data_repository.dart';
import 'package:covid_app/services/covid_service.dart' as covidAPI;
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

const COUNTRY_GOOD_FORMAT = 'FR';
const COUNTRY_BAD_FORMAT = 'France';

class MockClient extends Mock implements http.Client {}

void main() {

  // FIELDS --------------------------------------------------------------------

  final DataRepository repository = CovidRepository();

  // METHODS -------------------------------------------------------------------

  // -- Country --

  group('Country', () {
    test('Country should be a success', () async {
      final client = MockClient();

      final dummyCountries = """
      [
        {
          "name" : "n1",
          "alpha2" : "a1"
        },
        {
          "name" : "n2",
          "alpha2" : "a2"
        }
      ]
      """;

      when(client.get(covidAPI.getUrlToLoadAvailableCountries()))
          .thenAnswer((_) async => http.Response(dummyCountries, 200));

      final data = await repository.getAvailableCountries(client);
      expect(data, allOf(isNotNull, isNotEmpty));
      expect(data.length, equals(2));
      expect(data, isA<List<Country>>());
    }, timeout: Timeout(Duration(minutes: 1)));

    test('Country should be a fail (status code does not equal to 200)', () async {
      final client = MockClient();

      when(client.get(covidAPI.getUrlToLoadAvailableCountries()))
          .thenAnswer((_) async => http.Response('', 404));

      final data = await repository.getAvailableCountries(client);
      expect(data, isNull);
    }, timeout: Timeout(Duration(minutes: 1)));
  });

  // -- Status --

  group('Status', () {
    test('Status should be a success', () async {
      final client = MockClient();

      final dummyStatus = """
      [
        {
          "country" : "c1",
          "last_update" : "l1",
          "cases" : 1,
          "deaths" : 1,
          "recovered" : 1
        },
        {
          "country" : "c2",
          "last_update" : "l2",
          "cases" : 2,
          "deaths" : 2,
          "recovered" : 2
        }
      ]
      """;

      when(client.get(covidAPI.getUrlToLoadStatus()))
          .thenAnswer((_) async => http.Response(dummyStatus, 200));

      final data = await repository.getStatusForAllAvailableCountries(client);
      expect(data, allOf(isNotNull, isNotEmpty));
      expect(data.length, equals(2));
      expect(data, isA<List<Status>>());
    }, timeout: Timeout(Duration(minutes: 1)));

    test('Status should be a fail (status code does not equal to 200)', () async {
      final client = MockClient();

      when(client.get(covidAPI.getUrlToLoadStatus()))
          .thenAnswer((_) async => http.Response('', 404));

      final data = await repository.getStatusForAllAvailableCountries(client);
      expect(data, isNull);
    }, timeout: Timeout(Duration(minutes: 1)));

    test('Status by country should be a success', () async {
      final client = MockClient();

      final dummyStatus = """
      {
        "country" : "c1",
        "last_update" : "l1",
        "cases" : 1,
        "deaths" : 1,
        "recovered" : 1
      }
      """;

      when(client.get(covidAPI.getUrlToLoadStatusByCountry(COUNTRY_GOOD_FORMAT)))
          .thenAnswer((_) async => http.Response(dummyStatus, 200));

      final data = await repository.getStatusByCountry(client, COUNTRY_GOOD_FORMAT);
      expect(data, isNotNull);
      expect(data, isA<Status>());
    }, timeout: Timeout(Duration(minutes: 1)));

    test('Status by country should be a fail (Bad format for country)', () async {
      final client = MockClient();
      final data = await repository.getStatusByCountry(client, COUNTRY_BAD_FORMAT);
      expect(data, isNull);
    }, timeout: Timeout(Duration(minutes: 1)));

    test('Status by country should be a fail (status code does not equal to 200)', () async {
      final client = MockClient();

      when(client.get(covidAPI.getUrlToLoadStatusByCountry(COUNTRY_GOOD_FORMAT)))
          .thenAnswer((_) async => http.Response('', 404));

      final data = await repository.getStatusByCountry(client, COUNTRY_GOOD_FORMAT);
      expect(data, isNull);
    }, timeout: Timeout(Duration(minutes: 1)));
  });

  // -- Diff --

  group('Diff', () {
    test('Diff should be a success', () async {
      final client = MockClient();

      final dummyDiff = """
      [
        {
          "country" : "c1",
          "last_update" : "l1",
          "new_cases" : 1,
          "new_deaths" : 1,
          "new_recovered" : 1
        },
        {
          "country" : "c2",
          "last_update" : "l2",
          "new_cases" : 2,
          "new_deaths" : 2,
          "new_recovered" : 2
        }
      ]
      """;

      when(client.get(covidAPI.getUrlToLoadDiff()))
          .thenAnswer((_) async => http.Response(dummyDiff, 200));

      final data = await repository.getDiffForAllAvailableCountries(client);
      expect(data, allOf(isNotNull, isNotEmpty));
      expect(data.length, equals(2));
      expect(data, isA<List<Diff>>());
    }, timeout: Timeout(Duration(minutes: 1)));

    test('Diff should be a fail (status code does not equal to 200)', () async {
      final client = MockClient();

      when(client.get(covidAPI.getUrlToLoadDiff()))
          .thenAnswer((_) async => http.Response('', 404));

      final data = await repository.getDiffForAllAvailableCountries(client);
      expect(data, isNull);
    }, timeout: Timeout(Duration(minutes: 1)));

    test('Diff by country should be a success', () async {
      final client = MockClient();

      final dummyDiff = """
      {
        "country" : "c1",
        "last_update" : "l1",
        "new_cases" : 1,
        "new_deaths" : 1,
        "new_recovered" : 1
      }
      """;

      when(client.get(covidAPI.getUrlToLoadDiffByCountry(COUNTRY_GOOD_FORMAT)))
          .thenAnswer((_) async => http.Response(dummyDiff, 200));

      final data = await repository.getDiffByCountry(client, COUNTRY_GOOD_FORMAT);
      expect(data, isNotNull);
      expect(data, isA<Diff>());
    }, timeout: Timeout(Duration(minutes: 1)));

    test('Diff by country should be a fail (Bad format for country)', () async {
      final client = MockClient();
      final data = await repository.getDiffByCountry(client, COUNTRY_BAD_FORMAT);
      expect(data, isNull);
    }, timeout: Timeout(Duration(minutes: 1)));

    test('Diff by country should be a fail (status code does not equal to 200)', () async {
      final client = MockClient();

      when(client.get(covidAPI.getUrlToLoadDiffByCountry(COUNTRY_GOOD_FORMAT)))
          .thenAnswer((_) async => http.Response('', 404));

      final data = await repository.getDiffByCountry(client, COUNTRY_GOOD_FORMAT);
      expect(data, isNull);
    }, timeout: Timeout(Duration(minutes: 1)));
  });

  // -- Timeline --

  group('Timeline', () {
    test('Timeline by country should be a success', () async {
      final client = MockClient();

      final dummyStatus = """
      [
        {
          "country" : "c1",
          "last_update" : "l1",
          "cases" : 1,
          "deaths" : 1,
          "recovered" : 1
        },
        {
          "country" : "c1",
          "last_update" : "l2",
          "cases" : 2,
          "deaths" : 2,
          "recovered" : 2
        }
      ]
      """;

      when(client.get(covidAPI.getUrlToLoadTimelineByCountry(COUNTRY_GOOD_FORMAT)))
          .thenAnswer((_) async => http.Response(dummyStatus, 200));

      final data = await repository.getTimelineByCountry(client, COUNTRY_GOOD_FORMAT);
      expect(data, allOf(isNotNull, isNotEmpty));
      expect(data.length, equals(2));
      expect(data, isA<List<Status>>());
    }, timeout: Timeout(Duration(minutes: 1)));

    test('Timeline by country should be a fail (Bad format for country)', () async {
      final client = MockClient();
      final data = await repository.getTimelineByCountry(client, COUNTRY_BAD_FORMAT);
      expect(data, isNull);
    }, timeout: Timeout(Duration(minutes: 1)));

    test('Timeline by country should be a fail (status code does not equal to 200)', () async {
      final client = MockClient();

      when(client.get(covidAPI.getUrlToLoadTimelineByCountry(COUNTRY_GOOD_FORMAT)))
          .thenAnswer((_) async => http.Response('', 404));

      final data = await repository.getTimelineByCountry(client, COUNTRY_GOOD_FORMAT);
      expect(data, isNull);
    }, timeout: Timeout(Duration(minutes: 1)));
  });
}