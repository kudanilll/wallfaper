import 'dart:convert';

WallpaperModel wallpaperModelFromJson(String str) =>
    WallpaperModel.fromJson(json.decode(str));

String wallpaperModelToJson(WallpaperModel data) => json.encode(data.toJson());

class WallpaperModel {
  List<FreepikModel> data;
  FreepikMeta meta;

  WallpaperModel({
    required this.data,
    required this.meta,
  });

  factory WallpaperModel.fromJson(Map<String, dynamic> json) => WallpaperModel(
        data: List<FreepikModel>.from(
          json["data"].map((x) => FreepikModel.fromJson(x)),
        ),
        meta: FreepikMeta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}

class FreepikModel {
  int id;
  String title;
  String url;
  String filename;
  List<License> licenses;
  List<dynamic> products;
  Meta meta;
  Img image;
  Related related;
  Stats stats;
  Author author;
  bool active;

  FreepikModel({
    required this.id,
    required this.title,
    required this.url,
    required this.filename,
    required this.licenses,
    required this.products,
    required this.meta,
    required this.image,
    required this.related,
    required this.stats,
    required this.author,
    required this.active,
  });

  factory FreepikModel.fromJson(Map<String, dynamic> json) => FreepikModel(
        id: json["id"],
        title: json["title"],
        url: json["url"],
        filename: json["filename"],
        licenses: List<License>.from(
            json["licenses"].map((x) => License.fromJson(x))),
        products: List<dynamic>.from(json["products"].map((x) => x)),
        meta: Meta.fromJson(json["meta"]),
        image: Img.fromJson(json["image"]),
        related: Related.fromJson(json["related"]),
        stats: Stats.fromJson(json["stats"]),
        author: Author.fromJson(json["author"]),
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "url": url,
        "filename": filename,
        "licenses": List<dynamic>.from(licenses.map((x) => x.toJson())),
        "products": List<dynamic>.from(products.map((x) => x)),
        "meta": meta.toJson(),
        "image": image.toJson(),
        "related": related.toJson(),
        "stats": stats.toJson(),
        "author": author.toJson(),
        "active": active,
      };
}

class Author {
  int id;
  String name;
  String avatar;
  String slug;

  Author({
    required this.id,
    required this.name,
    required this.avatar,
    required this.slug,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: json["id"],
        name: json["name"],
        avatar: json["avatar"],
        slug: json["slug"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "avatar": avatar,
        "slug": slug,
      };
}

class Img {
  String type;
  String orientation;
  Source source;

  Img({
    required this.type,
    required this.orientation,
    required this.source,
  });

  factory Img.fromJson(Map<String, dynamic> json) => Img(
        type: json["type"],
        orientation: json["orientation"],
        source: Source.fromJson(json["source"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "orientation": orientation,
        "source": source.toJson(),
      };
}

class Source {
  String key;
  String url;
  String size;

  Source({
    required this.key,
    required this.url,
    required this.size,
  });

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        key: json["key"],
        url: json["url"],
        size: json["size"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "url": url,
        "size": size,
      };
}

class License {
  String type;
  String url;

  License({
    required this.type,
    required this.url,
  });

  factory License.fromJson(Map<String, dynamic> json) => License(
        type: json["type"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "url": url,
      };
}

class Meta {
  DateTime publishedAt;
  bool isNew;
  AvailableFormats availableFormats;

  Meta({
    required this.publishedAt,
    required this.isNew,
    required this.availableFormats,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        publishedAt: DateTime.parse(json["published_at"]),
        isNew: json["is_new"],
        availableFormats: AvailableFormats.fromJson(json["available_formats"]),
      );

  Map<String, dynamic> toJson() => {
        "published_at": publishedAt.toIso8601String(),
        "is_new": isNew,
        "available_formats": availableFormats.toJson(),
      };
}

class AvailableFormats {
  Jpg jpg;

  AvailableFormats({
    required this.jpg,
  });

  factory AvailableFormats.fromJson(Map<String, dynamic> json) =>
      AvailableFormats(
        jpg: Jpg.fromJson(json["jpg"]),
      );

  Map<String, dynamic> toJson() => {
        "jpg": jpg.toJson(),
      };
}

class Jpg {
  int total;
  List<Item> items;

  Jpg({
    required this.total,
    required this.items,
  });

  factory Jpg.fromJson(Map<String, dynamic> json) => Jpg(
        total: json["total"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class Item {
  int size;
  int id;

  Item({
    required this.size,
    required this.id,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        size: json["size"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "size": size,
        "id": id,
      };
}

class Related {
  List<dynamic> serie;
  List<dynamic> others;
  List<dynamic> keywords;

  Related({
    required this.serie,
    required this.others,
    required this.keywords,
  });

  factory Related.fromJson(Map<String, dynamic> json) => Related(
        serie: List<dynamic>.from(json["serie"].map((x) => x)),
        others: List<dynamic>.from(json["others"].map((x) => x)),
        keywords: List<dynamic>.from(json["keywords"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "serie": List<dynamic>.from(serie.map((x) => x)),
        "others": List<dynamic>.from(others.map((x) => x)),
        "keywords": List<dynamic>.from(keywords.map((x) => x)),
      };
}

class Stats {
  int downloads;
  int likes;

  Stats({
    required this.downloads,
    required this.likes,
  });

  factory Stats.fromJson(Map<String, dynamic> json) => Stats(
        downloads: json["downloads"],
        likes: json["likes"],
      );

  Map<String, dynamic> toJson() => {
        "downloads": downloads,
        "likes": likes,
      };
}

class FreepikMeta {
  int currentPage;
  int perPage;
  int lastPage;
  int total;
  bool cleanSearch;

  FreepikMeta({
    required this.currentPage,
    required this.perPage,
    required this.lastPage,
    required this.total,
    required this.cleanSearch,
  });

  factory FreepikMeta.fromJson(Map<String, dynamic> json) => FreepikMeta(
        currentPage: json["current_page"],
        perPage: json["per_page"],
        lastPage: json["last_page"],
        total: json["total"],
        cleanSearch: json["clean_search"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "per_page": perPage,
        "last_page": lastPage,
        "total": total,
        "clean_search": cleanSearch,
      };
}
