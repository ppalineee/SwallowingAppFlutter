class AssignmentList {
  final List<Assignment> assignments;

  AssignmentList({
    this.assignments,
  });

  factory AssignmentList.fromJson(List<dynamic> json) {
    List<Assignment> assignments = List<Assignment>();
    assignments = json.map((assignment) => Assignment.fromJson(assignment)).toList();

    return AssignmentList(
      assignments: assignments,
    );
  }
}

class Assignment {
  String id;
  String hnNumber;
  int status;
  String title;
  String timestamp;
  String dueDate;
  String videoName;
  String videoUrl;
  List<dynamic> comments;

  Assignment({
    this.id,
    this.hnNumber,
    this.status,
    this.title,
    this.timestamp,
    this.dueDate,
    this.videoName,
    this.videoUrl,
    this.comments,
  });

  factory Assignment.fromJson(Map<String, dynamic> json) {
    List<dynamic> _comments = List<dynamic>();
    _comments = json["chatLog"].map((comment) => Comment.fromJson(comment)).toList();

    return Assignment(
      id: json["_id"],
      hnNumber: json["HN"],
      status: int.parse(json["status"]),
      title: json["title"],
      timestamp: json["timeStart"],
      dueDate: json["task"],
      videoName: json["vdoName"],
      videoUrl: json["vdoURL"],
      comments: _comments,
    );
  }
}

class Comment {
  String message;
  String commentator;
  String timestamp;

  Comment({
    this.message,
    this.commentator,
    this.timestamp,
  });

  factory Comment.fromJson(List<dynamic> comment) => Comment(
    message: comment[0],
    commentator: comment[1],
    timestamp: comment[2],
  );
}