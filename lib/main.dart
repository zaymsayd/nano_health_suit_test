import 'package:flutter/material.dart';
import 'providers/auth_provider.dart';
import 'providers/constants.dart';
import 'providers/product_provder.dart';
import 'screens/splash_screen.dart';
import 'styles/colors.dart';
import 'utils/sizeconfig.dart';
import 'package:provider/provider.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AuthProvider()),
    ChangeNotifierProvider(create: (_) => ProductProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: NanoColors.primaryColor),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        appBarTheme: const AppBarTheme(color: Colors.white),
        useMaterial3: true,
      ),
      navigatorKey: navigatorKey,
      home: const SplashScreen(),
    );
  }
}
