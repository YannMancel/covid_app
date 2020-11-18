
// EXTENSIONS ------------------------------------------------------------------

extension on String {
  /// An Alpha2 format is a [String] of 2 letters.
  /// ex: FR or Fr or fR or fr (case Sensitive is false)
  bool isAlpha2Format() {
    final regExp = RegExp(r'^[a-zA-Z]{2}$', caseSensitive: false);
    return regExp.hasMatch(this);
  }
}

// FIELDS ----------------------------------------------------------------------

const BASE_COVID_URL = 'https://covid19-api.org/api';

// METHODS ---------------------------------------------------------------------

// -- Status --

/// Url which returns latest state for all available countries.
String getUrlToLoadStatus() => '$BASE_COVID_URL/status';

/// Url which returns latest state for a specific country.
/// ex:
///   country ...................... France
///   countryInAlpha2Format ........ FR
/// If [countryInAlpha2Format] is null or not the proper format,
/// the Url will be null.
String getUrlToLoadStatusByCountry(String countryInAlpha2Format) {
  // Error data
  if (countryInAlpha2Format == null
      || !countryInAlpha2Format.isAlpha2Format()) return null;

  return '$BASE_COVID_URL/status/$countryInAlpha2Format';
}

// -- Diff --

/// Url which returns diff between the latest state and previous one
/// for all available countries.
String getUrlToLoadDiff() => '$BASE_COVID_URL/diff';

/// Url which returns diff between the latest state and previous one
/// for a specific country.
/// ex:
///   country ...................... France
///   countryInAlpha2Format ........ FR
/// If [countryInAlpha2Format] is null or not the proper format,
/// the Url will be null.
String getUrlToLoadDiffByCountry(String countryInAlpha2Format) {
  // Error data
  if (countryInAlpha2Format == null
      || !countryInAlpha2Format.isAlpha2Format()) return null;

  return '$BASE_COVID_URL/diff/$countryInAlpha2Format';
}

// -- Timeline --

/// Url which returns timeline for a specific country.
/// ex:
///   country ...................... France
///   countryInAlpha2Format ........ FR
/// If [countryInAlpha2Format] is null or not the proper format,
/// the Url will be null.
String getUrlToLoadTimelineByCountry(String countryInAlpha2Format) {
  // Error data
  if (countryInAlpha2Format == null
      || !countryInAlpha2Format.isAlpha2Format()) return null;

  return '$BASE_COVID_URL/timeline/$countryInAlpha2Format';
}

// -- Country --

/// Url which returns all available countries.
String getUrlToLoadAvailableCountries() => '$BASE_COVID_URL/countries';

// -- Prediction --

/// Url which returns two weeks prediction for a specific country.
/// ex:
///   country ...................... France
///   countryInAlpha2Format ........ FR
/// If [countryInAlpha2Format] is null or not the proper format,
/// the Url will be null.
String getUrlToLoadPredictionByCountry(String countryInAlpha2Format) {
  // Error data
  if (countryInAlpha2Format == null
      || !countryInAlpha2Format.isAlpha2Format()) return null;

  return '$BASE_COVID_URL/prediction/$countryInAlpha2Format';
}