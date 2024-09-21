class StoriesModel {
  int? currentPage;
  List<StoryData>? stories;
  int? totalPages;

  StoriesModel({this.currentPage, this.stories, this.totalPages});

  StoriesModel.fromJson(Map<String, dynamic> json) {
    if (json["currentPage"] is int) {
      currentPage = json["currentPage"];
    }
    if (json["stories"] is List) {
      stories = json["stories"] == null
          ? null
          : (json["stories"] as List)
              .map((e) => StoryData.fromJson(e))
              .toList();
    }
    if (json["totalPages"] is int) {
      totalPages = json["totalPages"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["currentPage"] = currentPage;
    if (stories != null) {
      _data["stories"] = stories?.map((e) => e.toJson()).toList();
    }
    _data["totalPages"] = totalPages;
    return _data;
  }
}

class StoryData {
  String? id;
  String? title;
  String? thumbnail;
  String? content;

  StoryData({this.id, this.title, this.thumbnail, this.content});

  StoryData.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["thumbnail"] is String) {
      thumbnail = json["thumbnail"];
    }
    if (json["content"] is String) {
      content = json["content"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["title"] = title;
    _data["thumbnail"] = thumbnail;
    _data["content"] = content;
    return _data;
  }
}
