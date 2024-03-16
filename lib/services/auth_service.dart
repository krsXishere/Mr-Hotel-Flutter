import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import '../common/constant.dart';
import '../models/auth_model.dart';

class AuthService {
  AndroidOptions _getAndroidOptions() {
    return const AndroidOptions(
      encryptedSharedPreferences: true,
    );
  }

  Future<AuthModel> signIn(
    String email,
    String password,
  ) async {
    final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
    String apiURL = "${baseAPIURL()}/sign-in";

    try {
      var response = await post(
        Uri.parse(apiURL),
        headers: header(false),
        body: {
          'email': email,
          'password': password,
        },
      );

      // print("Euy: ${jsonDecode(response.body)}");

      if (response.statusCode == 200) {
        var jsonObject = jsonDecode(response.body);
        await storage.write(key: 'token', value: jsonObject['data']);
        // print(jsonObject);

        return AuthModel.fromJson(jsonObject);
      } else {
        var jsonObject = jsonDecode(response.body);
        // print(jsonObject);
        return AuthModel.fromJson(jsonObject);
      }
    } catch (e) {
      // print(e);
      throw Exception("Sign In Gagal. Error: $e");
    }
  }

  Future<AuthModel> signUp(
    String nik,
    String name,
    String email,
    String password,
    String phone,
  ) async {
    final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
    String apiURL = "${baseAPIURL()}/sign-up";

    try {
      var response = await post(
        Uri.parse(apiURL),
        headers: header(false),
        body: {
          'nik': nik,
          'name': name,
          'email': email,
          'password': password,
          'phone': phone,
        },
      );

      // print("Euy: ${jsonDecode(response.body)}");

      if (response.statusCode == 200) {
        var jsonObject = jsonDecode(response.body);
        await storage.write(key: 'token', value: jsonObject['data']);
        // print(jsonObject);

        return AuthModel.fromJson(jsonObject);
      } else {
        var jsonObject = jsonDecode(response.body);
        // print(jsonObject);

        return AuthModel.fromJson(jsonObject);
      }
    } catch (e) {
      // print(e);
      throw Exception("Sign Up Gagal. Error: $e");
    }
  }

  Future<bool> signOut() async {
    final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
    String? token = await storage.read(key: "token");
    var tokenId = token?.substring(0, token.indexOf("|"));
    String apiURL = "${baseAPIURL()}/sign-out/$tokenId";

    try {
      var response = await post(
        Uri.parse(apiURL),
        headers: header(
          true,
          token: token,
        ),
      );

      if (response.statusCode == 200) {
        await storage.delete(key: "token");

        // print(response.body);

        return true;
      } else {
        // print(response.body);
        return false;
      }
    } catch (e) {
      // print(e);
      throw Exception("Sign Out Gagal.\nError: $e");
    }
  }
}
