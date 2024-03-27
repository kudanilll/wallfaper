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
    required String imagePath,
    required String name,
    required String email,
  }) =>
      UserInfo(image: imagePath, name: name, email: email);

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
