import 'package:flutter/material.dart';
import 'package:mr_hotel/models/kamar_model.dart';
import 'package:mr_hotel/services/kamar_service.dart';

class KamarProvider with ChangeNotifier {
  final _kamarService = KamarService();
  List<KamarModel> _kamars = [];
  List<KamarModel> get kamars => _kamars;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  checkLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<bool> kamar() async {
    checkLoading(true);

    try {
      final data = await _kamarService.kamar();

      _kamars = data;
      checkLoading(false);

      return true;
    } catch (e) {
      checkLoading(false);

      return false;
    }
  }
}
