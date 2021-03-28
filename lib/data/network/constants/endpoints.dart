class Endpoints {
  Endpoints._();

  static const String baseUrl = "https://murmuring-reaches-76702.herokuapp.com";
  static const int receiveTimeout = 5000;
  static const int connectionTimeout = 5000;
  static const String loginPatient = baseUrl + "/loginpatient";
  static const String loginGuest = baseUrl + "/loginguest";
  static const String profile = baseUrl + "/profile";
  static const String submitScore = baseUrl + "/testdone";
  static const String getArticles = baseUrl + "/getallarticle";
  static const String getVideos = baseUrl + "/getpatientvdo";
  static const String getAssignments = baseUrl + "/getassignmentlist";
  static const String submitAssignment = baseUrl + "/assignment";
  static const String sendComment = baseUrl + "/comment";
  static const String getNotification = baseUrl + "/getnotification";
  static const String readNotification = baseUrl + "/readnotification";
}