import 'package:flutter/material.dart';
import 'package:furutsu_x_fruitbase/controllers/popular_product_controller.dart';
import 'package:furutsu_x_fruitbase/pages/Food/popular_food_detail.dart';
import 'package:furutsu_x_fruitbase/pages/Food/recommended_food_detail.dart';
import 'package:furutsu_x_fruitbase/pages/cart/cart_page.dart';
import 'package:furutsu_x_fruitbase/pages/home/food_page_body.dart';
import 'package:furutsu_x_fruitbase/pages/home/main._food_page.dart';
import 'package:furutsu_x_fruitbase/routes/routes_helper.dart';
import 'package:get/get.dart';
import 'controllers/recommended_product_controller.dart';
import 'helper/dependencies.dart' as dep;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>().getPopularProductList();
    Get.find<RecommendedProductController>().getRecommendedProductList();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Furutsu x FruitBased',
      //home: MainFoodPage(),
      initialRoute: RouteHelper.getInitial(),
      getPages: RouteHelper.routes,
    );
  }
}
