class LearItem {
  String title;
  String img;
  String infoLink;
  LearItem({required this.title, required this.img, required this.infoLink});
  Map<String, dynamic> toJson() => {
    'title': title,
    'img': img,
    'infoLink': infoLink,
  };
  factory LearItem.fromJson(Map<String, dynamic> json) {
    return LearItem(
      title: json["title"],
      img: json["img"],
      infoLink: json["infoLink"],
    );
  }
}
