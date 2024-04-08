import '../../data/model/product_model.dart';

class UpdateProductParam {
  final ProductModel productModel;
  bool savePriceHistory;

  UpdateProductParam({
    required this.productModel,
    required this.savePriceHistory,
  });
}
