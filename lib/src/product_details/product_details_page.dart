import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:kushalplax/src/product_details/product_details_controller.dart';
import 'package:sizer/sizer.dart';

import '../../utils/color_constant.dart';
import '../../utils/theme.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  final ProductDetailsController productDetailsController =
  Get.put(ProductDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Product Details',
          style: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Obx(() {
                final imageUrl = productDetailsController
                    .productDetailsModel.value.image
                    .toString();

                return Column(
                  children: [
                    Card(
                      shadowColor: Colors.grey,
                      clipBehavior: Clip.antiAlias,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      color: BackgroundColor.white,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 40.h,
                            width: 100.w,
                            child: Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const SizedBox();
                              },
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                          : null,
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 1.h, horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  productDetailsController
                                      .productDetailsModel.value.title
                                      .toString(),
                                  textAlign: TextAlign.start,
                                  style: appPrimaryTheme.textTheme.headlineLarge
                                      ?.copyWith(
                                    color: TextColor.blue,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                SizedBox(
                                  width: 100.w,
                                  child: Text(
                                    productDetailsController
                                        .productDetailsModel
                                        .value
                                        .description
                                        .toString(),
                                    maxLines: 6,
                                    overflow: TextOverflow.ellipsis,
                                    style: appPrimaryTheme
                                        .textTheme.headlineMedium
                                        ?.copyWith(color: TextColor.blue),
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      productDetailsController
                                          .productDetailsModel
                                          .value
                                          .category
                                          .toString(),
                                      maxLines: 2,
                                      style: appPrimaryTheme
                                          .textTheme.headlineMedium
                                          ?.copyWith(color: TextColor.blue),
                                    ),
                                    Text(
                                      "\$ ${productDetailsController.productDetailsModel.value.price.toString()}",
                                      maxLines: 2,
                                      style: appPrimaryTheme
                                          .textTheme.headlineMedium
                                          ?.copyWith(color: TextColor.blue),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                RatingBar.builder(
                                  itemSize: 15,
                                  initialRating: productDetailsController
                                      .productDetailsModel.value.rating?.rate ?? 0.0,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  ignoreGestures: true,
                                  itemCount: 5,
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 2.0),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                    size: 2.0,
                                  ),
                                  onRatingUpdate: (rating) {},
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    )
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
