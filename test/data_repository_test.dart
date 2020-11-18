import 'package:covid_app/repositories/covid_repository.dart';
import 'package:covid_app/repositories/data_repository.dart';
import 'package:test/test.dart';

void main() {

  // FIELDS --------------------------------------------------------------------

  final DataRepository repository = CovidRepository();

  // METHODS -------------------------------------------------------------------

  // -- Country --

  test('Country should be a success', () async {
    final data = await repository.getAvailableCountries();
    expect(data.isNotEmpty, true);
  });

  // -- Status --

  test('Status should be a success', () async {
    final data = await repository.getStatusForAllAvailableCountries();
    expect(data.isNotEmpty, true);
  });

  // -- Diff --

  test('Diff should be a success', () async {
    final data = await repository.getDiffForAllAvailableCountries();
    expect(data.isNotEmpty, true);
  });
}