import 'package:flutter/material.dart';
import 'package:nano_health_suit_test/providers/product_provder.dart';
import 'package:nano_health_suit_test/screens/product_list_screen.dart';
import 'package:nano_health_suit_test/screens/profile_screen.dart';
import 'package:provider/provider.dart';

import '../styles/colors.dart';
import 'cart_screen.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProductProvider>(builder: (context, provider, child) {
        switch (provider.selectedIndex) {
          case 0:
            child = ProductListScreen();
            break;
          case 1:
            child = CartScreen();
            break;
          case 2:
            child = FavoritesScreen();
            break;
          case 3:
            child = ProfileScreen();
            break;
          default:
            child = ProductListScreen();
        }
        return child;
      }
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
        child: BottomNavigationBar(
            selectedItemColor: NanoColors.primaryColor,
            unselectedItemColor: Colors.grey,
            onTap: (value){
              context.read<ProductProvider>().changeScreen(value);
            },
            currentIndex: context.watch<ProductProvider>().selectedIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: "Products",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined),
                label: "Cart",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border_rounded),
                label: "Favorites",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline_rounded),
                label: "Profile",
              ),
            ]),
      ),
    );
  }
}
