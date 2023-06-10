import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nano_health_suit_test/providers/constants.dart';
import 'package:nano_health_suit_test/repo/models/product.dart';
import 'package:nano_health_suit_test/repo/services/api_services.dart';
import 'package:nano_health_suit_test/screens/product_detail.dart';

class ProductProvider extends ChangeNotifier {
  final ApiServices _apiServices = ApiServices();
  List<Product?>? _productList = [];
  Product? _selectedProduct;
  bool _isLoading = false;

  int _selectedIndex = 0;

  ///Change Loading status
  setLoadingStatus({required bool value, bool isUpdate = true}) {
    _isLoading = value;
    if (isUpdate) {
      notifyListeners();
    }
  }

  void closeProductDetail() {
    _selectedProduct = null;

    navigatorKey.currentState?.pop();
    notifyListeners();
  }

  void changeScreen(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void fetchProductList() async {
    setLoadingStatus(value: true);
    _productList = await _apiServices.fetchProductList();
    setLoadingStatus(value: false);
    notifyListeners();
  }

  void fetchProductDetail(int productID) async {
    setLoadingStatus(value: true, isUpdate: false);
    _selectedProduct =
        await _apiServices.fetchProductDetail(productID: productID);
    setLoadingStatus(value: false);
    navigatorKey.currentState
        ?.push(MaterialPageRoute(builder: (_) => ProductDetailScreen()));

    notifyListeners();
  }

  bool get isLoading => _isLoading;
  List<Product?>? get productList => _productList;
  Product? get selectedProduct => _selectedProduct;
  int get selectedIndex => _selectedIndex;
}
