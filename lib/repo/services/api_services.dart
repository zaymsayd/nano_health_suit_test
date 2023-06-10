import 'dart:convert';

import 'package:nano_health_suit_test/repo/error.dart';
import 'package:nano_health_suit_test/repo/services/app_shared_prefrences.dart';
import 'package:sprintf/sprintf.dart';
import '../models/product.dart';
import '../network_util.dart';

class ApiServices {
  static const String baseURL = "https://fakestoreapi.com/";

  static const String authAPI = "auth/login";
  static const String productListAPI = "products";
  static const String productDetailAPI = "products/%d";

  final NetworkUtil _networkUtil = NetworkUtil();
  final AppSharedPreference _sharedPreference = AppSharedPreference();

  void auth({required String username, required String pass}) async {
    var headers = <String, String>{};
    var body = <String, dynamic>{};
    body["username"] = username;
    body["password"] = pass;
    Future<ParsedResponse> future =
        _networkUtil.post(baseURL + authAPI, body: body, headers: headers);
    future.then((ParsedResponse response) {
      if (response.isOk()) {
        var res = json.decode(response.response);
        _sharedPreference.setString("user-token", res['token']);
      } else {
        throw NHSError(response.statusCode, "BAD REQUEST");
      }
    }).catchError((error) {
      throw error;
    });
  }

  Future<List<Product?>?> fetchProductList() async {
    Future<ParsedResponse> future = _networkUtil.get(baseURL + productListAPI);
    return future.then((ParsedResponse response) {
      if (response.isOk()) {
        var products = productFromJson(response.response);
        return products;
      } else {
        return <Product>[];
      }
    }).catchError((error) {
      throw error;
    });
  }

  Future<Product?> fetchProductDetail({required int productID}) async {
    Future<ParsedResponse> future =
        _networkUtil.get(baseURL + sprintf(productDetailAPI, [productID]));
    return future.then((ParsedResponse response) {
      if (response.isOk()) {
        var product = Product.fromJson(json.decode(response.response));
        return product;
      } else {
        throw NHSError(response.statusCode, "BAD REQUEST");
      }
    }).catchError((error) {
      throw error;
    });
  }
}
