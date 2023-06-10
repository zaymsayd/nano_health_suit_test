import 'package:flutter/material.dart';
import 'package:nano_health_suit_test/providers/auth_provider.dart';
import 'package:nano_health_suit_test/screens/product_list_screen.dart';
import 'package:nano_health_suit_test/styles/colors.dart';
import 'package:nano_health_suit_test/utils/sizeconfig.dart';
import 'package:provider/provider.dart';

import 'nano_login_text_field.dart';

class LoginForm extends StatefulWidget {
  LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(SizeConfig.smallestSize * 5),
      child: Consumer<AuthProvider>(
        builder: (context, provider, child) => SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              NanoLoginTextField(
                  controller: provider.usernameController, label: "Email"),
              NanoLoginTextField(
                  controller: provider.passController,
                  label: "Password",
                  obscureText: provider.isObscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.remove_red_eye_outlined,
                      color: provider.isObscurePassword
                          ? Colors.grey
                          : NanoColors.primaryColor,
                    ),
                    onPressed: () {
                      provider.changePasswordShowStatus();
                    },
                  )),
              SizedBox(
                height: SizeConfig.smallestSize * 5,
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
                height: SizeConfig.smallestSize * 16,
                width: provider.isLoading ? SizeConfig.smallestSize * 16 : SizeConfig.smallestSize * 95,
                decoration: BoxDecoration(
                    color: NanoColors.primaryColor,
                    borderRadius: BorderRadius.circular(62)),
                child: provider.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(color: Colors.white))
                    : MaterialButton(
                        onPressed: () {
                          provider.auth();
                        },
                        height: SizeConfig.smallestSize * 16,
                        minWidth: SizeConfig.smallestSize * 95,
                        color: NanoColors.primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(62)),
                        child: Text(
                          "Continue",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.smallestSize * 4),
                        ),
                      ),
              ),
              SizedBox(
                height: SizeConfig.smallestSize * 10,
              ),
              Center(
                child: InkWell(
                  child: Text(
                    "Need Help?".toUpperCase(),
                    style: TextStyle(fontSize: SizeConfig.smallestSize * 4),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
