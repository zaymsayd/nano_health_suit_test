import 'package:flutter/material.dart';
import 'package:nano_health_suit_test/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: () {
            context.read<AuthProvider>().signOut();
          },
          child: const Text("SIGN OUT")),
    );
  }
}
