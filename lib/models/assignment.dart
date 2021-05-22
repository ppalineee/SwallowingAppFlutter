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
  String videoPatient;
  String videoTimestamp;
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
    this.videoPatient,
    this.videoTimestamp,
    this.comments,
  });

  factory Assignment.fromJson(Map<String, dynamic> json) {
    List<dynamic> _comments = List<dynamic>();
    if (json["chatLog"] != null) {
      _comments = json["chatLog"].map((comment) => Comment.fromJson(comment)).toList();
    } else {
      _comments = [];
    }

    return Assignment(
      id: json["_id"],
      hnNumber: json["HN"],
      status: int.parse(json["status"]),
      title: json["title"],
      timestamp: json["timeStart"],
      dueDate: json["task"],
      videoName: json["vdoName"],
      videoUrl: json["vdoURL"],
      videoPatient: json["patientVdo"],
      videoTimestamp: json["timestamp"],
      comments: _comments,
    );
  }
}

class Comment {
  String message;
  String creator;
  String timestamp;
  bool isPatient;

  Comment({
    this.message,
    this.creator,
    this.timestamp,
    this.isPatient
  });

  factory Comment.fromJson(List<dynamic> comment) {
    bool _isPatient;
    if (comment.length < 4) {
      _isPatient = false;
    } else {
      _isPatient = (comment[3] != 'Therapist') ? true : false;
    }

    return Comment(
      message: comment[0],
      creator: comment[1],
      timestamp: comment[2],
      isPatient: _isPatient,
    );
  }
}