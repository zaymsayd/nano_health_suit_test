import 'package:flutter/material.dart';
import 'package:nano_health_suit_test/screens/widgets/login_form.dart';
import 'package:nano_health_suit_test/styles/colors.dart';
import 'package:nano_health_suit_test/utils/sizeconfig.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Flexible(
            flex: 1,
            child: Container(
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
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: SizeConfig.smallestSize * 9,
                            bottom: SizeConfig.smallestSize * 7),
                        child: Text(
                          "Log In",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.smallestSize * 8),
                        ),
                      )),
                ],
              ),
            )),
        Flexible(flex: 1, child: LoginForm())
      ]),
    );
  }
}
