class VideoList {
  final List<Video> videos;

  VideoList({
    this.videos,
  });

  factory VideoList.fromJson(List<dynamic> json) {
    List<Video> videos = List<Video>();
    videos = json.map((video) => Video.fromJson(video)).toList();

    return VideoList(
      videos: videos,
    );
  }
}

class Video {
  String id;
  String name;
  String url;
  String status;

  Video({
    this.id,
    this.name,
    this.url,
    this.status,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
    id: json["_id"],
    name: json["name"],
    url: json["url"],
    status: json["status"],
  );

  factory Video.fromMap(Map<String, dynamic> json) => Video(
    id: json["id"],
    name: json["name"],
    url: json["url"],
    status: json["status"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "url": url,
    "status": status,
  };

}