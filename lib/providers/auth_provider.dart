import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nano_health_suit_test/providers/constants.dart';
import 'package:nano_health_suit_test/repo/services/api_services.dart';
import 'package:nano_health_suit_test/repo/services/app_shared_prefrences.dart';
import 'package:nano_health_suit_test/screens/home_screen.dart';
import 'package:nano_health_suit_test/screens/login_screen.dart';

class AuthProvider extends ChangeNotifier {
  final ApiServices _apiServices = ApiServices();
  bool _isObscurePassword = true;

  bool _isLoading = false;
  final _usernameController = TextEditingController(text: "mor_2314");
  final _passController = TextEditingController(text: "83r5^_");

  ///Change Loading status
  setLoadingStatus({required bool value, bool isUpdate = true}) {
    _isLoading = value;
    if (isUpdate) {
      notifyListeners();
    }
  }

  changePasswordShowStatus() {
    _isObscurePassword = !_isObscurePassword;
    notifyListeners();
  }

  void auth() async {
    setLoadingStatus(value: true);
    await Future.delayed(const Duration(seconds: 2));
    _apiServices.auth(
        username: _usernameController.text, pass: _passController.text);
    setLoadingStatus(value: false);
    await Future.delayed(const Duration(seconds: 2));
    navigatorKey.currentState?.pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()));
  }

  void signOut() {
    AppSharedPreference sharedPreference = AppSharedPreference();
    sharedPreference.clearAll();
    navigatorKey.currentState
        ?.pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen()));
    notifyListeners();
  }

  TextEditingController get usernameController => _usernameController;
  TextEditingController get passController => _passController;
  bool get isLoading => _isLoading;
  bool get isObscurePassword => _isObscurePassword;
}
