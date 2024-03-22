class UserData {
  String image;
  String name;
  String email;

  // Constructor
  UserData({
    required this.image,
    required this.name,
    required this.email,
  });

  UserData copy({
    String? imagePath,
    String? name,
    String? phone,
    String? email,
    String? about,
  }) =>
      UserData(
        image: imagePath ?? image,
        name: name ?? this.name,
        email: email ?? this.email,
      );

  static UserData fromJson(Map<String, dynamic> json) => UserData(
        image: json['imagePath'],
        name: json['name'],
        email: json['email'],
      );

  Map<String, dynamic> toJson() => {
        'imagePath': image,
        'name': name,
        'email': email,
      };
}
