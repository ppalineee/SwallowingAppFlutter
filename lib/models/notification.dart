class NotificationList {
  int warningCount;
  final List<Notification> notifications;

  NotificationList({
    this.warningCount,
    this.notifications,
  });

  factory NotificationList.fromJson(Map<String, dynamic> json) {
    List<dynamic> _notifications = List<Notification>();
    _notifications = json["notiList"].map((notiList) => Notification.fromJson(notiList)).toList();

    return NotificationList(
      warningCount: int.parse(json["warningCount"]),
      notifications: _notifications,
    );
  }
}

class Notification {
  String message;
  int type;
  String timestamp;

  Notification({
    this.message,
    this.type,
    this.timestamp,
  });

  factory Notification.fromJson(List<dynamic> notiList) => Notification(
    message: notiList[0],
    type: int.parse(notiList[1]),
    timestamp: notiList[2],
  );

}