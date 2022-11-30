import 'package:furutsu_x_fruitbase/pages/Food/popular_food_detail.dart';
import 'package:furutsu_x_fruitbase/pages/Food/recommended_food_detail.dart';
import 'package:furutsu_x_fruitbase/pages/home/main._food_page.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class RouteHelper {
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";

  static String getInitial() => '$initial';
  static String getPopularFood(int pageId) => '$popularFood?pageId=$pageId';
  static String getRecommendedFood() => '$recommendedFood';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => MainFoodPage()),
    GetPage(
        name: popularFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          return PopularFoodDetail(pageId: int.parse(pageId!));
        },
        transition: Transition.fadeIn),
    GetPage(
        name: recommendedFood,
        page: () {
          return RecommendedFoodDetail();
        },
        transition: Transition.fadeIn),
  ];
}
