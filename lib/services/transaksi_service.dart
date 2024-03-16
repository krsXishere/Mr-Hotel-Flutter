import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:mr_hotel/models/transaksi_model.dart';
import '../common/constant.dart';

class TransaksiService {
  AndroidOptions _getAndroidOptions() {
    return const AndroidOptions(
      encryptedSharedPreferences: true,
    );
  }

  Future<TransaksiModel> create(
    String totalBayar,
    String checkIn,
    String checkOut,
    String kamarId,
  ) async {
    final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
    String apiURL = "${baseAPIURL()}/create-transaksi";
    String? token = await storage.read(
      key: "token",
      aOptions: _getAndroidOptions(),
    );

    try {
      var response = await post(
        Uri.parse(apiURL),
        headers: header(
          true,
          token: token,
        ),
        body: {
          'total_bayar': totalBayar,
          'check_in': checkIn,
          'check_out': checkOut,
          'kamar_id': kamarId,
        },
      );

      // print("Euy: ${jsonDecode(response.body)}");

      if (response.statusCode == 200) {
        var jsonObject = jsonDecode(response.body);
        // print(jsonObject);

        return TransaksiModel.fromJson(jsonObject['data']);
      } else {
        var jsonObject = jsonDecode(response.body);
        // print(jsonObject);
        throw Exception("Sign In Gagal. Error: $jsonObject");
      }
    } catch (e) {
      // print(e);
      throw Exception("Sign In Gagal. Error: $e");
    }
  }

  Future<List<TransaksiModel>> transaksi() async {
    final storage = FlutterSecureStorage(aOptions: _getAndroidOptions());
    String apiURL = "${baseAPIURL()}/transaksi";
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
          return TransaksiModel(
            id: object['id'],
            tanggal: object['tanggal'],
            totalBayar: object['total_bayar'],
            checkIn: object['check_in'],
            checkOut: object['check_out'],
            userId: object['user_id'],
            kamarId: object['kamar_id'],
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
