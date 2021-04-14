class NotificationList {
  int warningCount;
  final List<dynamic> notifications;

  NotificationList({
    this.warningCount,
    this.notifications,
  });

  factory NotificationList.fromJson(Map<String, dynamic> json) {
    List<dynamic> _notifications = List<NotificationMessage>();
    _notifications = json["notiList"].map((notiList) => NotificationMessage.fromJson(notiList)).toList();

    return NotificationList(
      warningCount: json["warningCount"],
      notifications: _notifications,
    );
  }
}

class NotificationMessage {
  String title;
  String message;
  int type;
  String timestamp;

  NotificationMessage({
    this.title,
    this.message,
    this.type,
    this.timestamp,
  });

  factory NotificationMessage.fromJson(List<dynamic> notiList) => NotificationMessage(
    title: notiList[0],
    message: notiList[1],
    type: notiList[2],
    timestamp: notiList[3],
  );
}