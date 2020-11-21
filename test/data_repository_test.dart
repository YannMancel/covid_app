import 'package:covid_app/repositories/covid_repository.dart';
import 'package:covid_app/repositories/data_repository.dart';
import 'package:test/test.dart';

const COUNTRY_GOOD_FORMAT = 'FR';
const COUNTRY_BAD_FORMAT = 'France';

void main() {

  // FIELDS --------------------------------------------------------------------

  final DataRepository repository = CovidRepository();

  // METHODS -------------------------------------------------------------------

  // -- Country --

  group('Country', () {
    test('Country should be a success', () async {
      final data = await repository.getAvailableCountries();
      expect(data.isNotEmpty, true);
    });
  });

  // -- Status --

  group('Status', () {
    test('Status should be a success', () async {
      final data = await repository.getStatusForAllAvailableCountries();
      expect(data.isNotEmpty, true);
    });

    test('Status by country should be a success', () async {
      final data = await repository.getStatusByCountry(COUNTRY_GOOD_FORMAT);
      expect(data != null, true);
      expect(data.country, COUNTRY_GOOD_FORMAT);
    });

    test('Status by country should be a fail', () async {
      final data = await repository.getStatusByCountry(COUNTRY_BAD_FORMAT);
      expect(data == null, true);
    });
  });

  // -- Diff --

  group('Diff', () {
    test('Diff should be a success', () async {
      final data = await repository.getDiffForAllAvailableCountries();
      expect(data.isNotEmpty, true);
    });

    test('Diff by country should be a success', () async {
      final data = await repository.getDiffByCountry(COUNTRY_GOOD_FORMAT);
      expect(data != null, true);
      expect(data.country, COUNTRY_GOOD_FORMAT);
    });

    test('Diff by country should be a fail', () async {
      final data = await repository.getDiffByCountry(COUNTRY_BAD_FORMAT);
      expect(data == null, true);
    });
  });

  // -- Timeline --

  group('Timeline', () {
    test('Timeline by country should be a success', () async {
      final data = await repository.getTimelineByCountry(COUNTRY_GOOD_FORMAT);
      expect(data != null, true);
      expect(data[0].country, COUNTRY_GOOD_FORMAT);
    });

    test('Timeline by country should be a fail', () async {
      final data = await repository.getTimelineByCountry(COUNTRY_BAD_FORMAT);
      expect(data == null, true);
    });
  });
}