import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:furutsu_x_fruitbase/controllers/cart_controller.dart';
import 'package:furutsu_x_fruitbase/controllers/popular_product_controller.dart';
import 'package:furutsu_x_fruitbase/pages/cart/cart_page.dart';
import 'package:furutsu_x_fruitbase/pages/home/main._food_page.dart';
import 'package:furutsu_x_fruitbase/utils/app_constants.dart';
import 'package:furutsu_x_fruitbase/utils/dimensions.dart';
import 'package:furutsu_x_fruitbase/widgets/app_column.dart';
import 'package:furutsu_x_fruitbase/widgets/app_icon.dart';
import 'package:furutsu_x_fruitbase/widgets/expendable_text.dart';
import 'package:get/get.dart';

import '../../routes/routes_helper.dart';
import '../../widgets/Big_text.dart';
import '../../widgets/icon_and_text_widget.dart';
import '../../widgets/small_text.dart';
import '../../utils/colors.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const PopularFoodDetail({Key? key, required this.pageId, required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.popularFoodImg,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(AppConstants.BASE_URL +
                            AppConstants.UPLOAD_URL +
                            product.img!))),
              )),
          Positioned(
              top: Dimensions.height45,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        if (page == "cartpage") {
                          Get.toNamed(RouteHelper.getCartPage());
                        } else {
                          Get.toNamed(RouteHelper.getInitial());
                        }
                      },
                      child: AppIcon(icon: Icons.arrow_back_ios)),
                  GetBuilder<PopularProductController>(builder: (controller) {
                    return GestureDetector(
                      onTap: () {
                        if (controller.totalItems >= 1)
                          Get.toNamed(RouteHelper.getCartPage());
                      },
                      child: Stack(
                        children: [
                          AppIcon(icon: Icons.shopping_cart_checkout_outlined),
                          controller.totalItems >= 1
                              ? Positioned(
                                  right: 0,
                                  top: 0,
                                  child: AppIcon(
                                      icon: Icons.circle,
                                      size: 20,
                                      iconColor: Colors.transparent,
                                      backgroundcColor: AppColors.mainColor),
                                )
                              : Container(),
                          Get.find<PopularProductController>().totalItems >= 1
                              ? Positioned(
                                  right: 3,
                                  top: 0,
                                  child: BigText(
                                      text: Get.find<PopularProductController>()
                                          .totalItems
                                          .toString(),
                                      size: 12,
                                      color: Colors.white),
                                )
                              : Container()
                        ],
                      ),
                    );
                  })
                ],
              )),
          Positioned(
              left: 0,
              right: 0,
              top: Dimensions.popularFoodImg - 20,
              child: Container(
                  padding: EdgeInsets.only(
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      top: Dimensions.height20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimensions.radius20),
                          topRight: Radius.circular(Dimensions.radius20)),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppColumn(text: product.name!),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      BigText(text: "Introduce"),
                      SizedBox(height: Dimensions.height20),
                      SingleChildScrollView(
                          child: ExpendableText(text: product.description!)),
                    ],
                  )))
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (popularProduct) {
          return Container(
            height: 120,
            padding: EdgeInsets.only(
              top: Dimensions.height30,
              bottom: Dimensions.height30,
              left: Dimensions.width20,
              right: Dimensions.width20,
            ),
            decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20 * 2),
                    topRight: Radius.circular(Dimensions.radius20 * 2))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height20,
                      bottom: Dimensions.height20,
                      left: Dimensions.width20,
                      right: Dimensions.width20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: Colors.white),
                  child: Row(children: [
                    GestureDetector(
                      onTap: () {
                        popularProduct.setQuantity(false);
                      },
                      child: Icon(
                        Icons.remove,
                        color: AppColors.signColor,
                      ),
                    ),
                    SizedBox(width: Dimensions.width10 / 2),
                    BigText(text: popularProduct.inCartItem.toString()),
                    SizedBox(width: Dimensions.width10 / 2),
                    GestureDetector(
                        onTap: () {
                          popularProduct.setQuantity(true);
                        },
                        child: Icon(Icons.add, color: AppColors.signColor))
                  ]),
                ),
                GestureDetector(
                  onTap: () {
                    popularProduct.addItem(product);
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        top: Dimensions.height20,
                        bottom: Dimensions.height20,
                        left: Dimensions.width20,
                        right: Dimensions.width20),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        color: AppColors.mainColor),
                    child: BigText(
                      text: "Rp. ${product.price!}K | Add to Cart",
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
