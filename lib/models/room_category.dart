class RoomCategory {
  static String sportsId = 'sports';
  static String musicId = 'music';
  static String moviesId = 'movies';
  String id;
  late String name;
  late String image;

  RoomCategory(this.id, this.name, this.image);

  RoomCategory.fromId(this.id) {
    name = id;
    image = "assets/images/$id.png";
  }

  static List<RoomCategory> getCategoryList() {
    return [
      RoomCategory.fromId(sportsId),
      RoomCategory.fromId(moviesId),
      RoomCategory.fromId(musicId),
    ];
  }
}
