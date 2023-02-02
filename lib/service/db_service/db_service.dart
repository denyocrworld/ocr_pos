import 'package:hyper_ui/core.dart';
import 'package:hyper_ui/service/product_service/product_service.dart';

import '../order_service/order_service_util.dart';

class DbService {
  static save() async {
    await mainStorage.put("products", ProductService.products);
    await mainStorage.put("orders", OrderService.orders);
  }

  static load() async {
    ProductService.products = mainStorage.get("products") ?? [];
    OrderService.orders = mainStorage.get("orders") ?? [];
  }
}
