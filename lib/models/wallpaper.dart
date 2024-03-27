class Wallpaper {
  int id;
  String title;
  String url;
  String author;

  // Constructor
  Wallpaper({
    required this.id,
    required this.title,
    required this.url,
    required this.author,
  });

  Wallpaper copy({
    required int id,
    required String title,
    required String url,
    required String author,
  }) =>
      Wallpaper(id: id, title: title, url: url, author: author);

  static Wallpaper fromJson(Map<String, dynamic> json) => Wallpaper(
        id: json['id'],
        title: json['title'],
        url: json['url'],
        author: json['author'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'url': url,
        'author': author,
      };
}
