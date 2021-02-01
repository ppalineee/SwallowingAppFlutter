class Endpoints {
  Endpoints._();

  static const String baseUrl = "https://linear-reporter-301302.et.r.appspot.com";
  static const int receiveTimeout = 8000;
  static const int connectionTimeout = 8000;
  static const String loginPatient = baseUrl + "/loginpatient";
  static const String profile = baseUrl + "/profile";
  static const String submitScore = baseUrl + "/testdone";
  static const String getArticles = baseUrl + "/getallarticle";
  static const String getVideos = baseUrl + "/getpatientvdo";
  static const String getAssignments = baseUrl + "/getassignmentlist";
}