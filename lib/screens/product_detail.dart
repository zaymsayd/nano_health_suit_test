import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nano_health_suit_test/providers/product_provder.dart';
import 'package:nano_health_suit_test/styles/colors.dart';
import 'package:nano_health_suit_test/utils/sizeconfig.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool _showReview = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) => Stack(
          children: [
            Hero(
              tag: '${provider.selectedProduct?.id}_${provider.selectedProduct?.title}',
              child: AspectRatio(
                aspectRatio: 2 / 3,
                child: Image.network(
                  provider.selectedProduct?.image ??
                      "https://cdn4.iconfinder.com/data/icons/refresh_cl/256/System/Box_Empty.png",
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            AspectRatio(
              aspectRatio: 2 / 3,
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Colors.black.withOpacity(0.5),
                      Colors.black.withOpacity(0.5),
                      Colors.transparent,
                      Colors.transparent,
                      Colors.transparent,
                      Colors.transparent,
                      Colors.white.withOpacity(0.5),
                      Colors.white.withOpacity(0.5),
                    ])),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              provider.closeProductDetail();
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)),
                              child: const Icon(Icons.arrow_back, size: 32),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {

                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)),
                              child: const Icon(Icons.more_vert, size: 32),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, left: 9),
                    child: Text(
                      provider.selectedProduct?.title ?? "Detail",
                      style: const TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0),
                    child: Text("${provider.selectedProduct?.price ?? 0} AED",
                        style: const TextStyle(
                            color: Color(0xFF2A404B), fontSize: 32)),
                  ),
                  AnimatedContainer(
                    duration: const Duration(seconds: 2),
                    curve: Curves.easeIn,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 4,
                              spreadRadius: 4)
                        ],
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(36))),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _showReview = !_showReview;
                              });
                            },
                            child: Icon(
                              _showReview
                                  ? Icons.keyboard_arrow_down_sharp
                                  : Icons.keyboard_arrow_up_sharp,
                              color: NanoColors.primaryColor,
                              size: 36,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(.4),
                                                  spreadRadius: 3,
                                                  blurStyle: BlurStyle.outer,
                                                  blurRadius: 6),
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.white),
                                        child: const Icon(
                                          CupertinoIcons.share_up,
                                          color: NanoColors.primaryColor,
                                        ),
                                      ),
                                    ),
                                    MaterialButton(
                                      onPressed: () {},
                                      minWidth: SizeConfig.smallestSize * 70,
                                      height: SizeConfig.smallestSize * 16,
                                      color: NanoColors.primaryColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(43)),
                                      child: const Text(
                                        "Order Now",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                    ),
                                  ]),
                               SizedBox(
                                height: SizeConfig.smallestSize * 4,
                              ),
                              const Text(
                                "Description",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    fontStyle: FontStyle.italic),
                              ),
                               SizedBox(
                                height: SizeConfig.smallestSize * 3,
                              ),
                              Text(
                                provider.selectedProduct?.description ??
                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ",
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Visibility(
                                  visible: _showReview,
                                  child: Container(
                                    height: SizeConfig.smallestSize * 22,
                                    padding: const EdgeInsets.all(8),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: const Color(0xFFF1F1F1),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 4.0),
                                            child: Text(
                                              "Reviews (${provider.selectedProduct?.rating?.count ?? 0})",
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: Color(0xFF444B51),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          Row(
                                            children: [
                                              const SizedBox(
                                                width: 21,
                                              ),
                                              Text(
                                                "${provider.selectedProduct?.rating?.rate ?? 0}",
                                                style: const TextStyle(
                                                    fontSize: 32,
                                                    color: Color(0xFF444B51),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                width: 30,
                                              ),
                                              RatingBar.builder(
                                                  initialRating: provider
                                                          .selectedProduct
                                                          ?.rating
                                                          ?.rate ??
                                                      0,
                                                  itemSize: 26,
                                                  ignoreGestures: true,
                                                  allowHalfRating: true,
                                                  unratedColor: Colors.white
                                                      .withOpacity(0.7),
                                                  itemBuilder: (context, _) =>
                                                      const Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                      ),
                                                  onRatingUpdate: (rating) {}),
                                            ],
                                          ),
                                        ]),
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
