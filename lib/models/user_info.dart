class UserInfo {
  String image;
  String name;
  String email;

  // Constructor
  UserInfo({
    required this.image,
    required this.name,
    required this.email,
  });

  UserInfo copy({
    String? imagePath,
    String? name,
    String? phone,
    String? email,
    String? about,
  }) =>
      UserInfo(
        image: imagePath ?? image,
        name: name ?? this.name,
        email: email ?? this.email,
      );

  static UserInfo fromJson(Map<String, dynamic> json) => UserInfo(
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
