import 'package:flutter/material.dart';
import '../models/auth_model.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final _authService = AuthService();
  AuthModel? _authModel;
  AuthModel? get authModel => _authModel;
  bool _isObsecure = true;
  bool get isObsecure => _isObsecure;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isObsecureConfirmation = true;
  bool get isObsecureConfirmation => _isObsecureConfirmation;

  checkObsecure() {
    _isObsecure = !_isObsecure;
    notifyListeners();
  }

  checkObsecureConfirmation() {
    _isObsecureConfirmation = !_isObsecureConfirmation;
    notifyListeners();
  }

  checkLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<bool> signIn(
    String email,
    String password,
  ) async {
    checkLoading(true);

    try {
      final data = await _authService.signIn(
        email,
        password,
      );

      _authModel = data;
      checkLoading(false);

      return true;
    } catch (e) {
      checkLoading(false);

      return false;
    }
  }

  Future<bool> signUp(
    String nik,
    String name,
    String email,
    String password,
    String phone,
  ) async {
    checkLoading(true);

    try {
      final data = await _authService.signUp(
        nik,
        name,
        email,
        password,
        phone,
      );

      _authModel = data;
      checkLoading(false);

      return true;
    } catch (e) {
      checkLoading(false);

      return false;
    }
  }

  Future<bool> signOut() async {
    checkLoading(true);

    try {
      checkLoading(false);

      return await _authService.signOut();
    } catch (e) {
      Exception("Error: $e");
      checkLoading(false);

      return true;
    }
  }
}
