class Endpoints {
  Endpoints._();

  static const String baseUrl = "https://finaltestserver-301208.et.r.appspot.com";
  static const int receiveTimeout = 8000;
  static const int connectionTimeout = 8000;
  static const String loginPatient = baseUrl + "/loginpatient";
  static const String profile = baseUrl + "/profile";
  static const String submitScore = baseUrl + "/testdone";
}