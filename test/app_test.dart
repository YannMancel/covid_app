import 'package:covid_app/services/covid_service.dart' as covidAPI;
import 'package:covid_app/ui_layer/root_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nock/nock.dart';

void main() {

  // FIELDS --------------------------------------------------------------------

  final _countriesLength = 2;
  final _countriesInJsonFormat =
      """
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

  // METHODS -------------------------------------------------------------------

  setUpAll(() {
    nock.defaultBase = covidAPI.BASE_COVID_URL;
    nock.init();
  });

  setUp(() {
    nock.cleanAll();
  });

  testWidgets('Application correctly displays', (WidgetTester tester) async {
    final countryGetInterceptor = nock.get('/countries')
      ..reply(
        200,
        _countriesInJsonFormat
      );

    await tester.pumpWidget(RootApp());

    // VERIFICATION
    expect(find.text('No data'), findsOneWidget);

    // ACTION: Displays Drawer
    await tester.dragFrom(
        tester.getTopLeft(find.byType(MaterialApp)),
        Offset(300, 0));
    await tester.pumpAndSettle();

    // VERIFICATION
    expect(countryGetInterceptor.isDone, true);
    expect(find.text('Countries'), findsOneWidget);
    expect(find.text('No country'), findsNothing);
    expect(find.text('$_countriesLength available countries'), findsOneWidget);
  });
}