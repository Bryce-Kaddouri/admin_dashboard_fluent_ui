import 'package:intl/intl.dart';

class PriceHelper {
  static String getFormattedPrice(double price, {bool showBefore = true, String currency = '\$'}) {
    // 1.2 -> 1.20
    // 1 -> 1.00

    final formatter = NumberFormat.simpleCurrency(
      locale: 'en_US',
      name: currency,
    );
    return formatter.format(price);
  }
}
