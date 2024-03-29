class ApiConstants {
  static const unauthenticatedEngelsburgApiHeaders = {
    'Content-Type': 'application/json; charset=utf-8',
    'Accept': 'application/json; charset=utf-8'
  };
  static const engelsburgApiBaseUrl = 'https://engelsburg-api.de';
  static const engelsburgApiEventsUrl = engelsburgApiBaseUrl + '/event';
  static const engelsburgApiArticlesUrl = engelsburgApiBaseUrl + '/article';
  static const engelsburgApiCafeteriaUrl = engelsburgApiBaseUrl + '/cafeteria';
  static const engelsburgApiSolarSystemUrl =
      engelsburgApiBaseUrl + '/solar_system';
  static const engelsburgApiSignUpUrl = engelsburgApiBaseUrl + '/auth/signup';
  static const engelsburgApiRefreshUrl = engelsburgApiBaseUrl + '/auth/refresh';
  static const engelsburgApiSubstituteMessageUrl =
      engelsburgApiBaseUrl + '/substitute/message';
  static const engelsburgApiSubstitutesUrl =
      engelsburgApiBaseUrl + "/substitute";
}
