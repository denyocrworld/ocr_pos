import 'package:hyper_ui/service/db_service/db_service.dart';
import 'package:hyper_ui/service/product_service/product_service.dart';

class OrderService {
  static List orders = [];
  static checkout({
    required String paymentMethod,
    required List items,
    required double total,
  }) {
    orders.add({
      "id": DateTime.now().microsecondsSinceEpoch,
      "created_at": DateTime.now(),
      "payment_method": paymentMethod,
      "items": items,
      "total": total,
    });

    ProductService.clearQtyFromProducts();
    DbService.save();
  }
}
