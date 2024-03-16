import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import '../common/constant.dart';
import '../models/user_model.dart';

class UserService {
  AndroidOptions _getAndroidOptions() {
    return const AndroidOptions(
      encryptedSharedPreferences: true,
    );
  }

  Future<UserModel> user() async {
    final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
    String apiURL = "${baseAPIURL()}/user";
    String? token = await storage.read(
      key: "token",
      aOptions: _getAndroidOptions(),
    );

    try {
      var response = await get(
        Uri.parse(apiURL),
        headers: header(
          true,
          token: token,
        ),
      );

      if (response.statusCode == 200) {
        var jsonObject = jsonDecode(response.body);
        // print(jsonObject);

        return UserModel.fromJson(jsonObject['data']);
      } else {
        var jsonObject = jsonDecode(response.body);
        // print(jsonObject);
        throw Exception("Gagal. $jsonObject");
      }
    } catch (e) {
      // print(e);
      throw Exception("Gagal.");
    }
  }
}
