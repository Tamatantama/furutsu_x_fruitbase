import 'package:furutsu_x_fruitbase/models/products_model.dart';
import 'package:get/get.dart';

import '../data/repository/recommended_product_repo.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({required this.recommendedProductRepo});
  List<dynamic> _recommendedProductList = [];
  List<dynamic> get recommendedProductList => _recommendedProductList;

  bool _isloaded = false;
  bool get isloaded => _isloaded;

  Future<void> getRecommendedProductList() async {
    Response response =
        await recommendedProductRepo.getRecommendedProductList();
    if (response.statusCode == 200) {
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      _isloaded = true;

      update();
    } else {}
  }
}
