class Room {
  static const String COLLECTION_NAME = "rooms";
  String id;
  String title;
  String description;
  String categoryId;

  Room(
      {this.id = "",
      required this.title,
      required this.description,
      required this.categoryId});

  Room.fromJson(Map<String, dynamic> json)
      : this(
            id: json["id"],
            title: json["title"],
            description: json["description"],
            categoryId: json["categoryId"]);

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "categoryId": categoryId
    };
  }
}
