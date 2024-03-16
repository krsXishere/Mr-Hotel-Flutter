class AuthModel {
  int? status;
  String? message, data;

  AuthModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AuthModel.fromJson(Map<String, dynamic> object) {
    return AuthModel(
      status: object['status'],
      message: object['message'],
      data: object['data'],
    );
  }
}
