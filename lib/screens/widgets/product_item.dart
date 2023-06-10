import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nano_health_suit_test/providers/product_provder.dart';
import 'package:provider/provider.dart';
import '../../repo/models/product.dart';
import '../../utils/sizeconfig.dart';
import '../product_detail.dart';

class ProductItemWidget extends StatelessWidget {
  final Product? product;
  const ProductItemWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<ProductProvider>(context, listen: false)
            .fetchProductDetail(product?.id ?? -1);
      },
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.smallestSize * 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: '${product?.id}_${product?.title}',
              child: Container(
                height: SizeConfig.smallestSize * 52,
                width: SizeConfig.smallestSize * 95,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 1,
                      )
                    ],
                    image: DecorationImage(
                        image: NetworkImage(product?.image ??
                            "https://cdn4.iconfinder.com/data/icons/refresh_cl/256/System/Box_Empty.png"),
                        fit: BoxFit.cover)),
                child: Stack(
                  children: [
                    Container(
                      height: SizeConfig.smallestSize * 52,
                      width: SizeConfig.smallestSize * 95,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                              begin: Alignment.center,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.transparent,
                                Colors.black.withOpacity(0.5)
                              ])),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10.0, left: 10),
                        child: Text(
                          product?.price != null
                              ? "${product?.price ?? 0} AED"
                              : "",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10.0, right: 10),
                        child: RatingBar.builder(
                            initialRating: product?.rating?.rate ?? 0,
                            itemSize: 24,
                            allowHalfRating: true,
                            ignoreGestures: true,
                            unratedColor: Colors.white.withOpacity(0.7),
                            itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                            onRatingUpdate: (rating) {}),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            Text(
              product?.title ?? "",
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontStyle: FontStyle.italic, fontSize: 15),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              product?.description ?? "",
              style: const TextStyle(fontStyle: FontStyle.normal, fontSize: 15),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
