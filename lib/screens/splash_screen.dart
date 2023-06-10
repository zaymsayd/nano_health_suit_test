import 'package:flutter/material.dart';
import 'package:nano_health_suit_test/providers/constants.dart';
import 'package:nano_health_suit_test/repo/services/app_shared_prefrences.dart';
import 'package:nano_health_suit_test/screens/home_screen.dart';
import 'package:nano_health_suit_test/screens/login_screen.dart';
import 'package:nano_health_suit_test/utils/sizeconfig.dart';

import '../styles/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    routeToScreen();
  }

  routeToScreen() async {
    AppSharedPreference sharedPreference = AppSharedPreference();
    String? token = await sharedPreference.getString('user-token');
    Future.delayed(const Duration(seconds: 2)).then((value) {
      if (token.isEmpty) {
        navigatorKey.currentState
            ?.pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen()));
      } else {
        navigatorKey.currentState?.pushReplacement(
            MaterialPageRoute(builder: (_) => HomeScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: SizeConfig.safeBlockHorizontal * 100,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [NanoColors.primaryDark, NanoColors.primaryColor]),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.asset("assets/images/logo_full.png",
                  fit: BoxFit.fitHeight, scale: 2),
            ),
          ],
        ),
      ),
    );
  }
}
