import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/user_service.dart';

class UserProvider with ChangeNotifier {
  final _userService = UserService();
  UserModel? _userModel;
  UserModel? get userModel => _userModel;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  checkLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<bool> user() async {
    checkLoading(true);

    try {
      final data = await _userService.user();

      _userModel = data;
      checkLoading(false);

      return true;
    } catch (e) {
      checkLoading(false);

      return false;
    }
  }
}
