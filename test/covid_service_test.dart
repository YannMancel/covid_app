import 'package:covid_app/services/covid_service.dart' as covidAPI;
import 'package:test/test.dart';

const COVID_URL = 'https://covid19-api.org/api';
const COUNTRY_GOOD_FORMAT = 'FR';
const COUNTRY_BAD_FORMAT = 'France';

void main() {

  // -- Status --

  group('Status', () {
    test('Status should be a success', () {
      expect(
          covidAPI.getUrlToLoadStatus(),
          '$COVID_URL/status');
    });

    test('Status by country should be a success', () {
      expect(
          covidAPI.getUrlToLoadStatusByCountry(COUNTRY_GOOD_FORMAT),
          '$COVID_URL/status/$COUNTRY_GOOD_FORMAT');
    });

    test('Status by country should be a fail', () {
      // Wrong format for country
      expect(covidAPI.getUrlToLoadStatusByCountry(COUNTRY_BAD_FORMAT), null);

      // Null country
      expect(covidAPI.getUrlToLoadStatusByCountry(null), null);
    });
  });

  // -- Diff --
  group('Diff', () {
    test('Diff should be a success', () {
      expect(
          covidAPI.getUrlToLoadDiff(),
          '$COVID_URL/diff');
    });

    test('Diff by country should be a success', () {
      expect(
          covidAPI.getUrlToLoadDiffByCountry(COUNTRY_GOOD_FORMAT),
          '$COVID_URL/diff/$COUNTRY_GOOD_FORMAT');
    });

    test('Diff by country should be a fail', () {
      // Wrong format for country
      expect(covidAPI.getUrlToLoadDiffByCountry(COUNTRY_BAD_FORMAT), null);

      // Null country
      expect(covidAPI.getUrlToLoadDiffByCountry(null), null);
    });
  });

  // -- Timeline --

  group('Timeline', () {
    test('Timeline by country should be a success', () {
      expect(
          covidAPI.getUrlToLoadTimelineByCountry(COUNTRY_GOOD_FORMAT),
          '$COVID_URL/timeline/$COUNTRY_GOOD_FORMAT');
    });

    test('Timeline by country should be a fail', () {
      // Wrong format for country
      expect(covidAPI.getUrlToLoadTimelineByCountry(COUNTRY_BAD_FORMAT), null);

      // Null country
      expect(covidAPI.getUrlToLoadTimelineByCountry(null), null);
    });
  });

  // -- Country --

  group('Country', () {
    test('Country should be a success', () {
      expect(
          covidAPI.getUrlToLoadAvailableCountries(),
          '$COVID_URL/countries');
    });
  });

  // -- Prediction --

  group('Prediction', () {
    test('Prediction by country should be a success', () {
      expect(
          covidAPI.getUrlToLoadPredictionByCountry(COUNTRY_GOOD_FORMAT),
          '$COVID_URL/prediction/$COUNTRY_GOOD_FORMAT');
    });

    test('Prediction by country should be a fail', () {
      // Wrong format for country
      expect(covidAPI.getUrlToLoadPredictionByCountry(COUNTRY_BAD_FORMAT), null);

      // Null country
      expect(covidAPI.getUrlToLoadPredictionByCountry(null), null);
    });
  });
}