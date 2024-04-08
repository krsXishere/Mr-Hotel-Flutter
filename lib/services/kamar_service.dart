import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:mr_hotel/models/kamar_model.dart';
import '../common/constant.dart';

class KamarService {
  AndroidOptions _getAndroidOptions() {
    return const AndroidOptions(
      encryptedSharedPreferences: true,
    );
  }

  Future<List<KamarModel>> kamar() async {
    final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
    String apiURL = "${baseAPIURL()}/kamar";
    String? token = await storage.read(
      key: "token",
      aOptions: _getAndroidOptions(),
    );

    try {
      var response = await get(
        Uri.parse(apiURL),
        headers: header(true, token: token),
      );

      if (response.statusCode == 200) {
        var jsonObject = jsonDecode(response.body);
        // print(jsonObject);

        var dataList = jsonObject['data'] as List;
        final rooms = dataList.map((object) {
          return KamarModel(
            id: object['id'],
            noKamar: object['no_kamar'],
            kelasKamar: object['kelas_kamar'],
            hargaKamar: object['harga_kamar'],
            statusKamar: object['status_kamar'],
            image: object['image'],
            createdAt: object['created_at'],
            updatedAt: object['updated_at'],
          );
        }).toList();

        return rooms;
      } else {
        // var jsonObject = jsonDecode(response.body);
        // print(jsonObject);
        return [];
      }
    } catch (e) {
      // print(e);
      throw Exception("Gagal. Error: $e");
    }
  }
}
