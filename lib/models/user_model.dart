class UserModel {
  int? id;
  String? name, email, emailVerifiedAt, profilePhotoURL, createdAt, updatedAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.profilePhotoURL,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> object) {
    return UserModel(
      id: object['id'] ?? 0,
      name: object['name'] ?? "",
      email: object['email'] ?? "",
      emailVerifiedAt: object['email_verified_at'] ?? "",
      profilePhotoURL: object['profile_photo_url'] ?? "",
      createdAt: object['created_at'] ?? "",
      updatedAt: object['updated_at'] ?? "",
    );
  }
}
