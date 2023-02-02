import 'package:hyper_ui/service/db_service/db_service.dart';

class ProductService {
  static List products = [];
  static add(Map product) {
    product["id"] = DateTime.now().microsecondsSinceEpoch;
    products.add(product);
    DbService.save();
  }

  static delete(Map product) {
    products.remove(product);
    DbService.save();
  }

  static update({
    required int id,
    required Map value,
  }) {
    var index = products.indexWhere((product) => product["id"] == id);
    products[index] = value;
    DbService.save();
  }

  static clearQtyFromProducts() {
    for (var product in products) {
      product["qty"] = 0;
    }
  }
}
