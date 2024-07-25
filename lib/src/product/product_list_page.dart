import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:kushalplax/page_routes/page_route_constant.dart';
import 'package:kushalplax/src/product/product_list_service.dart';
import 'package:sizer/sizer.dart';
import '../../utils/theme.dart';
import 'product_list_controller.dart';
import '../../utils/color_constant.dart';

class ProductCategoryListPage extends StatefulWidget {
  const ProductCategoryListPage({super.key});

  @override
  State<ProductCategoryListPage> createState() => _ProductCategoryListPageState();
}

class _ProductCategoryListPageState extends State<ProductCategoryListPage> {
  final ProductCategoryListController productCategoryListController = Get.put(ProductCategoryListController());
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      productCategoryListController.fetchMoreProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Products',
          style: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),
        ),
      ),
      body: Obx(() {
        return ListView.builder(
          controller: _scrollController,
          itemCount: productCategoryListController.productCategoryListModel.length + (productCategoryListController.isLoading.value ? 1 : 0),
          itemBuilder: (BuildContext context, int index) {
            if (index >= productCategoryListController.productCategoryListModel.length) {
              // Show loading indicator while fetching more data
              return const Center(child: SizedBox());
            }

            final product = productCategoryListController.productCategoryListModel[index];
            return InkWell(
              onTap: () {
                Get.toNamed(PageRouteConstant.productDetailsPage, arguments: {
                  "id": product.id
                });
              },
              child: Column(
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
                          height: 20.h,
                          width: 100.w,
                          child: Image.network(
                            fit: BoxFit.cover,
                            product.image.toString(),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title.toString(),
                                textAlign: TextAlign.start,
                                style: appPrimaryTheme.textTheme.headlineLarge?.copyWith(
                                  color: TextColor.blue,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 1.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 50.w,
                                    child: Text(
                                      product.description.toString(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: appPrimaryTheme.textTheme.headlineMedium?.copyWith(color: TextColor.blue),
                                    ),
                                  ),
                                  SizedBox(width: 2.w),
                                  Column(
                                    children: [
                                      Text(
                                        product.category.toString(),
                                        maxLines: 2,
                                        style: appPrimaryTheme.textTheme.headlineMedium?.copyWith(color: TextColor.blue),
                                      ),
                                      Text(
                                        "\$ ${product.price.toString()}",
                                        maxLines: 2,
                                        style: appPrimaryTheme.textTheme.headlineMedium?.copyWith(color: TextColor.blue),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 0.5.h),
                              RatingBar.builder(
                                itemSize: 15,
                                initialRating: product.rating.rate,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                ignoreGestures: true,
                                itemCount: 5,
                                itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
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
                  SizedBox(height: 1.h)
                ],
              ),
            );
          },
        );
      }),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
