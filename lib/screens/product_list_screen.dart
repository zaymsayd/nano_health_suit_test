import 'package:flutter/material.dart';
import 'package:nano_health_suit_test/providers/product_provder.dart';
import 'package:nano_health_suit_test/repo/models/product.dart';
import 'package:nano_health_suit_test/screens/widgets/product_item.dart';
import 'package:nano_health_suit_test/styles/colors.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/sizeconfig.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductProvider>(context, listen: false).fetchProductList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, SizeConfig.smallestSize * 12),
        child: Container(
            padding: EdgeInsets.only(top: SizeConfig.smallestSize * 6),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 4,
                      blurRadius: 8)
                ],
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(35))),
            child: Center(
              child: Text("All Products",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: SizeConfig.smallestSize * 6.5,
                      fontWeight: FontWeight.bold)),
            )),
      ),
      body: Consumer<ProductProvider>(builder: (context, provider, child) {
        if (provider.isLoading) {
          return ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) => Shimmer.fromColors(
                  baseColor: Colors.grey.shade500,
                  highlightColor: Colors.grey.shade100,
                  child: ProductItemWidget(
                    product: Product(),
                  )));
        } else {
          return ListView.builder(
            itemCount: provider.productList?.length,
            itemBuilder: (BuildContext context, int index) =>
                ProductItemWidget(product: provider.productList?[index]),
          );
        }
      }),
    );
  }
}
