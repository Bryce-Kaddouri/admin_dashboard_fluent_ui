class PriceHistoryModel {
  final double price;
  final DateTime date;

  PriceHistoryModel({
    required this.price,
    required this.date,
  });

  factory PriceHistoryModel.fromJson(Map<String, dynamic> json) {
    return PriceHistoryModel(
      price: double.parse(json['price'].toString()),
      date: DateTime.parse(json['date']),
    );
  }
}

class ProductPriceHistoryModel {
  final int productId;
  final DateTime productCreatedAt;
  final String productName;
  final String productImageUrl;
  final List<PriceHistoryModel> priceHistory;

  ProductPriceHistoryModel({
    required this.productId,
    required this.productCreatedAt,
    required this.priceHistory,
    required this.productImageUrl,
    required this.productName,
  });

  factory ProductPriceHistoryModel.fromJson(Map<String, dynamic> json) {
    print(json['price_history']);
    return ProductPriceHistoryModel(
      productId: json['product_id'],
      productCreatedAt: DateTime.parse(json['product_created_at']),
      productName: json['product_name'],
      productImageUrl: json['photo_url'],
      priceHistory: (json['price_history'] as List).map((e) => PriceHistoryModel.fromJson(e)).toList(),
    );
  }
}
