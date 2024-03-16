import 'package:flutter/material.dart';
import 'package:mr_hotel/models/transaksi_model.dart';
import 'package:mr_hotel/services/transaksi_service.dart';

class TransaksiProvider with ChangeNotifier {
  final _transaksiService = TransaksiService();
  List<TransaksiModel> _transaksis = [];
  List<TransaksiModel> get transaksis => _transaksis;
  TransaksiModel? _transaksiModel;
  TransaksiModel? get transaksiModel => _transaksiModel;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  int _totalHari = 0;
  int get totalHari => _totalHari;
  int _totalBayar = 0;
  int get totalBayar => _totalBayar;
  DateTimeRange? _date;
  DateTimeRange? get date => _date;

  checkLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  checkTotalHari(
    int value,
    int hargaKamar,
  ) {
    _totalHari = value;
    checkTotalBayar(hargaKamar);
    notifyListeners();
  }

  checkTotalBayar(int hargaKamar) {
    int biayaAdmin = 10000;
    _totalBayar = (hargaKamar * _totalHari) + biayaAdmin;
  }

  checkDateTimeRange(DateTimeRange? value) {
    _date = value;
    notifyListeners();
  }

  deleteDataReservasi() {
    _totalHari = 0;
    _totalBayar = 0;
    notifyListeners();
  }

  Future<bool> create(
    String kamarId,
  ) async {
    checkLoading(true);

    try {
      final data = await _transaksiService.create(
        _totalBayar.toString(),
        _date!.start.toString(),
        _date!.end.toString(),
        kamarId,
      );

      _transaksiModel = data;
      checkLoading(false);
      return true;
    } catch (e) {
      checkLoading(false);
      return false;
    }
  }

  Future<bool> transaksi() async {
    checkLoading(true);

    try {
      final data = await _transaksiService.transaksi();

      _transaksis = data;
      deleteDataReservasi();
      checkLoading(false);

      return true;
    } catch (e) {
      checkLoading(false);

      return false;
    }
  }
}
